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

use Calendar\Library\Attributes\CalendarAttributes;
use Calendar\Library\PermissionsHelper;

class Calendar_CalendarsService extends BaseApplicationComponent
{
    /** @var Calendar_CalendarModel[] */
    private $calendarCache;
    private $allCalendarsCached;

    private $allowedCalendarCache;

    /**
     * @return Calendar_CalendarModel[]
     */
    public function getAllCalendars()
    {
        if (null === $this->calendarCache || !$this->allCalendarsCached) {
            $calendarRecords          = Calendar_CalendarRecord::model()->ordered()->findAll();
            $this->calendarCache      = Calendar_CalendarModel::populateModels($calendarRecords, 'id');
            $this->allCalendarsCached = true;
        }

        return $this->calendarCache;
    }

    /**
     * @return Calendar_CalendarModel[]
     */
    public function getAllAllowedCalendars()
    {
        $isAdmin      = PermissionsHelper::isAdmin();
        $canManageAll = PermissionsHelper::checkPermission(PermissionsHelper::PERMISSION_EVENTS_FOR_ALL);

        /** @var Calendar_SettingsService $settings */
        $settings          = craft()->calendar_settings;
        $publicCalendarIds = $settings->getSettingsModel()->guestAccess;

        if ($isAdmin || $canManageAll || $publicCalendarIds === '*') {
            return $this->getAllCalendars();
        }

        if (null === $this->allowedCalendarCache) {
            $allowedCalendarIds = PermissionsHelper::getNestedPermissionIds(PermissionsHelper::PERMISSION_EVENTS_FOR);

            if (is_array($publicCalendarIds)) {
                $publicCalendarIds  = array_map('intval', $publicCalendarIds);
                $allowedCalendarIds = array_merge($allowedCalendarIds, $publicCalendarIds);
            }

            $calendarRecords            = Calendar_CalendarRecord::model()->ordered()->findAllById($allowedCalendarIds);
            $this->allowedCalendarCache = Calendar_CalendarModel::populateModels($calendarRecords, 'id');
        }

        return $this->allowedCalendarCache;
    }

    /**
     * Returns an array of calendar titles indexed by calendar ID
     *
     * @return array
     */
    public function getAllCalendarTitles()
    {
        $titleArray = array();
        $calendars  = $this->getAllCalendars();

        foreach ($calendars as $calendar) {
            $titleArray[$calendar->id] = $calendar->name;
        }

        return $titleArray;
    }

    /**
     * @return string
     */
    public function getLatestModificationDate()
    {
        return craft()
            ->db
            ->createCommand()
            ->select('MAX(dateUpdated)')
            ->from('calendar_calendars')
            ->limit(1)
            ->queryScalar();
    }

    /**
     * @return String
     */
    public function getAllCalendarCount()
    {
        return craft()
            ->db
            ->createCommand()
            ->select('COUNT(id)')
            ->from('calendar_calendars')
            ->queryScalar();
    }

    /**
     * Returns an array of calendar titles indexed by calendar ID
     *
     * @return array
     */
    public function getAllAllowedCalendarTitles()
    {
        $titleArray = array();
        $calendars  = $this->getAllAllowedCalendars();

        foreach ($calendars as $calendar) {
            $titleArray[$calendar->id] = $calendar->name;
        }

        return $titleArray;
    }

    /**
     * @param int $calendarId
     *
     * @return Calendar_CalendarModel
     */
    public function getCalendarById($calendarId)
    {
        $calendars = $this->getAllCalendars();

        if (isset($calendars[$calendarId])) {
            return $calendars[$calendarId];
        }

        return null;
    }

    /**
     * @param string $calendarHandle
     *
     * @return Calendar_CalendarModel
     */
    public function getCalendarByHandle($calendarHandle)
    {
        $calendarRecord = Calendar_CalendarRecord::model()->findByAttributes(array('handle' => $calendarHandle));

        if ($calendarRecord) {
            return Calendar_CalendarModel::populateModel($calendarRecord);
        }

        return null;
    }

