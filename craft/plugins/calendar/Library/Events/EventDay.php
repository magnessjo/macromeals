<?php

namespace Calendar\Library\Events;

use Calendar\Library\Duration\HourDuration;
use Carbon\CarbonInterval;

class EventDay extends AbstractEventCollection
{
    /** @var Event[] */
    private $allDayEvents;

    /** @var Event[] */
    private $nonAllDayEvents;

    /**
     * @return \DateInterval
     */
    protected function getInterval()
    {
        return CarbonInterval::day();
    }

    /**
     * @return Event[]
     */
    public function getNonAllDayEvents()
    {
        if (is_null($this->nonAllDayEvents)) {
            $events = $this->getEvents();

            foreach ($events as $key => $event) {
                if ($this->checkIfAllDayEvent($event)) {
                    unset($events[$key]);
                }
            }

            $this->nonAllDayEvents = $events;
        }

        return $this->nonAllDayEvents;
    }

    /**
     * @return int
     */
    public function getNonAllDayEventCount()
    {
        return count($this->getNonAllDayEvents());
    }

    /**
     * @return Event[]
     */
    public function getAllDayEvents()
    {
        if (is_null($this->allDayEvents)) {
            $eventList = array();

            foreach ($this->getEvents() as $event) {
                if ($this->checkIfAllDayEvent($event)) {
                    $eventList[] = $event;
                }
            }

            $this->allDayEvents = $eventList;
        }

        return $this->allDayEvents;
    }

    /**
     * @return int
     */
    public function getAllDayEventCount()
    {
        return count($this->getAllDayEvents());
    }

    /**
     * @return Event[]
     */
    protected function buildEventCache()
    {
        return $this->getEventList()->getEventsByDay($this->getDate());
    }

    /**
     * Builds an iterable object
     *
     * @param EventList $eventList
     *
     * @return array
     */
    protected function buildIterableObject(EventList $eventList)
    {
        $currentTime = $this->getStartDate();

        $hourList = array();
        foreach (range(0, 23) as $hour) {
            $currentTime->hour = $hour;

            $hourDuration = new HourDuration($currentTime);
            $eventHour    = new EventHour($hourDuration, $eventList);

            $hourList[] = $eventHour;
        }

        return $hourList;
    }

    /**
     * Builds a list of Events based on specific rules
     * Provided by the child object
     *
     * @param EventList $eventList
     *
     * @return array|Event[]
     */
    protected function buildEvents(EventList $eventList)
    {
        $dayStart = $this->getStartDate();
        $dayEnd   = $this->getEndDate();

        $events = array();
        foreach ($eventList->getEvents() as $event) {
            $eventStartDate = $event->getStartDate();
            $eventEndDate   = $event->getEndDate();

            if ($eventEndDate->gte($dayStart) && $eventStartDate->lte($dayEnd)) {
                $events[] = $event;
            }
        }

        return $events;
    }

    /**
     * Checks if an event matches "allDay" for the given day
     *
     * @param Event $event
     *
     * @return bool
     */
    private function checkIfAllDayEvent(Event $event)
    {
        $isAllDay = $event->isAllDay();
        if (!$isAllDay && $event->isMultiDay()) {
            $isAllDay = !$this->containsDate($event->getStartDate()) && !$this->containsDate($event->getEndDate());
        }

        return $isAllDay;
    }
}
