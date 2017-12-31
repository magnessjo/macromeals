<?php

namespace Craft;

use Calendar\Library\PermissionsHelper;

class Calendar_CalendarsController extends BaseController
{
    /**
     * @throws HttpException
     */
    public function init()
    {
        PermissionsHelper::requirePermission(PermissionsHelper::PERMISSION_CALENDARS);

        parent::init();
    }

    /**
     * @throws HttpException
     */
    public function actionCalendarsIndex()
    {
        $variables['calendars'] = $this->getCalendarService()->getAllCalendars();

        $this->renderTemplate('calendar/calendars', $variables);
    }

    /**
     * @param array $variables
     *
     * @throws HttpException
     */
    public function actionEditCalendar(array $variables = array())
    {
        $calendarHandle = isset($variables['calendarHandle']) ? $variables['calendarHandle'] : null;

        if (isset($variables['calendar']) && $variables['calendar'] instanceof Calendar_CalendarModel) {
            PermissionsHelper::requirePermission(PermissionsHelper::PERMISSION_EDIT_CALENDARS);

            $calendar = $variables['calendar'];
            $title    = $calendar->name;
        } else if ($calendarHandle) {
            $calendar = $this->getCalendarService()->getCalendarByHandle($calendarHandle);

            if (!$calendar) {
                throw new HttpException(
                    404,
                    Craft::t('Calendar with a handle "{handle}" could not be found', array('handle' => $calendarHandle))
                );
            }

            PermissionsHelper::requirePermission(PermissionsHelper::PERMISSION_EDIT_CALENDARS);

            $title = $calendar->name;
        } else {
            PermissionsHelper::requirePermission(PermissionsHelper::PERMISSION_CREATE_CALENDARS);

            $calendar = Calendar_CalendarModel::create();
            $title    = Craft::t('Create a new calendar');
        }

        $customFields    = craft()->fields->getAllFields("id");
        $customFieldData = array();
        foreach ($customFields as $field) {
            $customFieldData[$field->id] = array(
                'handle' => $field->handle,
                'name'   => $field->name,
            );
        }

        $variables['title']              = $title;
        $variables['calendar']           = $calendar;
        $variables['continueEditingUrl'] = 'calendar/calendars/{handle}';
        $variables['customFields']       = $customFieldData;
        $variables['newCalendar']        = !(bool) $calendar->id;

        $this->renderTemplate('calendar/calendars/_edit', $variables);
    }

