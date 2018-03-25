<?php

namespace Commerce\Adjusters;

use Commerce\Helpers\CommerceCurrencyHelper;
use Craft\Commerce_DiscountModel;
use Craft\Commerce_DiscountRecord;
use Craft\Commerce_LineItemModel;
use Craft\Commerce_OrderAdjustmentModel;
use Craft\Commerce_OrderModel;
use Craft\StringHelper;

/**
 * Discount Adjustments
 *
 * Class Commerce_DiscountAdjuster
 *
 * @package Commerce\Adjusters
 */
class Commerce_DiscountAdjuster implements Commerce_AdjusterInterface
{
    const ADJUSTMENT_TYPE = 'Discount';

    /**
     * @param Commerce_OrderModel      $order
     * @param Commerce_LineItemModel[] $lineItems
     *
     * @return \Craft\Commerce_OrderAdjustmentModel[]
     */
    public function adjust(Commerce_OrderModel &$order, array $lineItems = [])
    {
        if (empty($lineItems))
        {
            return [];
        }

        $discounts = \Craft\craft()->commerce_discounts->getAllDiscounts(['condition' => '(code = :code OR code IS NULL) and enabled = :enabled',
                                                                          'params'    => ['code'    => $order->couponCode,
                                                                                          'enabled' => true],
                                                                          'order'     => 'sortOrder']);
        $adjustments = [];
        foreach ($discounts as $discount)
        {
            if ($adjustment = $this->getAdjustment($order, $lineItems, $discount))
            {
                $adjustments[] = $adjustment;

                if ($discount->stopProcessing)
                {
                    break;
                }
            }
        }

        return $adjustments;
    }

    /**
     * @param Commerce_OrderModel      $order
     * @param Commerce_LineItemModel[] $lineItems
     * @param Commerce_DiscountModel   $discount
     *
     * @return Commerce_OrderAdjustmentModel|false
     */
    private function getAdjustment(Commerce_OrderModel $order, array $lineItems, Commerce_DiscountModel $discount)
    {
        //preparing model
        $adjustment = new Commerce_OrderAdjustmentModel;
        $adjustment->type = self::ADJUSTMENT_TYPE;
        $adjustment->name = $discount->name;
        $adjustment->orderId = $order->id;
        $adjustment->description = $discount->description ?: $this->getDescription($discount);
        $adjustment->optionsJson = $discount->attributes;
        $affectedLineIds = [];


        // Handle special coupon rules
        if (strcasecmp($order->couponCode, $discount->code) == 0)
        {
            // Since we will allow the coupon to be added to an anonymous cart with no email, we need to remove it
            // if a limit has been set.
            if ($order->email && $discount->perEmailLimit)
            {
                $previousOrders = \Craft\craft()->commerce_orders->getOrdersByEmail($order->email);

                $usedCount = 0;
                foreach ($previousOrders as $previousOrder)
                {
                    if (strcasecmp($previousOrder->couponCode, $discount->code) == 0)
                    {
                        $usedCount += 1;
                    }
                }

                if ($usedCount >= $discount->perEmailLimit)
                {
                    $order->couponCode = '';

                    return false;
                }
            }
        }


        $now = new \Craft\DateTime();
        $from = $discount->dateFrom;
        $to = $discount->dateTo;
        if ($from && $from > $now || $to && $to < $now)
        {
            return false;
        }

        //checking items
        $matchingQty = 0;
        $matchingTotal = 0;
        $matchingLineIds = [];
        /** @var Commerce_LineItemModel $item */
        foreach ($lineItems as $item) {
            if (\Craft\craft()->commerce_discounts->matchLineItem($item, $discount))
            {
                if (!$discount->allGroups)
                {
                    $customer = $order->getCustomer();
                    $user = $customer ? $customer->getUser() : null;
                    $userGroups = \Craft\craft()->commerce_discounts->getCurrentUserGroupIds($user);
                    if ($user && array_intersect($userGroups, $discount->getGroupIds()))
                    {
                        $matchingLineIds[] = $item->id;
                        $matchingQty += $item->qty;
                        $matchingTotal += $item->getSubtotal();
                    }
                }
                else
                {
                    $matchingLineIds[] = $item->id;
                    $matchingQty += $item->qty;
                    $matchingTotal += $item->getSubtotal();
                }
            }
        }

        if (!$matchingQty)
        {
            return false;
        }

        // Have they entered a max qty?
        if ($discount->maxPurchaseQty > 0 && $matchingQty > $discount->maxPurchaseQty)
        {
                return false;
        }

        // Reject if they have not added enough matching items
        if ($matchingQty < $discount->purchaseQty)
        {
            return false;
        }

        // Reject if the matching items values is not enough
        if ($matchingTotal < $discount->purchaseTotal)
        {
            return false;
        }

        $amount = $discount->baseDiscount;
        $shippingRemoved = 0;

        foreach ($lineItems as $item)
        {
            if (in_array($item->id, $matchingLineIds))
            {
                $amountPerItem = CommerceCurrencyHelper::round($discount->perItemDiscount * $item->qty);

                //Default is off discounted price
                $amountPercentage = CommerceCurrencyHelper::round($discount->percentDiscount * ($item->getSubtotal() + $item->discount));

                if($discount->percentageOffSubject == Commerce_DiscountRecord::TYPE_ORIGINAL_SALEPRICE)
                {
                    $amountPercentage = CommerceCurrencyHelper::round($discount->percentDiscount * $item->getSubtotal());
                }

                $amount += $amountPerItem + $amountPercentage;
                $item->discount += $amountPerItem + $amountPercentage;

                // If the discount is now larger than the subtotal only make the discount amount the same as the total of the line.
                if (($item->discount * -1) > $item->getSubtotal())
                {
                    $diff = ($item->discount * -1) - $item->getSubtotal();
                    $item->discount = -$item->getSubtotal();
                    // Make sure the adjustment amount is reduced by the amount we modified the discount by
                    // due to it being too large.
                    $amount = $amount + $diff;
                }

                $affectedLineIds[] = $item->id;

                if ($discount->freeShipping)
                {
                    $shippingRemoved = $shippingRemoved + $item->shippingCost;
                    $item->shippingCost = 0;
                }
            }
        }

        if ($discount->freeShipping)
        {
            $shippingRemoved = $shippingRemoved + $order->baseShippingCost;
            $order->baseShippingCost = 0;
        }

        $order->baseDiscount += $discount->baseDiscount;

        // only display adjustment if an amount was calculated
        if ($amount || $shippingRemoved)
        {
            // Record which line items this discount affected.
            $adjustment->optionsJson = array_merge(['lineItemsAffected' => $affectedLineIds], $adjustment->optionsJson);
            $adjustment->amount = $amount + ($shippingRemoved * -1);

            return $adjustment;
        }
        else
        {
            return false;
        }
    }

