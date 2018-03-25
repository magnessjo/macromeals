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

namespace Calendar\Library\Events;

use Calendar\Library\Duration\WeekDuration;
use Carbon\CarbonInterval;

class EventMonth extends AbstractEventCollection
{
    /**
     * @return \DateInterval
     */
    protected function getInterval()
    {
        return CarbonInterval::month();
    }

    /**
     * @param EventList $eventList
     *
     * @return array
     */
    protected function buildIterableObject(EventList $eventList)
    {
        $weekList = array();

        $targetWeekDate = $this->getDate()->copy();
        $targetEndDate = $this->getEndDate()->copy()->endOfWeek();
        while ($targetEndDate->gt($targetWeekDate)) {
            $weekDuration = new WeekDuration($targetWeekDate);
            $eventWeek    = new EventWeek($weekDuration, $eventList);

            $weekList[] = $eventWeek;

            $targetWeekDate->addWeek();
        }

        return $weekList;
    }

    /**
     * @return Event[]
     */
    protected function buildEventCache()
    {
        return $this->getEventList()->getEventsByMonth($this->getDate());
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
}
