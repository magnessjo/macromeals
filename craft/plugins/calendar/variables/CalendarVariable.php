<?php

namespace Craft;

use Calendar\Library\Carbon;
use Calendar\Library\DataObjects\OccurrenceLoader;
use Calendar\Library\DateHelper;
use Calendar\Library\Events\Event as EventObject;
use Calendar\Library\Events\EventDay;
use Calendar\Library\Events\EventHour;
use Calendar\Library\Events\EventList;
use Calendar\Library\Events\EventMonth;
use Calendar\Library\Events\EventWeek;
use Calendar\Library\Export\ExportCalendarToIcs;
use Calendar\Library\PermissionsHelper;
use Calendar\Library\RecurrenceHelper;

class CalendarVariable
{
    /**
     * @return string
     */
    public function showDemoTemplateBanner()
    {
        return !$this->settings()->isDemoBannerDisabled();
    }

    /**
     * @param int|\Calendar\Library\Events\Event|Calendar_EventModel $event
     *
     * @return bool
     */
    public function canEditEvent($event)
    {
        return craft()->calendar_events->canEditEvent($event);
    }

    /**
     * @param array|null $attributes
     *
     * @return Calendar_EventCriteriaModel
     */
    public function events($attributes = null)
    {
        /** @var Calendar_EventsService $eventsService */
        $eventsService = craft()->calendar_events;

        return $eventsService->getEventCriteria($attributes);
    }

    /**
     * Get a single event
     *
     * @param int   $id
     * @param array $options - [occurrenceDate, occurrenceRangeStart, occurrenceRangeEnd, occurrenceLimit]
     *
     * @return EventObject
     */
    public function event($id, array $options = array())
    {
        if ($id === 'new') {
            return EventObject::createFromModel(new Calendar_EventModel());
        }

        $targetDate = null;
        if (isset($options['occurrenceDate'])) {
            $targetDate = new Carbon($options['occurrenceDate'], DateTime::UTC);
        }

        $occurrenceLoader = OccurrenceLoader::create($options);

        $enabledOnly = true;
        if (array_key_exists('status', $options)) {
            $enabledOnly = $options['status'];
        }

        $localeId = null;
        if (isset($options['locale'])) {
            $localeId = $options['locale'];
        }

        /** @var Calendar_EventsService $eventsService */
        $eventsService = craft()->calendar_events;

        $eventModel = null;
        if (is_numeric($id)) {
            $eventModel = $eventsService->getEventById($id, $localeId, $enabledOnly);
        } else if (is_string($id)) {
            $eventModel = $eventsService->getEventBySlug($id, $localeId, $enabledOnly);
        }

        if (!$eventModel) {
            return null;
        }

        $event = EventObject::createFromModel($eventModel, $targetDate, $occurrenceLoader);

        return $event;
    }

    /**
     * @param array $events
     */
    public function export($events)
    {
        if ($events instanceof Calendar_EventCriteriaModel) {
            $events = $events->find();
        }

        $exporter = new ExportCalendarToIcs($events);

        $exporter->export();
    }

    /**
     * @param array|null $attributes
     *
     * @return EventList
     */
    public function calendars($attributes = null)
    {
        /** @var Calendar_CalendarsService $calendarService */
        $calendarService = craft()->calendar_calendars;

        return $calendarService->getCalendars($attributes);
    }

    /**
     * Returns a SHA-1 hash of the latest modification date and calendar count
     *
     * @return string
     */
    public function calendarsCacheKey()
    {
        /** @var Calendar_CalendarsService $calendarService */
        $calendarService = craft()->calendar_calendars;

        return sha1($calendarService->getLatestModificationDate() . $calendarService->getAllCalendarCount());
    }

    /**
     * Returns a SHA-1 hash of the latest modification date and event count
     *
     * @return string
     */
    public function eventsCacheKey()
    {
        /** @var Calendar_EventsService $eventsService */
        $eventsService = craft()->calendar_events;

        return sha1($eventsService->getLatestModificationDate() . $eventsService->getAllEventCount());
    }

    /**
     * @param array|null $attributes
     *
     * @return Calendar_CalendarModel|null
     */
    public function calendar($attributes = null)
    {
        /** @var Calendar_CalendarsService $calendarService */
        $calendarService = craft()->calendar_calendars;

        $calendarList = $calendarService->getCalendars($attributes);

        return reset($calendarList);
    }

    /**
     * @return array
     */
    public function allowedCalendars()
    {
        /** @var Calendar_CalendarsService $calendarService */
        $calendarService = craft()->calendar_calendars;

        return $calendarService->getAllAllowedCalendars();
    }

    /**
     * @param array $attributes
     *
     * @return EventMonth
     */
    public function month(array $attributes = null)
    {
        /** @var Calendar_ViewDataService $viewDataService */
        $viewDataService = craft()->calendar_viewData;

        return $viewDataService->getMonth($attributes);
    }

    /**
     * @param array $attributes
     *
     * @return EventWeek
     */
    public function week(array $attributes = null)
    {
        /** @var Calendar_ViewDataService $viewDataService */
        $viewDataService = craft()->calendar_viewData;

        return $viewDataService->getWeek($attributes);
    }

    /**
     * @param array $attributes
     *
     * @return EventDay
     */
    public function day(array $attributes = null)
    {
        /** @var Calendar_ViewDataService $viewDataService */
        $viewDataService = craft()->calendar_viewData;

        return $viewDataService->getDay($attributes);
    }

    /**
     * @param array $attributes
     *
     * @return EventHour
     */
    public function hour(array $attributes = null)
    {
        /** @var Calendar_ViewDataService $viewDataService */
        $viewDataService = craft()->calendar_viewData;

        return $viewDataService->getHour($attributes);
    }

    /**
     * @return Calendar_SettingsService
     */
    public function settings()
    {
        return craft()->calendar_settings;
    }

    /**
     * @return array
     */
    public function frequencyOptions()
    {
        return RecurrenceHelper::getFrequencyOptions();
    }

    /**
     * @return array
     */
    public function repeatsByOptions()
    {
        return RecurrenceHelper::getRepeatsByOptions();
    }

    /**
     * @return array
     */
    public function weekDaysShort()
    {
        return DateHelper::getWeekDaysShort();
    }

    /**
     * @return array
     */
    public function monthDays()
    {
        return DateHelper::getMonthDays();
    }

    /**
     * @return array
     */
    public function monthNames()
    {
        return DateHelper::getMonthNames();
    }
}
