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

use Calendar\Library\Carbon;
use Calendar\Library\DataObjects\EventListOptions;
use Calendar\Library\DateHelper;
use Calendar\Library\RecurrenceHelper;
use Craft\Calendar_EventModel;
use Craft\Calendar_EventsService;
use Craft\Calendar_ExceptionsService;
use Craft\Calendar_SelectDatesService;
use Craft\DateTime;
use RRule\RRule;

class EventList implements \Iterator, \ArrayAccess, \Countable
{
    const FORMAT_MONTH = 'Ym';
    const FORMAT_WEEK  = 'YW';
    const FORMAT_DAY   = 'Ymd';
    const FORMAT_HOUR  = 'YmdH';

    /** @var int Iterator position */
    private $position;

    /** @var array - events ordered by startDate */
    private $eventsByDate;

    /** @var Event[] - events ordered by date */
    private $events;

    /** @var array */
    private $eventIds;

    /** @var Carbon */
    private $rangeStart;

    /** @var Carbon */
    private $rangeEnd;

    /** @var int */
    private $limit;

    /** @var int */
    private $offset;

    /** @var int */
    private $total;

    /** @var string */
    private $order;

    /** @var bool */
    private $shuffle;

    /** @var string */
    private $sort;

    /** @var bool */
    private $loadOccurrences;

    /** @var int */
    private $overlapThreshold;

    /** @var string */
    private $locale;

    /** @var array - [date, [eventId, ..]] */
    private $eventCache;

    /** @var array */
    private $eventsByMonth;

    /** @var array */
    private $eventsByWeek;

    /** @var array */
    private $eventsByDay;

    /** @var array */
    private $eventsByHour;

    /**
     * EventList constructor.
     *
     * @param array            $eventIds
     * @param EventListOptions $eventListOptions
     */
    public function __construct(array $eventIds, EventListOptions $eventListOptions)
    {
        $this->rangeStart       = $eventListOptions->getRangeStart();
        $this->rangeEnd         = $eventListOptions->getRangeEnd();
        $this->limit            = $eventListOptions->getLimit();
        $this->offset           = $eventListOptions->getOffset();
        $this->order            = $eventListOptions->getOrder();
        $this->shuffle          = $eventListOptions->isShuffle();
        $this->sort             = $eventListOptions->getSort();
        $this->loadOccurrences  = $eventListOptions->loadOccurrences();
        $this->overlapThreshold = $eventListOptions->getOverlapThreshold();
        $this->locale           = $eventListOptions->getLocale();

        $this->eventCache   = array();
        $this->eventsByDate = array();
        $this->events       = array();
        $this->position     = 0;
        $this->total        = 0;

        $this->buildEventList($eventIds);
    }

    /**
     * Returns the generated list of events
     *
     * @return Event[]
     */
    public function getEvents()
    {
        return $this->events;
    }

    /**
     * @return array
     */
    public function getEventIds()
    {
        return $this->eventIds;
    }

    /**
     * Returns a JSON encoded string of all events in this list
     *
     * @return array
     */
    public function getEventsAsSimpleObject()
    {
        $eventArray = array();
        foreach ($this->events as $eventModel) {
            $eventArray[] = $eventModel->toSimpleObject();
        }

        return $eventArray;
    }

    /**
     * @param Carbon $date
     *
     * @return Event[]
     */
    public function getEventsByMonth(Carbon $date)
    {
        $month = $date->format(self::FORMAT_MONTH);

        return isset($this->eventsByMonth[$month]) ? $this->eventsByMonth[$month] : array();
    }

    /**
     * @param Carbon $date
     *
     * @return Event[]
     */
    public function getEventsByWeek(Carbon $date)
    {
        $week = DateHelper::getCacheWeekNumber($date);

        return isset($this->eventsByWeek[$week]) ? $this->eventsByWeek[$week] : array();
    }

    /**
     * @param Carbon $date
     *
     * @return Event[]
     */
    public function getEventsByDay(Carbon $date)
    {
        $day = $date->format(self::FORMAT_DAY);

        return isset($this->eventsByDay[$day]) ? $this->eventsByDay[$day] : array();
    }

    /**
     * @param Carbon $date
     *
     * @return Event[]
     */
    public function getEventsByHour(Carbon $date)
    {
        $hour = $date->format(self::FORMAT_HOUR);

        return isset($this->eventsByHour[$hour]) ? $this->eventsByHour[$hour] : array();
    }

    /**
     * @return int
     */
    public function getTotal()
    {
        return $this->total;
    }

