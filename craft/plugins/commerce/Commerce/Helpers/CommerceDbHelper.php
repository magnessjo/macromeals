<?php

namespace Commerce\Helpers;

/**
 * Class CommerceDbHelper
 *
 * @author    Pixel & Tonic, Inc. <support@pixelandtonic.com>
 * @copyright Copyright (c) 2015, Pixel & Tonic, Inc.
 * @license   https://craftcommerce.com/license Craft Commerce License Agreement
 * @see       https://craftcommerce.com
 * @package   Commerce\Helpers
 * @since     1.0
 */
class CommerceDbHelper
{
    private static $transactionsStackSize = 0;
    /** @var \CDbTransaction */
    private static $transaction = null;

    /**
     * This method, and the next two special functions which allow making nested transactions with a delayed commit.
     */
    public static function beginStackedTransaction()
    {
        \Craft\craft()->deprecator->log('CommerceDbHelper::beginStackedTransaction()', 'Craft::beginStackedTransaction() has been deprecated.');

        if (self::$transactionsStackSize == 0) {
            if (\Craft\craft()->db->getCurrentTransaction() === null) {
                self::$transaction = \Craft\craft()->db->beginTransaction();
            } else {
                // If we are at zero but 3rd party has a current transaction in play
                self::$transaction = \Craft\craft()->db->getCurrentTransaction();
                // By setting to 1, we will never commit, but whoever started it should.
                self::$transactionsStackSize = 1;
            }
        }

        ++self::$transactionsStackSize;
    }

    public static function commitStackedTransaction()
    {
        \Craft\craft()->deprecator->log('CommerceDbHelper::commitStackedTransaction()', 'Craft::commitStackedTransaction() has been deprecated.');

        self::$transactionsStackSize && --self::$transactionsStackSize; //decrement only when positive

        if (self::$transactionsStackSize == 0) {
            self::$transaction->commit();
        }
    }

    public static function rollbackStackedTransaction()
    {
        \Craft\craft()->deprecator->log('CommerceDbHelper::rollbackStackedTransaction()', 'Craft::rollbackStackedTransaction() has been deprecated.');

        self::$transactionsStackSize && --self::$transactionsStackSize; //decrement only when positive

        if (self::$transactionsStackSize == 0) {
            self::$transaction->rollback();
        }
    }
}