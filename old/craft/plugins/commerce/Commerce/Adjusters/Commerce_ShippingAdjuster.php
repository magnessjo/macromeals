<?php

namespace Commerce\Adjusters;

use Commerce\Helpers\CommerceCurrencyHelper;
use Commerce\Interfaces\ShippingMethod;
use Craft\Commerce_LineItemModel;
use Craft\Commerce_OrderAdjustmentModel;
use Craft\Commerce_OrderModel;

/**
 * Tax Adjustments
 *
 * Class Commerce_ShippingAdjuster
 *
 * @package Commerce\Adjusters
 */
class Commerce_ShippingAdjuster implements Commerce_AdjusterInterface
{
    const ADJUSTMENT_TYPE = 'Shipping';

    /**
     * @param Commerce_OrderModel      $order
     * @param Commerce_LineItemModel[] $lineItems
     *
     * @return \Craft\Commerce_OrderAdjustmentModel[]
     */
    public function adjust(Commerce_OrderModel &$order, array $lineItems = [])
    {
        $shippingMethods = \Craft\craft()->commerce_shippingMethods->getAvailableShippingMethods($order);

        foreach ($shippingMethods as $method)
        {
            if ($method['method']->getIsEnabled() == true && ($method['method']->getHandle() == $order->getShippingMethodHandle()))
            {
                /** @var ShippingMethod $shippingMethod */
                $shippingMethod = $method['method'];
            }
        }

        if (!isset($shippingMethod))
        {
            return [];
        }

        $adjustments = [];


        if ($rule = \Craft\craft()->commerce_shippingMethods->getMatchingShippingRule($order, $shippingMethod))
        {

            //preparing model
            $adjustment = new Commerce_OrderAdjustmentModel;
            $adjustment->type = self::ADJUSTMENT_TYPE;
            $adjustment->orderId = $order->id;

            $affectedLineIds = [];

            //checking items tax categories
            $itemShippingTotal = 0;
            $freeShippingAmount = 0;
            foreach ($lineItems as $item)
            {

                $percentageRate = $rule->getPercentageRate($item->shippingCategoryId);
                $perItemRate = $rule->getPerItemRate($item->shippingCategoryId);
                $weightRate = $rule->getWeightRate($item->shippingCategoryId);

                $percentageAmount = $item->getSubtotal() * $percentageRate;
                $perItemAmount = $item->qty * $perItemRate;
                $weightAmount = ($item->weight * $item->qty) * $weightRate;
                $item->shippingCost = CommerceCurrencyHelper::round($percentageAmount + $perItemAmount + $weightAmount);

                if ($item->shippingCost && !$item->purchasable->hasFreeShipping())
                {
                    $affectedLineIds[] = $item->id;
                }

                $itemShippingTotal += $item->shippingCost;

                if ($item->purchasable->hasFreeShipping())
                {
                    $freeShippingAmount += $item->shippingCost;
                    $item->shippingCost = 0;
                }
            }

            //amount for displaying in adjustment
            $amount = CommerceCurrencyHelper::round($rule->getBaseRate()) + $itemShippingTotal - $freeShippingAmount;
            $amount = max($amount, CommerceCurrencyHelper::round($rule->getMinRate()));

            if ($rule->getMaxRate())
            {
                $amount = min($amount, CommerceCurrencyHelper::round($rule->getMaxRate()));
            }

            $adjustment->amount = $amount;

            //real shipping base rate (can be a bit artificial because it counts min and max rate as well, but in general it equals to be $rule->baseRate)
            $order->baseShippingCost = $amount - ($itemShippingTotal - $freeShippingAmount);

            // Let the name, options and description come last since since plugins may not have all info up front.
            $adjustment->name = $shippingMethod->getName();
            $adjustment->optionsJson = $rule->getOptions();
            $adjustment->optionsJson = array_merge(['lineItemsAffected' => $affectedLineIds], $adjustment->optionsJson);
            $adjustment->description = $rule->getDescription();

            $adjustments[] = $adjustment;
        }

        // If the selected shippingMethod has no rules matched on this order, remove the method from the order and reset shipping costs.
        if (empty($adjustments))
        {
            $order->shippingMethod = null;
            $order->baseShippingCost = 0;
            foreach ($lineItems as $item)
            {
                $item->shippingCost = 0;
            }
        }

        return $adjustments;
    }

}
