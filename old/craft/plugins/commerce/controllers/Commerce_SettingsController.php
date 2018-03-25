<?php
namespace Craft;

/**
 * Class Commerce_SettingsController
 *
 * @author    Pixel & Tonic, Inc. <support@pixelandtonic.com>
 * @copyright Copyright (c) 2015, Pixel & Tonic, Inc.
 * @license   https://craftcommerce.com/license Craft Commerce License Agreement
 * @see       https://craftcommerce.com
 * @package   craft.plugins.commerce.controllers
 * @since     1.0
 */
class Commerce_SettingsController extends Commerce_BaseAdminController
{

    /**
     * @inheritDoc BaseController::init()
     *
     * @throws HttpException
     * @return null
     */
    public function init()
    {
        // do not check for admin only, since the index controller will redirect.
    }

    /**
     * Commerce Settings Index
     */
    public function actionIndex()
    {
        if (craft()->userSession->isAdmin()) {
            $this->redirect('commerce/settings/general');
        }

        if (craft()->userSession->checkPermission('commerce-manageShipping')) {
            $this->redirect('commerce/settings/shippingmethods');
        }

        if (craft()->userSession->checkPermission('commerce-manageShipping')) {
            $this->redirect('commerce/settings/taxrates');
        }
    }

    /**
     * Commerce Settings Form
     */
    public function actionEdit()
    {
        $this->requireAdmin();

        $settings = craft()->commerce_settings->getSettings();

        $craftSettings = craft()->email->getSettings();
        $settings->emailSenderAddressPlaceholder = (isset($craftSettings['emailAddress']) ? $craftSettings['emailAddress'] : '');
        $settings->emailSenderNamePlaceholder = (isset($craftSettings['senderName']) ? $craftSettings['senderName'] : '');

        $this->renderTemplate('commerce/settings/general', ['settings' => $settings]);
    }

    /**
     * @throws HttpException
     */
    public function actionSaveSettings()
    {
        $this->requireAdmin();

        $this->requirePostRequest();
        $postData = craft()->request->getPost('settings');
        $settings = Commerce_SettingsModel::populateModel($postData);

        if (!craft()->commerce_settings->saveSettings($settings)) {
            craft()->userSession->setError(Craft::t('Couldn’t save settings.'));
            $this->renderTemplate('commerce/settings', ['settings' => $settings]);
        } else {
            craft()->userSession->setNotice(Craft::t('Settings saved.'));
            $this->redirectToPostedUrl();
        }
    }
}
