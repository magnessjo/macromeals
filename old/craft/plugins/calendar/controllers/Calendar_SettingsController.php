<?php
/**
 * Calendar for Craft
 *
 * @package       Solspace:Calendar
 * @author        Solspace, Inc.
 * @copyright     Copyright (c) 2010-2018, Solspace, Inc.
 * @link          https://solspace.com/craft/calendar
 * @license       https://solspace.com/software/license-agreement
 */

namespace Craft;

use Calendar\Library\PermissionsHelper;

class Calendar_SettingsController extends BaseController
{
    /**
     * Make sure this controller requires a logged in member
     */
    public function init()
    {
        $this->requireLogin();
    }

    /**
     * Redirects to the default selected view
     */
    public function actionDefaultView()
    {
        $defaultView = $this->getSettingsModel()->defaultView;

        $canAccessCalendars = PermissionsHelper::checkPermission(PermissionsHelper::PERMISSION_CALENDARS);
        $canAccessEvents    = PermissionsHelper::checkPermission(PermissionsHelper::PERMISSION_EVENTS);

        $isMonthView     = $defaultView === CalendarPlugin::VIEW_MONTH;
        $isWeekView      = $defaultView === CalendarPlugin::VIEW_WEEK;
        $isDayView       = $defaultView === CalendarPlugin::VIEW_DAY;
        $isEventsView    = $defaultView === CalendarPlugin::VIEW_EVENTS;
        $isCalendarsView = $defaultView === CalendarPlugin::VIEW_CALENDARS;

        if ($isEventsView && !$canAccessEvents) {
            $this->redirect(UrlHelper::getCpUrl("calendar/view/" . CalendarPlugin::VIEW_MONTH));
        }

        if ($isCalendarsView && !$canAccessCalendars) {
            $this->redirect(UrlHelper::getCpUrl("calendar/view/" . CalendarPlugin::VIEW_MONTH));
        }

        if ($isMonthView || $isWeekView || $isDayView) {
            $this->redirect(UrlHelper::getCpUrl("calendar/view/" . $defaultView));
        }

        $this->redirect(UrlHelper::getCpUrl("calendar/" . $defaultView));
    }

    /**
     * Renders the License settings page template
     */
    public function actionLicense()
    {
        $this->provideTemplate('license');
    }

    /**
     * Renders the General settings page template
     */
    public function actionGeneral()
    {
        $this->provideTemplate('general');
    }

    /**
     * Renders the Events settings page template
     */
    public function actionEvents()
    {
        $this->provideTemplate('events');
    }

    /**
     * Renders the ICS settings page template
     */
    public function actionIcs()
    {
        $this->provideTemplate('ics');
    }

    /**
     * Renders the Field Layout settings page template
     */
    public function actionFieldLayout()
    {
        $this->provideTemplate('field_layout');
    }

    /**
     * Renders the General settings page template
     */
    public function actionGuestAccess()
    {
        $settings = $this->getSettingsModel();

        $guestAccess = $settings->guestAccess;


        /** @var Calendar_CalendarsService $calendarService */
        $calendarService = craft()->calendar_calendars;
        $calendars       = $calendarService->getAllCalendars();

        $calendarOptions = array();
        foreach ($calendars as $calendar) {
            $calendarOptions[$calendar->id] = $calendar->name;
        }

        $this->provideTemplate(
            'guest_access',
            array(
                'guestAccess' => $guestAccess,
                'calendars' => $calendarOptions,
            )
        );
    }

    /**
     * Handles layout saving and ICS field special treatment if necessery
     *
     * @throws HttpException
     */
    public function actionSaveSettings()
    {
        PermissionsHelper::requirePermission(PermissionsHelper::PERMISSION_SETTINGS);

        $this->requirePostRequest();
        $postData = craft()->request->getPost('settings', array());

        if (isset($_POST['allowGuestAccess']) && !$_POST['allowGuestAccess']) {
            $postData['guestAccess'] = null;
        }

        if (isset($postData['guestAccess']) && !$postData['guestAccess']) {
            $postData['guestAccess'] = null;
        }

        $plugin = craft()->plugins->getPlugin('calendar');
        craft()->plugins->savePluginSettings($plugin, $postData);

        craft()->userSession->setNotice(Craft::t('Settings saved successfully.'));
        $this->redirectToPostedUrl();
    }

    /**
     * Determines which template has to be rendered based on $template
     * Adds a Freeform_SettingsModel to template variables
     *
     * @param string $template
     * @param array  $variables
     *
     * @throws \Craft\HttpException
     */
    private function provideTemplate($template, array $variables = [])
    {
        PermissionsHelper::requirePermission(PermissionsHelper::PERMISSION_SETTINGS);

        $this->renderTemplate(
            'calendar/settings/_' . $template,
            array_merge(
                array(
                    'settings' => $this->getSettingsModel(),
                ),
                $variables
            )
        );
    }

    /**
     * @return Calendar_SettingsModel
     */
    private function getSettingsModel()
    {
        /** @var Calendar_SettingsService $settingsService */
        $settingsService = craft()->calendar_settings;

        return $settingsService->getSettingsModel();
    }
}