    /**
     * Saves a calendar
     *
     * @throws Exception
     * @throws HttpException
     * @throws \Exception
     */
    public function actionSaveCalendar()
    {
        $this->requirePostRequest();

        $postedCalendarId = craft()->request->getPost('calendarId');
        if ($postedCalendarId) {
            PermissionsHelper::requirePermission(PermissionsHelper::PERMISSION_EDIT_CALENDARS);
        } else {
            PermissionsHelper::requirePermission(PermissionsHelper::PERMISSION_CREATE_CALENDARS);
        }

        $calendar = $this->getCalendarService()->getCalendarById($postedCalendarId);
        if (!$calendar) {
            $calendar = new Calendar_CalendarModel();
        }

        // Shared attributes
        $calendar->id                     = $postedCalendarId;
        $calendar->name                   = craft()->request->getPost('name');
        $calendar->handle                 = craft()->request->getPost('handle');
        $calendar->description            = craft()->request->getPost('description');
        $calendar->color                  = craft()->request->getPost('color');
        $calendar->hasUrls                = craft()->request->getPost('hasUrls', false);
        $calendar->eventTemplate          = craft()->request->getPost('eventTemplate');
        $calendar->descriptionFieldHandle = craft()->request->getPost('descriptionFieldHandle');
        $calendar->locationFieldHandle    = craft()->request->getPost('locationFieldHandle');
        $calendar->titleFormat            = craft()->request->getPost('titleFormat');
        $calendar->titleLabel             = craft()->request->getPost('titleLabel');
        $calendar->hasTitleField          = (bool) craft()->request->getPost('hasTitleField');


        // Set the field layout
        $fieldLayout       = craft()->fields->assembleLayoutFromPost();
        $fieldLayout->type = CalendarPlugin::FIELD_LAYOUT_TYPE;
        $calendar->setFieldLayout($fieldLayout);

        if ($fieldLayout) {
            $fieldHandles = array();
            foreach ($fieldLayout->getFields() as $field) {
                $fieldHandles[] = $field->getField()->handle;
            }

            $descriptionFieldHandle = $calendar->descriptionFieldHandle;
            $locationFieldHandle    = $calendar->locationFieldHandle;

            if ($descriptionFieldHandle && !in_array($descriptionFieldHandle, $fieldHandles, true)) {
                $calendar->descriptionFieldHandle = null;
            }

            if ($locationFieldHandle && !in_array($locationFieldHandle, $fieldHandles, true)) {
                $calendar->locationFieldHandle = null;
            }
        }

        // Locale-specific attributes
        $locales = array();

        if (craft()->isLocalized()) {
            $localeIds = craft()->request->getPost('locales', array());
        } else {
            $primaryLocaleId = craft()->i18n->getPrimarySiteLocaleId();
            $localeIds       = array($primaryLocaleId);
        }

        $postedUrlFormats = craft()->request->getPost('eventUrlFormat', []);
        foreach ($localeIds as $localeId) {
            $locales[$localeId] = new Calendar_CalendarLocaleModel(
                array(
                    'locale'           => $localeId,
                    'enabledByDefault' => (bool) craft()->request->getPost('defaultLocaleStatuses.' . $localeId),
                    'eventUrlFormat'   => isset($postedUrlFormats[$localeId]) ? $postedUrlFormats[$localeId] : null,
                )
            );
        }

        $calendar->setLocales($locales);


        // Save it
        if ($this->getCalendarService()->saveCalendar($calendar)) {
            craft()->userSession->setNotice(Craft::t('Calendar saved.'));
            $this->redirectToPostedUrl($calendar);
        } else {
            // Send the calendar back to the template
            craft()->urlManager->setRouteVariables(array('calendar' => $calendar));

            craft()->userSession->setError(Craft::t('Couldn’t save calendar.'));
        }
    }

    /**
     * Enables the ICS hash for a given calendar
     * Returns the "ics_hash" via ajax response
     */
    public function actionEnableIcsSharing()
    {
        PermissionsHelper::requirePermission(PermissionsHelper::PERMISSION_EDIT_CALENDARS);

        $this->requirePostRequest();
        $this->requireAjaxRequest();

        $calendarId = craft()->request->getRequiredPost('calendar_id');

        $calendar = $this->getCalendarService()->getCalendarById($calendarId);

        if (!$calendar) {
            $this->returnErrorJson(Craft::t('No calendar exists with the ID "{id}"', array('id' => $calendarId)));
        }

        $icsHash = $calendar->regenerateIcsHash();
        $this->getCalendarService()->saveCalendar($calendar);

        $this->returnJson(array('ics_hash' => $icsHash));
    }

    /**
     * Disables the ICS hash for a given calendar
     * Returns the "success: true" via ajax response
     */
    public function actionDisableIcsSharing()
    {
        PermissionsHelper::requirePermission(PermissionsHelper::PERMISSION_EDIT_CALENDARS);

        $this->requirePostRequest();
        $this->requireAjaxRequest();

        $calendarId = craft()->request->getRequiredPost("calendar_id");

        $calendar = $this->getCalendarService()->getCalendarById($calendarId);

        if (!$calendar) {
            $this->returnErrorJson(Craft::t('No calendar exists with the ID "{id}"', array("id" => $calendarId)));
        }

        $calendar->icsHash = null;
        $this->getCalendarService()->saveCalendar($calendar);

        $this->returnJson(array("success" => true));
    }

    /**
     * @throws HttpException
     * @throws \Exception
     */
    public function actionDelete()
    {
        $this->requirePostRequest();
        $this->requireAjaxRequest();

        PermissionsHelper::requirePermission(PermissionsHelper::PERMISSION_DELETE_CALENDARS);

        $calendarId = craft()->request->getRequiredPost('id');

        if ($this->getCalendarService()->deleteCalendarById($calendarId)) {
            $this->returnJson(array('success' => true));
        } else {
            $this->returnJson(array('success' => false));
        }
    }

    /**
     * @return Calendar_CalendarsService
     */
    private function getCalendarService()
    {
        return craft()->calendar_calendars;
    }
}