    /**
     * @param string $icsHash
     *
     * @return Calendar_CalendarModel
     */
    public function getCalendarByIcsHash($icsHash)
    {
        if (!$icsHash) {
            return null;
        }

        $calendarRecord = Calendar_CalendarRecord::model()->findByAttributes(array('icsHash' => $icsHash));

        if ($calendarRecord) {
            return Calendar_CalendarModel::populateModel($calendarRecord);
        }

        return null;
    }

    /**
     * @param Calendar_CalendarModel $calendar
     * @param bool                   $checkLocales
     *
     * @return bool
     * @throws Exception
     * @throws \Exception
     */
    public function saveCalendar(Calendar_CalendarModel $calendar, $checkLocales = true)
    {
        $isNewCalendar = !$calendar->id;
        if ($isNewCalendar) {
            $calendarRecord = new Calendar_CalendarRecord();
            $oldCalendar    = null;
        } else {
            $calendarRecord = Calendar_CalendarRecord::model()->findById($calendar->id);

            if (!$calendarRecord) {
                throw new Exception(Craft::t('No calendar exists with the ID "{id}"', array('id' => $calendar->id)));
            }

            $oldCalendar = Calendar_CalendarModel::populateModel($calendarRecord);
        }

        $beforeSaveCalendar = $this->onBeforeSave($calendar, $isNewCalendar);

        $calendarRecord->name                   = $calendar->name;
        $calendarRecord->handle                 = $calendar->handle;
        $calendarRecord->description            = $calendar->description;
        $calendarRecord->color                  = $calendar->color;
        $calendarRecord->hasUrls                = $calendar->hasUrls;
        $calendarRecord->eventTemplate          = $calendar->eventTemplate;
        $calendarRecord->descriptionFieldHandle = $calendar->descriptionFieldHandle;
        $calendarRecord->locationFieldHandle    = $calendar->locationFieldHandle;
        $calendarRecord->icsHash                = $calendar->icsHash;
        $calendarRecord->titleFormat            = $calendar->titleFormat;
        $calendarRecord->titleLabel             = $calendar->titleLabel;
        $calendarRecord->hasTitleField          = $calendar->hasTitleField;

        if ($calendarRecord->hasTitleField && !$calendarRecord->titleLabel) {
            $calendar->addError('titleLabel', Craft::t('This field is required'));
        } else if (!$calendarRecord->hasTitleField && !$calendarRecord->titleFormat) {
            $calendar->addError('titleFormat', Craft::t('This field is required'));
        }

        $calendarRecord->validate();
        $calendar->addErrors($calendarRecord->getErrors());

        $calendarLocales = $calendar->getLocales();
        if ($checkLocales && !$calendarLocales) {
            $calendar->addError('localeErrors', Craft::t('At least one locale must be selected for the section.'));
        }

        if ($beforeSaveCalendar->performAction && !$calendar->hasErrors()) {
            $transaction = craft()->db->getCurrentTransaction() === null ? craft()->db->beginTransaction() : null;
            try {
                $fieldLayout = $calendar->getFieldLayout();

                if (!$fieldLayout->id) {
                    if (!$isNewCalendar && $oldCalendar->fieldLayoutId) {
                        // Drop the old field layout
                        craft()->fields->deleteLayoutById($oldCalendar->fieldLayoutId);
                    }

                    // Save the new one
                    craft()->fields->saveLayout($fieldLayout);

                    // Update the calendar record/model with the new layout ID
                    $calendar->fieldLayoutId       = $fieldLayout->id;
                    $calendarRecord->fieldLayoutId = $fieldLayout->id;
                }

                $calendarRecord->save(false);

                if (!$calendar->id) {
                    $calendar->id = $calendarRecord->id;
                }

                // Update the calendar_calendars_i18n table
                $newLocaleData = array();

                if (!$isNewCalendar) {
                    // Get the old calendar locales
                    $oldCalendarLocaleRecords = Calendar_CalendarLocaleRecord::model()->findAllByAttributes(
                        array('calendarId' => $calendar->id)
                    );

                    $oldCalendarLocales = Calendar_CalendarLocaleModel::populateModels(
                        $oldCalendarLocaleRecords,
                        'locale'
                    );
                }

                foreach ($calendarLocales as $localeId => $locale) {
                    // Was this already selected?
                    if (!$isNewCalendar && isset($oldCalendarLocales[$localeId])) {
                        $oldLocale = $oldCalendarLocales[$localeId];

                        // Has anything changed?
                        if (
                            $locale->enabledByDefault != $oldLocale->enabledByDefault ||
                            $locale->eventUrlFormat != $oldLocale->eventUrlFormat
                        ) {
                            craft()->db->createCommand()->update(
                                Calendar_CalendarLocaleRecord::TABLE,
                                array(
                                    'enabledByDefault' => (int) $locale->enabledByDefault,
                                    'eventUrlFormat'   => $locale->eventUrlFormat,
                                ),
                                array('id' => $oldLocale->id)
                            );
                        }
                    } else {
                        $newLocaleData[] = array(
                            (int) $calendar->id,
                            $localeId,
                            (int) $locale->enabledByDefault,
                            $locale->eventUrlFormat,
                        );
                    }
                }

                // Insert the new locales
                craft()->db->createCommand()->insertAll(
                    Calendar_CalendarLocaleRecord::TABLE,
                    array('calendarId', 'locale', 'enabledByDefault', 'eventUrlFormat'),
                    $newLocaleData
                );

                if (!$isNewCalendar) {
                    $droppedLocaleIds = array_diff(array_keys($oldCalendarLocales), array_keys($calendarLocales));

                    if ($droppedLocaleIds) {
                        craft()->db->createCommand()->delete(
                            Calendar_CalendarLocaleRecord::TABLE,
                            array('and', 'calendarId = :calendarId', array('in', 'locale', $droppedLocaleIds)),
                            array(':calendarId' => $calendar->id)
                        );
                    }
                }

                $this->calendarCache[$calendar->id] = $calendar;

                if (!$isNewCalendar) {
                    $criteria = craft()->elements->getCriteria(Calendar_EventModel::ELEMENT_TYPE);

                    if (craft()->isLocalized()) {
                        // Get the most-primary locale that this section was already enabled in
                        $locales = array_values(array_intersect(craft()->i18n->getSiteLocaleIds(), array_keys($oldCalendarLocales)));
                    } else {
                        $locales = [craft()->i18n->getPrimarySiteLocaleId()];
                    }

                    if ($locales) {
                        foreach ($locales as $locale) {
                            $criteria->locale = $locale;
                            $criteria->calendarId = $calendar->id;
                            $criteria->status = null;
                            $criteria->localeEnabled = null;
                            $criteria->limit = null;

                            craft()->tasks->createTask(
                                'Calendar_ResaveEvents',
                                Craft::t('Resaving {calendar} events',
                                    array('calendar' => $calendar->name, 'locale' => $locale)
                                ),
                                array(
                                    'elementType' => Calendar_EventModel::ELEMENT_TYPE,
                                    'criteria'    => $criteria->getAttributes()
                                )
                            );
                        }
                    }
                }

                if ($transaction !== null) {
                    $transaction->commit();
                }

                $this->onAfterSave($calendar, $isNewCalendar);
            } catch (\Exception $exception) {
                if ($transaction !== null) {
                    $transaction->rollback();
                }

                throw $exception;
            }

            return true;
        }

        return false;
    }