    /**
     * Iterates through all events currently in place and generates
     * an event entry for each occurrence
     *
     * @param array $eventIds
     */
    private function buildEventList(array $eventIds)
    {
        if (empty($eventIds)) {
            return;
        }

        $this->cacheSingleEvents($eventIds);
        $this->cacheRecurringEvents($eventIds);

        unset($eventIds);
        $this->total = count($this->eventCache);

        // Order the dates in a chronological order
        if ($this->shouldOrderByStartDate()) {
            $this->orderDates($this->eventCache);
        }

        if ($this->shuffle) {
            shuffle($this->eventCache);
        }

        // Remove excess dates based on ::$limit and ::$offset
        $this->cutOffExcess($this->eventCache);

        $this->cacheToStorage();

        if (!$this->loadOccurrences && $this->shouldOrderByStartDate()) {
            // Order the events based on strict ordering rules
            $this->orderEvents($this->events);
        }

        // Build up an event cache, to be accessed later
        $this->cacheEvents();
    }

    /**
     * Picks out the single events from the given $foundIds list
     * Adds them all to event cache
     *
     * @param array $foundIds
     */
    private function cacheSingleEvents($foundIds)
    {
        $singleEventMetadata = $this->getEventService()->getSingleEventMetadata($foundIds);

        foreach ($singleEventMetadata as $metadata) {
            $startDate = new Carbon($metadata['startDate'], DateTime::UTC);
            $this->cacheEvent($metadata['id'], $startDate);
        }
    }

    /**
     * Picks out the recurring events from $foundIds list
     * Generates their recurrences within the current date range
     * Stores the valid event occurrences in cache
     *
     * @param array $foundIds
     */
    private function cacheRecurringEvents(array $foundIds)
    {
        $recurringEventMetadata = $this->getEventService()->getRecurringEventMetadata($foundIds);

        foreach ($recurringEventMetadata as $metadata) {
            $eventId         = $metadata['id'];
            $startDate       = $metadata['startDate'];
            $endDate         = $metadata['endDate'];
            $startDateCarbon = new Carbon($startDate, DateTime::UTC);
            $endDateCarbon   = new Carbon($endDate, DateTime::UTC);
            $freq            = $metadata['freq'];

            // If we're not loading occurrences,
            // We must check the first event to see if it matches the given range
            // And add it accordingly
            if (!$this->loadOccurrences) {
                $isOutsideStartRange = $this->rangeStart && $startDateCarbon->lt($this->rangeStart);
                $isOutsideEndRange   = $this->rangeEnd && $endDateCarbon->gt($this->rangeEnd);

                if ($isOutsideStartRange || $isOutsideEndRange) {
                    continue;
                }

                $this->cacheEvent($eventId, $startDateCarbon);
                continue;
            }

            switch ($freq) {
                case RecurrenceHelper::SELECT_DATES:
                    $paddedRangeStart = $this->getPaddedRangeStart();
                    $paddedRangeEnd   = $this->getPaddedRangeEnd();

                    $selectDates = $this
                        ->getSelectDatesService()
                        ->getSelectDatesAsCarbonsForEventId($eventId, $paddedRangeStart, $paddedRangeEnd);

                    array_unshift($selectDates, new Carbon($metadata["startDate"], DateTime::UTC));

                    foreach ($selectDates as $date) {
                        /**
                         * @var Carbon $occurrenceStartDate
                         * @var Carbon $occurrenceEndDate
                         */
                        list($occurrenceStartDate, $occurrenceEndDate) = DateHelper::getRelativeEventDates(
                            $startDateCarbon,
                            $endDateCarbon,
                            $date
                        );

                        $isOutsideStartRange = $this->rangeStart && $occurrenceEndDate->lt($this->rangeStart);
                        $isOutsideEndRange   = $this->rangeEnd && $occurrenceStartDate->gt($this->rangeEnd);

                        if ($isOutsideStartRange || $isOutsideEndRange) {
                            continue;
                        }

                        $this->cacheEvent($eventId, $occurrenceStartDate);
                    }

                    break;

                default:
                    $rruleObject = $this->getRRuleFromEventMetadata($metadata);

                    if (!$rruleObject) {
                        continue;
                    }

                    $paddedRangeStart = $this->getPaddedRangeStart($rruleObject->isInfinite() ? $startDate : null);
                    $paddedRangeEnd   = $this->getPaddedRangeEnd($rruleObject->isInfinite() ? $freq : null);

                    $occurrences = $rruleObject->getOccurrencesBetween($paddedRangeStart, $paddedRangeEnd);
                    $exceptions  = $this->getExceptionService()->getExceptionDatesForEventId($eventId);

                    foreach ($occurrences as $occurrence) {
                        if (in_array($occurrence->format('Y-m-d'), $exceptions)) {
                            continue;
                        }

                        /**
                         * @var Carbon $occurrenceStartDate
                         * @var Carbon $occurrenceEndDate
                         */
                        list($occurrenceStartDate, $occurrenceEndDate) = DateHelper::getRelativeEventDates(
                            $startDateCarbon,
                            $endDateCarbon,
                            $occurrence
                        );

                        $isOutsideStartRange = $this->rangeStart && $occurrenceEndDate->lt($this->rangeStart);
                        $isOutsideEndRange   = $this->rangeEnd && $occurrenceStartDate->gt($this->rangeEnd);

                        if ($isOutsideStartRange || $isOutsideEndRange) {
                            continue;
                        }

                        $this->cacheEvent($eventId, $occurrenceStartDate);
                    }

                    break;
            }
        }
    }

