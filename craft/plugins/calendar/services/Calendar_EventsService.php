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

use Calendar\Library\DataObjects\EventListOptions;
use Calendar\Library\DateHelper;
use Calendar\Library\Events\Event as EventObject;
use Calendar\Library\Events\EventList;
use Calendar\Library\PermissionsHelper;

class Calendar_EventsService extends BaseApplicationComponent
{
    /**
     * Returns an event by its ID.
     *
     * @param int    $eventId
     * @param string $localeId
     * @param bool   $enabledOnly
     *
     * @return Calendar_EventModel
     */
    public function getEventById($eventId, $localeId = null, $enabledOnly = true)
    {
        $criteria = craft()->elements->getCriteria(Calendar_EventModel::ELEMENT_TYPE);
        $criteria->setAttribute('allowedCalendarsOnly', false);
        $criteria->setAttribute('id', $eventId);
        $criteria->setAttribute('locale', $localeId);
        $criteria->setAttribute('limit', 1);

        if (!$enabledOnly) {
            $criteria->setAttribute('status', null);
            $criteria->setAttribute('localeEnabled', null);
        }

        return $criteria->first();
    }

    /**
     * Returns an event by its slug.
     *
     * @param string $slug
     * @param string $localeId
     * @param bool   $enabledOnly
     *
     * @return Calendar_EventModel
     */
    public function getEventBySlug($slug, $localeId = null, $enabledOnly = true)
    {
        $criteria = craft()->elements->getCriteria(Calendar_EventModel::ELEMENT_TYPE);
        $criteria->setAttribute('allowedCalendarsOnly', false);
        $criteria->setAttribute('slug', $slug);
        $criteria->setAttribute('locale', $localeId);
        $criteria->setAttribute('limit', 1);

        if (!$enabledOnly) {
            $criteria->setAttribute('status', null);
            $criteria->setAttribute('localeEnabled', null);
        }

        return $criteria->first();
    }

    /**
     * @param array  $eventIds
     * @param string $locale
     *
     * @return Calendar_EventModel[]
     */
    public function getEventsByIds(array $eventIds, $locale = null)
    {
        $criteria = craft()->elements->getCriteria(Calendar_EventModel::ELEMENT_TYPE);
        $criteria->setAttribute('allowedCalendarsOnly', false);
        $criteria->setAttribute('id', $eventIds);
        $criteria->setAttribute('status', null);
        $criteria->setAttribute('limit', null);
        $criteria->setAttribute('offset', null);

        if (null !== $locale) {
            $criteria->setAttribute('locale', $locale);
        }

        $events = $criteria->find();

        $indexedById = array();
        foreach ($events as $event) {
            $indexedById[$event->id] = $event;
        }

        unset($events);

        return $indexedById;
    }

    /**
     * @param mixed $criteria
     *
     * @return EventList
     */
    public function getEventList($criteria = null)
    {
        if (!isset($criteria['allowedCalendarsOnly'])) {
            $criteria['allowedCalendarsOnly'] = false;
        }

        if (isset($criteria['date'])) {
            unset($criteria['date']);
        }

        $hasLimit = isset($criteria['limit']);

        /** @var ElementCriteriaModel $criteria */
        $criteria = craft()->elements->getCriteria(Calendar_EventModel::ELEMENT_TYPE, $criteria);

        if (!$hasLimit) {
            $criteria->setAttribute('limit', null);
        }

        /** @var Calendar_SettingsService $settings */
        $settings = craft()->calendar_settings;

        $eventListOptions = new EventListOptions();
        $eventListOptions
            ->setRangeStart($criteria->dateRangeStart)
            ->setRangeEnd($criteria->dateRangeEnd)
            ->setLimit($criteria->limit)
            ->setOffset($criteria->offset)
            ->setOrder($criteria->order ?: null)
            ->setLoadOccurrences($criteria->loadOccurrences)
            ->setOverlapThreshold($settings->getOverlapThreshold())
            ->setLocale($criteria->locale ?: null);

        $eventIds = array();
        if ($criteria->calendarId !== 0) {
            $eventIds = $criteria->ids();
        }

        return new EventList($eventIds, $eventListOptions);
    }

    /**
     * @param null|array $attributes
     *
     * @return Calendar_EventCriteriaModel
     */
    public function getEventCriteria($attributes = null)
    {
        $criteria = new Calendar_EventCriteriaModel($attributes);
        $criteria->setAttribute('allowedCalendarsOnly', false);

        return $criteria;
    }

    /**
     * @param array $ids
     *
     * @return mixed
     */
    public function getSingleEventMetadata(array $ids = null)
    {
        $singleEventIdList = craft()->db
            ->createCommand()
            ->select('id, startDate')
            ->from('calendar_events')
            ->where(
                array(
                    'and',
                    'freq IS NULL',
                    array('in', 'id', $ids),
                )
            )
            ->queryAll();

        return $singleEventIdList;
    }