    /**
     * @param int $calendarId
     *
     * @return bool
     * @throws \Exception
     */
    public function deleteCalendarById($calendarId)
    {
        $calendar = $this->getCalendarById($calendarId);

        if (!$calendar) {
            return false;
        }

        if (!$this->onBeforeDelete($calendar)->performAction) {
            return false;
        }

        $transaction = craft()->db->getCurrentTransaction() === null ? craft()->db->beginTransaction() : null;
        try {
            // Grab the event ids so we can clean the elements table.
            $eventIds = craft()->db
                ->createCommand()
                ->select('id')
                ->from('calendar_events')
                ->where(array('calendarId' => $calendarId))
                ->queryColumn();

            craft()->elements->deleteElementById($eventIds);

            $affectedRows = craft()->db
                ->createCommand()
                ->delete('calendar_calendars', array('id' => $calendarId));

            if ($transaction !== null) {
                $transaction->commit();
            }

            $this->onAfterDelete($calendar);

            return (bool) $affectedRows;
        } catch (\Exception $exception) {
            if ($transaction !== null) {
                $transaction->rollback();
            }

            throw $exception;
        }
    }

    /**
     * @param null|array $attributes
     *
     * @return Calendar_CalendarModel[]
     */
    public function getCalendars($attributes = null)
    {
        $calendarAttributes = new CalendarAttributes($attributes);

        $calendars = Calendar_CalendarRecord::model()->findAll($calendarAttributes->getCriteria());

        if (empty($calendars)) {
            return array();
        }

        return Calendar_CalendarModel::populateModels($calendars);
    }