    /**
     * @param string $relativeDate
     *
     * @return Carbon
     */
    private function getPaddedRangeStart($relativeDate = null)
    {
        $paddedRangeStart = null;
        if ($this->rangeStart) {
            $paddedRangeStart = $this->rangeStart->copy()->subWeek();
        } elseif ($relativeDate) {
            $paddedRangeStart = new Carbon($relativeDate, DateTime::UTC);
        }

        return $paddedRangeStart;
    }

    /**
     * @param string $recurrenceFrequency
     *
     * @return Carbon
     */
    private function getPaddedRangeEnd($recurrenceFrequency = null)
    {
        $paddedRangeEnd = null;
        if ($this->rangeEnd) {
            $paddedRangeEnd = $this->rangeEnd->copy()->addWeek();
        } elseif ($recurrenceFrequency) {
            $paddedRangeEnd = new Carbon(DateTime::UTC);

            switch ($recurrenceFrequency) {
                case RecurrenceHelper::DAILY:
                    $paddedRangeEnd->addMonth();
                    break;

                case RecurrenceHelper::WEEKLY:
                    $paddedRangeEnd->addMonths(6);
                    break;

                default:
                    $paddedRangeEnd->addYear();
                    break;
            }
        }

        return $paddedRangeEnd;
    }

    /**
     * @param array $eventMetadata
     *
     * @return null|RRule
     */
    private function getRRuleFromEventMetadata($eventMetadata)
    {
        $startDate  = $eventMetadata['startDate'];
        $freq       = $eventMetadata['freq'];
        $count      = $eventMetadata['count'];
        $interval   = $eventMetadata['interval'];
        $byDay      = $eventMetadata['byDay'];
        $byMonthDay = $eventMetadata['byMonthDay'];
        $byMonth    = $eventMetadata['byMonth'];
        $byYearDay  = $eventMetadata['byYearDay'];
        $until      = $eventMetadata['until'];

        try {
            return new RRule(
                array(
                    'FREQ'       => $freq,
                    'INTERVAL'   => $interval,
                    'DTSTART'    => $startDate,
                    'UNTIL'      => $until,
                    'COUNT'      => $count,
                    'BYDAY'      => $byDay,
                    'BYMONTHDAY' => $byMonthDay,
                    'BYMONTH'    => $byMonth,
                    'BYYEARDAY'  => $byYearDay,
                )
            );
        } catch (\Exception $e) {
            return null;
        }
    }

    /**
     * Adds event ID and occurrence date to the cache
     *
     * @param int    $eventId
     * @param Carbon $date
     */
    private function cacheEvent($eventId, Carbon $date)
    {
        $this->eventCache[] = array($date, $eventId);
    }

    /**
     * Takes eventIds from cache and stores the respective Event object in the list
     */
    private function cacheToStorage()
    {
        $eventIds = array_map(function($data) {
            return $data[1];
        }, $this->eventCache);
        $this->eventIds = $eventIds;
        $eventModels    = $this->getEventService()->getEventsByIds($eventIds, $this->locale);

        // Store each remaining date in the event date cache as an Event
        foreach ($this->eventCache as $cache) {
            list($date, $eventId) = $cache;

            if (!isset($eventModels[$eventId])) {
                continue;
            }

            $eventModel = $eventModels[$eventId];

            $this->storeEventOnDate($eventModel, $date);
        }

        unset($this->eventCache);
    }