    /**
     * @param Commerce_DiscountModel $discount
     *
     * @return string "1$ and 5% per item and 10$ base rate"
     */
    private function getDescription(Commerce_DiscountModel $discount)
    {
        $description = '';
        $currency = \Craft\craft()->commerce_paymentCurrencies->getPrimaryPaymentCurrencyIso();

        if ($discount->perItemDiscount || $discount->percentDiscount)
        {
            if ($discount->perItemDiscount)
            {
                $perItemDiscount = (float) $discount->perItemDiscount;
                $perItemDiscount = $perItemDiscount * -1;
                $description .= \Craft\craft()->numberFormatter->formatCurrency($perItemDiscount, $currency);
            }

            if ($discount->percentDiscount)
            {
                if ($discount->perItemDiscount)
                {
                    $description .= ' and ';
                }
                $percentDiscount = (float) $discount->percentDiscount;
                $percentDiscount = $percentDiscount * -1;
                $description .= \Craft\craft()->numberFormatter->formatPercentage($percentDiscount);
            }

            $description .= ' per item ';
        }

        if ($discount->baseDiscount)
        {
            if ($description)
            {
                $description .= 'and ';
            }
            $baseDiscount = (float) $discount->baseDiscount;
            $baseDiscount = $baseDiscount * -1;
            $description .= \Craft\craft()->numberFormatter->formatCurrency($baseDiscount, $currency).' base rate ';
        }

        if ($discount->freeShipping)
        {
            if ($description)
            {
                $description .= 'and ';
            }

            $description .= 'free shipping ';
        }

        if ($discount->code)
        {
            if ($description)
            {
                $description .= 'and ';
            }

            $description .= 'using code '.StringHelper::toUpperCase($discount->code);
        }

        return $description;
    }
}