    /**
     * Returns a calendar's locales.
     *
     * @param int         $calendarId
     * @param string|null $indexBy
     *
     * @return Calendar_CalendarLocaleModel[]
     */
    public function getCalendarLocales($calendarId, $indexBy = null)
    {
        $records = craft()
            ->db
            ->createCommand()
            ->select('*')
            ->from('calendar_calendars_i18n calendar_calendars_i18n')
            ->join('locales locales', 'locales.locale = calendar_calendars_i18n.locale')
            ->where('calendar_calendars_i18n.calendarId = :calendarId', array(':calendarId' => $calendarId))
            ->order('locales.sortOrder')
            ->queryAll();

        return Calendar_CalendarLocaleModel::populateModels($records, $indexBy);
    }

    /**
     * @param Event $event
     *
     * @return bool
     */
    public function addLocaleHandler(Event $event)
    {
        $localeId = $event->params['localeId'];

        $rows      = array();
        $calendars = $this->getAllCalendars();
        foreach ($calendars as $calendar) {
            $rows[] = array(
                $calendar->id,
                $localeId,
                0,
            );
        }

        craft()->db
            ->createCommand()
            ->insertAll(
                Calendar_CalendarLocaleRecord::TABLE,
                array("calendarId", "locale", "enabledByDefault"),
                $rows
            );

        return true;
    }

    /**
     * @param Calendar_CalendarModel $calendar
     *
     * @return bool
     */
    public function isCalendarPublic(Calendar_CalendarModel $calendar)
    {
        /** @var Calendar_SettingsService $settings */
        $settings    = craft()->calendar_settings;
        $guestAccess = $settings->getSettingsModel()->guestAccess;

        if (null === $guestAccess) {
            return false;
        }

        if ($guestAccess === '*') {
            return true;
        }

        if (!is_array($guestAccess)) {
            return false;
        }

        $guestAccess = array_map('intval', $guestAccess);

        return in_array((int) $calendar->id, $guestAccess, true);
    }

    /**
     * Raises an event before calendar saving
     *
     * @param Calendar_CalendarModel $calendarModel
     * @param bool                   $isNewCalendar
     *
     * @return Event
     */
    private function onBeforeSave(Calendar_CalendarModel $calendarModel, $isNewCalendar)
    {
        $event = new Event($this, array("calendar" => $calendarModel, "isNewCalendar" => $isNewCalendar));
        $this->raiseEvent(CalendarPlugin::EVENT_BEFORE_SAVE, $event);

        return $event;
    }

    /**
     * Raises an event after calendar saving
     *
     * @param Calendar_CalendarModel $calendarModel
     * @param bool                   $isNewCalendar
     *
     * @return Event
     */
    private function onAfterSave(Calendar_CalendarModel $calendarModel, $isNewCalendar)
    {
        $event = new Event($this, array('calendar' => $calendarModel, 'isNewCalendar' => $isNewCalendar));
        $this->raiseEvent(CalendarPlugin::EVENT_AFTER_SAVE, $event);

        return $event;
    }

    /**
     * Raises an event before calendar deletion
     *
     * @param Calendar_CalendarModel $calendarModel
     *
     * @return Event
     */
    private function onBeforeDelete(Calendar_CalendarModel $calendarModel)
    {
        $event = new Event($this, array('calendar' => $calendarModel));
        $this->raiseEvent(CalendarPlugin::EVENT_BEFORE_DELETE, $event);

        return $event;
    }

    /**
     * Raises an event after calendar deletion
     *
     * @param Calendar_CalendarModel $calendarModel
     *
     * @return Event
     */
    private function onAfterDelete(Calendar_CalendarModel $calendarModel)
    {
        $event = new Event($this, array('calendar' => $calendarModel));
        $this->raiseEvent(CalendarPlugin::EVENT_AFTER_DELETE, $event);

        return $event;
    }
}
