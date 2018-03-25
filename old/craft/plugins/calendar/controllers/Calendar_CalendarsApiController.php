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
use Calendar\Library\Events\EventList;
use Calendar\Library\Export\ExportCalendarToIcs;

class Calendar_CalendarsApiController extends BaseController
{
    protected $allowAnonymous = true;

    /**
     * @return null
     */
    public function actionIcs()
    {
        $icsHash = craft()->request->getSegment(5);
        $icsHash = str_replace('.ics', '', $icsHash);

        /** @var Calendar_CalendarsService $calendarService */
        $calendarService = craft()->calendar_calendars;
        /** @var Calendar_EventsService $eventsService */
        $eventsService = craft()->calendar_events;

        $calendar = $calendarService->getCalendarByIcsHash($icsHash);

        if (!$calendar) {
            $eventList = new EventList(array(), new EventListOptions());
        } else {
            $eventList = $eventsService->getEventList(
                array(
                    'calendarId'      => $calendar->id,
                    'loadOccurrences' => false,
                )
            );
        }

        $exporter = new ExportCalendarToIcs($eventList);

        header('Content-type: text/calendar; charset=utf-8');

        echo $exporter->output();
        exit();
    }
}
