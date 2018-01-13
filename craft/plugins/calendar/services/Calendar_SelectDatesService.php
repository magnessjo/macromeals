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

use Calendar\Library\DateTimeUTC;
use Calendar\Library\Carbon;
use Calendar\Library\Events\Event as SimpleEvent;

class Calendar_SelectDatesService extends BaseApplicationComponent
{
    /**
     * Returns a list of Calendar_SelectDateModel's if any are found
     *
     * @param Calendar_EventModel $eventModel
     *
     * @return Calendar_SelectDateModel[]
     */
    public function getSelectDatesForEvent(Calendar_EventModel $eventModel) {
        return $this->getSelectDatesForEventId($eventModel->id);
    }

    /**
     * Returns a list of Calendar_SelectDateModel's if any are found
     *
     * @param SimpleEvent $event
     *
     * @return Calendar_SelectDateModel[]
     */
    public function getSelectDatesForEventObject(SimpleEvent $event) {
        return $this->getSelectDatesForEventId($event->getId());
    }

    /**
     * Returns a list of Calendar_SelectDateModel's if any are found
     *
     * @param int       $eventId
     *
     * @return Calendar_SelectDateModel[]
     */
    public function getSelectDatesForEventId($eventId)
    {
        if (!$eventId) {
            return array();
        }

        $conditions = array();
        $params     = array();

        $selectDateRecords = Calendar_SelectDateRecord::model()->findAllByAttributes(
            array('eventId' => $eventId),
            implode(' AND ', $conditions),
            $params
        );

        $selectDateModels = Calendar_SelectDateModel::populateModels($selectDateRecords);

        usort(
            $selectDateModels,
            function (Calendar_SelectDateModel $dateA, Calendar_SelectDateModel $dateB) {
                if ($dateA->date < $dateB->date) {
                    return -1;
                }

                if ($dateA->date > $dateB->date) {
                    return 1;
                }

                return 0;
            }
        );

        return $selectDateModels;
    }

    /**
     * Returns a list of date strings
     *
     * @param int       $eventId
     *
     * @return Carbon[]
     */
    public function getSelectDatesAsCarbonsForEventId($eventId) {
        $selectDates = $this->getSelectDatesForEventId($eventId);

        $dateStrings = array();
        foreach ($selectDates as $date) {
            $dateStrings[] = Carbon::createFromTimestampUTC($date->date->getTimestamp());
        }

        return $dateStrings;
    }

    /**
     * @param Calendar_EventModel $event
     * @param array               $dates
     */
    public function saveDates(Calendar_EventModel $event, array $dates)
    {
        $query = craft()->db->createCommand();
        $query->delete('calendar_select_dates', array('eventId' => $event->id));

        foreach ($dates as $selectDate) {
            $selectDateRecord          = new Calendar_SelectDateRecord();
            $selectDateRecord->eventId = $event->id;
            $selectDateRecord->date    = DateTimeUTC::createFromString($selectDate);

            $selectDateRecord->save();
        }
    }

    /**
     * @param Calendar_EventModel $event
     * @param DateTime            $date
     */
    public function removeDate(Calendar_EventModel $event, DateTime $date)
    {
        $records = Calendar_SelectDateRecord::model()->findAllByAttributes(
            array(
                'eventId' => $event->id,
                'date'    => $date->format('Y-m-d H:i:s'),
            )
        );

        foreach ($records as $record) {
            $record->delete();
        }
    }
}