    /**
     * @param array $ids
     *
     * @return mixed
     */
    public function getRecurringEventMetadata(array $ids = null)
    {
        $singleEventIdList = craft()->db
            ->createCommand()
            ->select('id, startDate, endDate, freq, count, interval, byDay, byMonthDay, byMonth, byYearDay, until')
            ->from('calendar_events')
            ->where(
                array(
                    'and',
                    'freq IS NOT NULL',
                    array('in', 'id', $ids),
                )
            )
            ->queryAll();

        return $singleEventIdList;
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
            ->from('calendar_events')
            ->limit(1)
            ->queryScalar();
    }

    /**
     * @return String
     */
    public function getAllEventCount()
    {
        return craft()
            ->db
            ->createCommand()
            ->select('COUNT(id)')
            ->from('calendar_events')
            ->queryScalar();
    }

    /**
     * @param Calendar_EventModel $event
     *
     * @return bool
     * @throws Exception
     * @throws \Exception
     */
    public function saveEvent(Calendar_EventModel $event, $validateContent = null)
    {
        $isNewEvent = !$event->id;

        if (!$isNewEvent) {
            $eventRecord = Calendar_EventRecord::model()->findById($event->id);

            if (!$eventRecord) {
                throw new Exception(Craft::t('Could not find an Event with ID {id}', array('id' => $event->id)));
            }
        } else {
            $eventRecord = new Calendar_EventRecord();
        }

        if (!$event->getCalendar()->hasTitleField) {
            $generatedTitle = craft()
                ->templates
                ->renderObjectTemplate($event->getCalendar()->titleFormat, $event);

            $generatedTitle = trim($generatedTitle);

            if (!empty($generatedTitle)) {
                $event->getContent()->title = $generatedTitle;
            }
        }

        $beforeSaveEvent = $this->onBeforeSave($event, $isNewEvent);

        $eventRecord->calendarId = $event->calendarId;
        $eventRecord->authorId   = $event->authorId;
        $eventRecord->startDate  = $event->startDate;
        $eventRecord->endDate    = $event->endDate;
        $eventRecord->allDay     = $event->allDay;

        $eventRecord->rrule      = $event->rrule;
        $eventRecord->freq       = $event->freq;
        $eventRecord->interval   = $event->interval;
        $eventRecord->until      = $event->until;
        $eventRecord->count      = $event->count;
        $eventRecord->byDay      = $event->byDay;
        $eventRecord->byMonth    = $event->byMonth;
        $eventRecord->byMonthDay = $event->byMonthDay;
        $eventRecord->byYearDay  = $event->byYearDay;

        ElementHelper::setUniqueUri($event);

        $eventRecord->validate();
        $event->addErrors($eventRecord->getErrors());

        if ($beforeSaveEvent->performAction && !$event->hasErrors()) {
            $transaction = craft()->db->getCurrentTransaction() === null ? craft()->db->beginTransaction() : null;
            try {
                $isSaved = craft()->elements->saveElement($event, $validateContent);
                if ($isSaved) {
                    if ($isNewEvent) {
                        $eventRecord->id = $event->id;
                    }

                    $eventRecord->save(false);

                    if ($transaction !== null) {
                        $transaction->commit();
                    }

                    $this->onAfterSave($event, $isNewEvent);

                    return true;
                }
            } catch (\Exception $e) {
                if ($transaction !== null) {
                    $transaction->rollback();
                }

                throw $e;
            }
        }

        return false;
    }

    /**
     * @param int $eventId
     *
     * @return bool
     */
    public function deleteEventById($eventId)
    {
        $event = $this->getEventById($eventId, null, false);

        if (!$event) {
            return false;
        }

        if (!$this->onBeforeDelete($event)->performAction) {
            return false;
        }

        if (craft()->elements->deleteElementById($eventId)) {
            $this->onAfterDelete($event);

            return true;
        } else {
            return false;
        }
    }

    /**
     * Bumps all event recurrences by the given $amountOfDays
     * E.g. - if the event repeats weekly on Tue and Fri, and it gets bumped by -1 day
     *        the event would then repeat on Mon and Thu.
     *        Bumping by 8 days would set it to Wed and Sat
     *
     * @param Calendar_EventModel $event
     * @param int                 $amountOfDays
     */
    public function bumpRecurrenceRule(Calendar_EventModel $event, $amountOfDays, $amountOfMonths)
    {
        if (!$event->repeats()) {
            return;
        }

        $event->byDay      = DateHelper::shiftByDays($event->byDay, $amountOfDays);
        $event->byMonthDay = DateHelper::shiftByMonthDay($event->byMonthDay, $amountOfDays);

        if ($amountOfMonths) {
            $event->byMonth = DateHelper::shiftByMonth($event->byMonth, $amountOfMonths);
        }
    }

