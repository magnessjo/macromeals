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

class Calendar_ExceptionsService extends BaseApplicationComponent
{
    private static $cachedExceptions;

    /**
     * Returns a list of Calendar_ExceptionModel's if any are found
     *
     * @param Calendar_EventModel $eventModel
     *
     * @return Calendar_ExceptionModel[]
     */
    public function getExceptionsForEvent(Calendar_EventModel $eventModel)
    {
        if (!$eventModel->id || !$eventModel->repeats()) {
            return array();
        }

        return $this->getExceptionsForEventId($eventModel->id);
    }

    /**
     * @param int $eventId
     *
     * @return Calendar_ExceptionModel[]
     */
    public function getExceptionsForEventId($eventId)
    {
        if (is_null(self::$cachedExceptions)) {
            $exceptionRecords = Calendar_ExceptionRecord::model()->findAll();
            $exceptionModels  = Calendar_ExceptionModel::populateModels($exceptionRecords);

            $cache = array();
            foreach ($exceptionModels as $model) {
                $exceptionEventId = $model->eventId;
                if (!isset($cache[$exceptionEventId])) {
                    $cache[$exceptionEventId] = array();
                }
                $cache[$exceptionEventId][] = $model;
            }

            self::$cachedExceptions = $cache;
        }

        if (isset(self::$cachedExceptions[$eventId])) {
            return self::$cachedExceptions[$eventId];
        }

        return array();
    }

    /**
     * @param int $eventId
     *
     * @return array
     */
    public function getExceptionDatesForEventId($eventId)
    {
        $exceptions = $this->getExceptionsForEventId($eventId);

        $dates = array();
        foreach ($exceptions as $exception) {
            $dates[] = Carbon::createFromTimestampUTC($exception->date->getTimestamp())->toDateString();
        }

        return $dates;
    }

    /**
     * @param Calendar_EventModel $event
     * @param array               $exceptions
     */
    public function saveExceptions(Calendar_EventModel $event, array $exceptions)
    {
        $query = craft()->db->createCommand();
        $query->delete('calendar_exceptions', array('eventId' => $event->id));

        foreach ($exceptions as $exceptionDate) {
            $exceptionRecord          = new Calendar_ExceptionRecord();
            $exceptionRecord->eventId = $event->id;
            $exceptionRecord->date    = DateTimeUTC::createFromString($exceptionDate);

            $exceptionRecord->save();
        }
    }

    /**
     * @param Calendar_EventModel $event
     * @param DateTime            $date
     */
    public function saveException(Calendar_EventModel $event, DateTime $date)
    {
        $exceptionRecord          = new Calendar_ExceptionRecord();
        $exceptionRecord->eventId = $event->id;
        $exceptionRecord->date    = $date;

        $exceptionRecord->save();
    }

    /**
     * @param array|Calendar_ExceptionModel[] $exceptions
     *
     * @throws \CDbException
     */
    public function updateExceptions(array $exceptions)
    {
        $transaction = craft()->db->getCurrentTransaction() === null ? craft()->db->beginTransaction() : null;
        try {
            foreach ($exceptions as $exception) {
                $exceptionRecord = new Calendar_ExceptionRecord();
                $exceptionRecord->populateRecord($exception);

                $exceptionRecord->validate();

                $exceptionRecord->save(false);
            }

            if ($transaction !== null) {
                $transaction->commit();
            }
        } catch (\Exception $e) {
            if ($transaction !== null) {
                $transaction->rollback();
            }
        }
    }
}
