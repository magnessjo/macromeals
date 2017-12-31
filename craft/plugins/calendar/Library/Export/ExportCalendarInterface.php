<?php

namespace Calendar\Library\Export;

use Calendar\Library\Events\EventList;

interface ExportCalendarInterface
{
    const DATE_TIME_FORMAT = 'Ymd\THis';
    const DATE_FORMAT      = 'Ymd';

    /**
     * ExportCalendarInterface constructor.
     *
     * Must pass an array of events that will be exported
     *
     * @param EventList $events
     */
    public function __construct(EventList $events);

    /**
     * @return string
     */
    public function export();

    /**
     * @return string
     */
    public function output();
}
