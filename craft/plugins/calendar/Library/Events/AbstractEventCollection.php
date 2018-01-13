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

use Calendar\Library\Duration\AbstractDuration;
use Calendar\Library\Carbon;
use Carbon\CarbonInterval;

/**
 * Class AbstractEventCollection
 *
 * Provides iterable interface for a specific variable
 * Which has to be overridden on object instantiation
 */
abstract class AbstractEventCollection implements EventCollectionInterface, \Iterator
{
    /** @var bool */
    protected $eventsBuilt;

    /** @var Event[] */
    protected $cachedEvents;

    /** @var array */
    private $iterableObject;

    /** @var Event[] */
    protected $events;

    /** @var EventList */
    private $eventList;

    /** @var Carbon */
    private $startDate;

    /** @var Carbon */
    private $endDate;

    /** @var AbstractDuration */
    private $duration;

    /**
     * AbstractEventCollection constructor.
     * Sets start and end dates from $duration
     * And builds the iterable object and populates the event list
     *
     * @param AbstractDuration $duration
     * @param EventList        $eventList
     */
    public final function __construct(AbstractDuration $duration, EventList $eventList)
    {
        $this->duration  = $duration;
        $this->startDate = $duration->getStartDate();
        $this->endDate   = $duration->getEndDate();
        $this->eventList = $eventList;

        $this->iterableObject = $this->buildIterableObject($eventList);
    }

    /**
     * Returns the start date of the event collection
     * For EventMonth this date would be the instantiated date's first day
     * not the actual first day which might be in the previous month
     *
     * @return Carbon
     */
    public final function getDate()
    {
        return $this->duration->getStartDate()->copy();
    }

    /**
     * @return Carbon
     */
    public final function getStartDate()
    {
        return $this->startDate->copy();
    }

    /**
     * @return Carbon
     */
    public final function getEndDate()
    {
        return $this->endDate->copy();
    }

    /**
     * Returns a Carbon object with the duration interval set backwards by 1 iteration
     *
     * @return Carbon
     */
    public final function getPreviousDate()
    {
        return $this->getDate()->copy()->sub($this->getInterval());
    }

    /**
     * Returns a Carbon object with the duration interval set forward by 1 iteration
     *
     * @return Carbon
     */
    public final function getNextDate()
    {
        return $this->getDate()->copy()->add($this->getInterval());
    }

    /**
     * Returns a list of dates
     * The dates begin $before intervals from self::$date
     * And end $after intervals after self::$date
     * self::$date is included
     *
     * @param int $before
     * @param int $after
     *
     * @return Carbon[]
     */
    public final function getDateRange($before = 1, $after = 1)
    {
        $before = abs($before);
        $after  = abs($after);

        $date           = $this->getDate();
        $intervalBefore = $date->diff($this->getPreviousDate());
        $intervalAfter  = $date->diff($this->getNextDate());

        $rangeList  = array();
        $dateBefore = $date->copy();
        for ($i = 1; $i <= $before; $i++) {
            $rangeList[] = $dateBefore->add($intervalBefore)->copy();
        }
        $rangeList = array_reverse($rangeList);

        $rangeList[] = $date;

        $dateAfter = $date->copy();
        for ($i = 1; $i <= $after; $i++) {
            $rangeList[] = $dateAfter->add($intervalAfter)->copy();
        }

        return $rangeList;
    }

    /**
     * @return Event[]
     */
    public final function getEvents()
    {
        if (is_null($this->cachedEvents)) {
            $this->cachedEvents = $this->buildEventCache();
        }
        
        return $this->cachedEvents;
    }

    /**
     * @return int
     */
    public final function getEventCount()
    {
        return count($this->getEvents());
    }

    /**
     * Checks if the given $date is contained in this object
     *
     * @param Carbon $date
     *
     * @return bool
     */
    public function containsDate(Carbon $date)
    {
        return $this->duration->containsDate($date);
    }

    /**
     * @return EventList
     */
    protected function getEventList()
    {
        return $this->eventList;
    }

    /**
     * @return AbstractDuration
     */
    protected function getDuration()
    {
        return $this->duration;
    }

    /**
     * Get an event list for caching
     *
     * @return Event[]
     */
    abstract protected function buildEventCache();

    /**
     * Gets the interval of this object
     *
     * @return CarbonInterval
     */
    abstract protected function getInterval();

    /**
     * Builds an iterable object
     *
     * @param EventList $eventList
     *
     * @return array
     */
    abstract protected function buildIterableObject(EventList $eventList);

    /**
     * Return the current element
     *
     * @link  http://php.net/manual/en/iterator.current.php
     * @return mixed Can return any type.
     * @since 5.0.0
     */
    public function current()
    {
        return current($this->iterableObject);
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
        next($this->iterableObject);
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
        return key($this->iterableObject);
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
        return !is_null($this->key()) && $this->key() !== false;
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
        reset($this->iterableObject);
    }
}
