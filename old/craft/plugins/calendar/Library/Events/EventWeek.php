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

use Calendar\Library\Duration\DayDuration;
use Carbon\CarbonInterval;

class EventWeek extends AbstractEventCollection
{
    /**
     * @return \DateInterval
     */
    protected function getInterval()
    {
        return CarbonInterval::week();
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
        $dayList = array();

        $targetDate = $this->getStartDate();
        while ($this->getEndDate()->gt($targetDate)) {
            $dayDuration = new DayDuration($targetDate);
            $eventDay    = new EventDay($dayDuration, $eventList);

            $dayList[] = $eventDay;
            $targetDate->addDay();
        }

        return $dayList;
    }

    /**
     * @return Event[]
     */
    protected function buildEventCache()
    {
        return $this->getEventList()->getEventsByWeek($this->getDate());
    }
}
