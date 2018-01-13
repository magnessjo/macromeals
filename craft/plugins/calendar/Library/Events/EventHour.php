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

use Carbon\CarbonInterval;

class EventHour extends AbstractEventCollection
{
    /**
     * @return \DateInterval
     */
    protected function getInterval()
    {
        return CarbonInterval::hour();
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
        return array();
    }

    /**
     * @return Event[]
     */
    protected function buildEventCache()
    {
        return $this->getEventList()->getEventsByHour($this->getDate());
    }
}
