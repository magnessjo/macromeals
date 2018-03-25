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