    /**
     * @param Calendar_EventModel $eventModel
     * @param \DateTime           $date
     */
    private function storeEventOnDate(Calendar_EventModel $eventModel, \DateTime $date)
    {
        $date  = Carbon::createFromTimestampUTC($date->getTimestamp());
        $event = Event::createFromModel($eventModel, $date);

        $this->events[] = $event;
    }

    /**
     * @param array $dates
     */
    private function orderDates(array &$dates)
    {
        $modifier = $this->getSortModifier();

        usort(
            $dates,
            function (array $arrayA, array $arrayB) use ($modifier) {
                $dateA = $arrayA[0];
                $dateB = $arrayB[0];

                if ($dateA < $dateB) {
                    return -1 * $modifier;
                }

                if ($dateA > $dateB) {
                    return 1 * $modifier;
                }

                return 0;
            }
        );
    }

    /**
     * Orders events by their start dates
     *
     * @param Event[] $events
     */
    private function orderEvents(array &$events)
    {
        $modifier = $this->getSortModifier();

        usort(
            $events,
            function (Event $eventA, Event $eventB) use ($modifier) {
                if ($eventA->diffInDays($eventB)) {
                    return $eventA->compareStartDates($eventB) * $modifier;
                }

                $multiDayComparison = $eventA->compareMultiDay($eventB);
                $allDayComparison   = $eventA->compareAllDay($eventB);

                // If both are not multi-day
                if ($multiDayComparison === false) {

                    // If both aren't all-day
                    if ($allDayComparison === false) {

                        // Sort by start date
                        return $eventA->compareStartDates($eventB) * $modifier;

                        // If both are all-day
                    } elseif ($allDayComparison === true) {

                        // Compare the end dates
                        return $eventA->compareEndDates($eventB) * $modifier;

                        // Otherwise put the all-day event in front
                    } else {
                        return $allDayComparison;
                    }

                    // If both are multi-day
                } elseif ($multiDayComparison === true) {

                    // Sort by end date - inverse the results
                    return $eventA->compareEndDates($eventB) * -1 * $modifier;

                    // Otherwise put the one which is multi-day - first
                } else {
                    return $multiDayComparison;
                }
            }
        );
    }

    /**
     * Cuts off the excess events based on ::$limit and ::$offset
     *
     * @param array $array
     */
    private function cutOffExcess(array &$array)
    {
        if (null !== $this->limit) {
            $offset = $this->offset ?: 0;

            $array = array_slice($array, $offset, $this->limit);
        }
    }

    /**
     * Builds a cache of events for easy lookup with indexes
     */
    private function cacheEvents()
    {
        $eventsByMonth = $eventsByWeek = $eventsByDay = $eventsByHour = array();
        foreach ($this->events as $event) {
            $startDate  = $event->getStartDate();
            $endDate    = $event->getEndDate();
            $diffInDays = DateHelper::carbonDiffInDays($startDate, $endDate);

            $month = $startDate->format(self::FORMAT_MONTH);
            $this->addEventToCache($eventsByMonth, $month, $event);

            $week = DateHelper::getCacheWeekNumber($startDate);
            $this->addEventToCache($eventsByWeek, $week, $event);

            $day = $startDate->copy();
            for ($i = 0; $i <= $diffInDays; $i++) {
                if ($this->overlapThreshold && $i !== 0 && $i == $diffInDays) {
                    if (DateHelper::isDateBeforeOverlap($endDate, $this->overlapThreshold)) {
                        break;
                    }
                }
                $this->addEventToCache($eventsByDay, $day->format(self::FORMAT_DAY), $event);
                $day->addDay();
            }

            if (!$event->isAllDay()) {
                $hour = $startDate->format(self::FORMAT_HOUR);
                $this->addEventToCache($eventsByHour, $hour, $event);
                if ($diffInDays && !DateHelper::isDateBeforeOverlap($endDate, $this->overlapThreshold)) {
                    $this->addEventToCache($eventsByHour, $endDate->format(self::FORMAT_HOUR), $event);
                }
            }
        }

        foreach ($eventsByDay as $events) {
            $this->orderEvents($events);
        }

        $this->eventsByMonth = $eventsByMonth;
        $this->eventsByWeek  = $eventsByWeek;
        $this->eventsByDay   = $eventsByDay;
        $this->eventsByHour  = $eventsByHour;
    }

    /**
     * Warms up the cache if needed, adds event to it
     *
     * @param string $cache
     * @param string $key
     * @param Event  $event
     */
    private function addEventToCache(&$cache, $key, Event $event)
    {
        if (!isset($cache[$key])) {
            $cache[$key] = array();
        }

        $cache[$key][] = $event;
    }

