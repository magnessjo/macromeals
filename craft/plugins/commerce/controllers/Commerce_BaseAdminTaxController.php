<?php
namespace Craft;

/**
 * Class BaseAdminShippingController
 *
 * @author    Pixel & Tonic, Inc. <support@pixelandtonic.com>
 * @copyright Copyright (c) 2015, Pixel & Tonic, Inc.
 * @license   https://craftcommerce.com/license Craft Commerce License Agreement
 * @see       https://craftcommerce.com
 * @package   craft.plugins.commerce.controllers
 * @since     1.0
 */
class Commerce_BaseAdminTaxController extends Commerce_BaseController
{
    // Public Methods
    // =========================================================================

    /**
     * @inheritDoc BaseController::init()
     *
     * @throws HttpException
     * @return null
     */
    public function init()
    {
        if (!craft()->userSession->checkPermission('commerce-manageTaxes'))
        {
            throw new HttpException(403, Craft::t('This action may only be performed by authorized users.'));
        }
    }
}