    /**
     * @param Event $event
     *
     * @return bool
     */
    public function addLocaleHandler(Event $event)
    {
        $localeId      = $event->params['localeId'];
        $primaryLocale = craft()->i18n->getPrimarySiteLocaleId();

        $elementRows = craft()->db
            ->createCommand()
            ->select('ei18n.*')
            ->from('elements_i18n ei18n')
            ->join('calendar_events e', 'ei18n.elementId = e.id')
            ->where('ei18n.locale = :locale', array(':locale' => $primaryLocale))
            ->queryAll();

        $contentRows = craft()->db
            ->createCommand()
            ->select('c.*')
            ->from('content c')
            ->join('calendar_events e', 'c.elementId = e.id')
            ->where('c.locale = :locale', array(':locale' => $primaryLocale))
            ->queryAll();

        $elementDataById = array();
        foreach ($elementRows as $elementData) {
            $elementDataById[$elementData['elementId']] = $elementData;
        }

        $contentDataById = array();
        foreach ($contentRows as $content) {
            unset(
                $content['locale'],
                $content['id'],
                $content['dateCreated'],
                $content['dateUpdated'],
                $content['uid']
            );
            $contentDataById[$content['elementId']] = $content;
        }

        foreach ($elementDataById as $elementId => $elementData) {
            $elementId = $elementData['elementId'];

            craft()->db
                ->createCommand()
                ->insertAll(
                    'elements_i18n',
                    array('elementId', 'locale', 'slug', 'enabled'),
                    array(array($elementId, $localeId, $elementData['slug'], true))
                );

            if (isset($contentDataById[$elementId])) {
                $content = $contentDataById[$elementId];

                $columns = array_keys($content);
                $values  = array_values($content);

                $columns[] = 'locale';
                $values[]  = $localeId;

                craft()->db->createCommand()->insertAll('content', $columns, array($values));
            }
        }

        return true;
    }

    /**
     * @param int|EventObject|Calendar_EventModel $event
     *
     * @return bool
     */
    public function canEditEvent($event)
    {
        /** @var Calendar_SettingsService $settings */
        $settings      = craft()->calendar_settings;
        $settingsModel = $settings->getSettingsModel();
        $guestAccess   = $settingsModel->guestAccess;

        $eventModel = null;
        if ($event instanceof EventObject && null !== $event->getId()) {
            $eventModel = $this->getEventById($event->getId());
        } else if ($event instanceof Calendar_EventModel) {
            $eventModel = $event;
        } else if (is_numeric($event) && (int) $event) {
            $eventModel = $this->getEventById($event);
        }

        if (null === $eventModel && null !== $guestAccess) {
            return true;
        }

        return PermissionsHelper::checkPermission(PermissionsHelper::PERMISSION_EVENTS, true);
    }

    /**
     * @param int|EventObject|Calendar_EventModel $event
     *
     * @return bool
     * @throws HttpException
     */
    public function requireEventEditPermissions($event)
    {
        if (!$this->canEditEvent($event)) {
            throw new HttpException(404);
        }

        return true;
    }

    /**
     * Raises an event before calendar event saving
     *
     * @param Calendar_EventModel $eventModel
     * @param bool                $isNewEvent
     *
     * @return Event
     */
    private function onBeforeSave(Calendar_EventModel $eventModel, $isNewEvent)
    {
        $event = new Event($this, array('event' => $eventModel, 'isNewEvent' => $isNewEvent));
        $this->raiseEvent(CalendarPlugin::EVENT_BEFORE_SAVE, $event);

        return $event;
    }

    /**
     * Raises an event after calendar event saving
     *
     * @param Calendar_EventModel $eventModel
     * @param bool                $isNewEvent
     *
     * @return Event
     */
    private function onAfterSave(Calendar_EventModel $eventModel, $isNewEvent)
    {
        $event = new Event($this, array('event' => $eventModel, 'isNewEvent' => $isNewEvent));
        $this->raiseEvent(CalendarPlugin::EVENT_AFTER_SAVE, $event);

        return $event;
    }

    /**
     * Raises an event before calendar event deleting
     *
     * @param Calendar_EventModel $eventModel
     *
     * @return Event
     */
    private function onBeforeDelete(Calendar_EventModel $eventModel)
    {
        $event = new Event($this, array('event' => $eventModel));
        $this->raiseEvent(CalendarPlugin::EVENT_BEFORE_DELETE, $event);

        return $event;
    }

    /**
     * Raises an event after calendar event deleting
     *
     * @param Calendar_EventModel $eventModel
     *
     * @return Event
     */
    private function onAfterDelete(Calendar_EventModel $eventModel)
    {
        $event = new Event($this, array('event' => $eventModel));
        $this->raiseEvent(CalendarPlugin::EVENT_AFTER_DELETE, $event);

        return $event;
    }
}