    /**
     * Checks whether an order parameter has been set
     * If it hasn't - return true, since we sort by start date by default
     * If it has - check if is set to start date
     *
     * @return bool
     */
    private function shouldOrderByStartDate()
    {
        return is_null($this->order) || preg_match("/\.?startDate$/", $this->order);
    }

    /**
     * Returns 1 for ASC and -1 for DESC
     * Based on ::$sort
     *
     * @return int
     */
    private function getSortModifier()
    {
        $modifier = 1;
        if ($this->sort == EventListOptions::SORT_DESC) {
            $modifier = -1;
        }

        return $modifier;
    }

    /**
     * @return Calendar_EventsService
     */
    private function getEventService()
    {
        return \Craft\craft()->calendar_events;
    }

    /**
     * @return Calendar_SelectDatesService
     */
    private function getSelectDatesService()
    {
        return \Craft\craft()->calendar_selectDates;
    }

    /**
     * @return Calendar_ExceptionsService
     */
    private function getExceptionService()
    {
        return \Craft\craft()->calendar_exceptions;
    }

    // ========================================
    // Iterator interface method implementation
    // ========================================

    /**
     * Return the current element
     *
     * @link  http://php.net/manual/en/iterator.current.php
     * @return mixed Can return any type.
     * @since 5.0.0
     */
    public function current()
    {
        return $this->events[$this->position];
    }

    /**
     * Move forward to next element
     *
     * @link  http://php.net/manual/en/iterator.next.php
     * @return void Any returned value is ignored.
     * @since 5.0.0
     */
    public function next()
    {
        ++$this->position;
    }

    /**
     * Return the key of the current element
     *
     * @link  http://php.net/manual/en/iterator.key.php
     * @return mixed scalar on success, or null on failure.
     * @since 5.0.0
     */
    public function key()
    {
        return $this->position;
    }

    /**
     * Checks if current position is valid
     *
     * @link  http://php.net/manual/en/iterator.valid.php
     * @return boolean The return value will be casted to boolean and then evaluated.
     *        Returns true on success or false on failure.
     * @since 5.0.0
     */
    public function valid()
    {
        return isset($this->events[$this->position]);
    }

    /**
     * Rewind the Iterator to the first element
     *
     * @link  http://php.net/manual/en/iterator.rewind.php
     * @return void Any returned value is ignored.
     * @since 5.0.0
     */
    public function rewind()
    {
        $this->position = 0;
    }

    // ===========================================
    // ArrayAccess interface method implementation
    // ===========================================

    /**
     * Whether a offset exists
     *
     * @link  http://php.net/manual/en/arrayaccess.offsetexists.php
     *
     * @param mixed $offset <p>
     *                      An offset to check for.
     *                      </p>
     *
     * @return boolean true on success or false on failure.
     * </p>
     * <p>
     * The return value will be casted to boolean if non-boolean was returned.
     * @since 5.0.0
     */
    public function offsetExists($offset)
    {
        return isset($this->events[$offset]);
    }

    /**
     * Offset to retrieve
     *
     * @link  http://php.net/manual/en/arrayaccess.offsetget.php
     *
     * @param mixed $offset <p>
     *                      The offset to retrieve.
     *                      </p>
     *
     * @return mixed Can return all value types.
     * @since 5.0.0
     */
    public function offsetGet($offset)
    {
        return $this->events[$offset];
    }

    /**
     * Offset to set
     *
     * @link  http://php.net/manual/en/arrayaccess.offsetset.php
     *
     * @param mixed $offset <p>
     *                      The offset to assign the value to.
     *                      </p>
     * @param mixed $value  <p>
     *                      The value to set.
     *                      </p>
     *
     * @return void
     * @since 5.0.0
     */
    public function offsetSet($offset, $value)
    {
        $this->events[$offset] = $value;
    }

    /**
     * Offset to unset
     *
     * @link  http://php.net/manual/en/arrayaccess.offsetunset.php
     *
     * @param mixed $offset <p>
     *                      The offset to unset.
     *                      </p>
     *
     * @return void
     * @since 5.0.0
     */
    public function offsetUnset($offset)
    {
        unset($this->events[$offset]);
    }

    /**
     * Count elements of an object
     *
     * @link  http://php.net/manual/en/countable.count.php
     * @return int The custom count as an integer.
     *        </p>
     *        <p>
     *        The return value is cast to an integer.
     * @since 5.1.0
     */
    public function count()
    {
        return count($this->events);
    }
}
