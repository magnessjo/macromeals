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

abstract class AbstractExportCalendar implements ExportCalendarInterface
{

    /** @var EventList */
    private $events;

    /**
     * @param EventList $events
     */
    final public function __construct(EventList $events)
    {
        $this->events = $events;
    }

    /**
     * Collects the exportable string and outputs it
     * Sets headers to file download and content-type to text/calendar
     *
     * @return string
     */
    final public function export()
    {
        header('Content-type: text/calendar; charset=utf-8');
        header('Content-Disposition: attachment; filename=' . time() . '.ics');

        $exportString = $this->prepareStringForExport();

        echo $exportString;
        exit();
    }

    /**
     * Collects the exportable string and returns it
     *
     * @return string
     */
    final public function output()
    {
        return $this->prepareStringForExport();
    }

    /**
     * Collect events and parse them, and build a string
     * That will be exported to a file
     *
     * @return string
     */
    abstract protected function prepareStringForExport();

    /**
     * @return EventList
     */
    final protected function getEvents()
    {
        return $this->events;
    }

    /**
     * @param string $string
     *
     * @return string
     */
    final protected function prepareString($string)
    {
        $string = (string) preg_replace('/(\r\n|\r|\n)+/', ' ', $string);
        $string = (string) preg_replace('/([\,;])/', '\\\$1', $string);
        $string = (string) preg_replace('/^\h*\v+/m', '', $string);
        $string = chunk_split($string, 60, "\r\n ");
        $string = trim($string);

        return $string;
    }
}
