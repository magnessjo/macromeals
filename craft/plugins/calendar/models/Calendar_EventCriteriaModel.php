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
use Calendar\Library\DateHelper;
use Calendar\Library\Events\EventList;
use Calendar\Library\Carbon;

class Calendar_EventCriteriaModel extends ElementCriteriaModel implements \Countable
{
    /** @var EventList */
    private $eventList;

    /** @var int */
    private $cachedTotal;

    /**
     * Calendar_EventCriteriaModel constructor.
     *
     * @param mixed $attributes
     */
    public function __construct($attributes)
    {
        $elementType = craft()
            ->components
            ->getComponentByTypeAndClass(
                ComponentType::Element,
                Calendar_EventModel::ELEMENT_TYPE
            );

        if (isset($attributes['dateRangeStart'])) {
            $dateRangeStart = $attributes['dateRangeStart'];
            if ($dateRangeStart instanceof DateTime) {
                $carbon = Carbon::createFromTimestampUTC($dateRangeStart->getTimestamp());
            } else {
                $carbon = DateHelper::getCarbonUtcClone($dateRangeStart);
            }

            if ($carbon) {
                $attributes['dateRangeStart'] = $carbon->toDateTimeString();
            }
        }

        if (isset($attributes['dateRangeEnd'])) {
            $dateRangeEnd = $attributes['dateRangeEnd'];
            if ($dateRangeEnd instanceof DateTime) {
                $carbon = Carbon::createFromTimestampUTC($dateRangeEnd->getTimestamp());
            } else {
                $carbon = DateHelper::getCarbonUtcClone($dateRangeEnd);
            }
            
            if ($carbon) {
                if ($carbon->format('His') === '000000') {
                    $carbon->setTime(23, 59, 59);
                }
                $attributes['dateRangeEnd'] = $carbon->toDateTimeString();
            }
        }

        parent::__construct($attributes, $elementType);
    }

    /**
     * Returns a list of event standard objects
     *
     * @param array $attributes
     *
     * @return array
     */
    public function getEventsAsSimpleObject($attributes = null)
    {
        if (null === $this->eventList) {
            $this->find($attributes);
        }

        return $this->eventList->getEventsAsSimpleObject();
    }

    /**
     * @param null|array $attributes
     *
     * @return Calendar_EventModel[]
     */
    public function find($attributes = null)
    {
        if (null === $this->eventList) {
            $limit  = $this->getAttribute('limit');
            $offset = $this->getAttribute('offset');

            $eventListOptions = new EventListOptions();
            $eventListOptions
                ->setRangeStart($this->dateRangeStart ?: null)
                ->setRangeEnd($this->dateRangeEnd ?: null)
                ->setLimit($limit)
                ->setOffset($offset)
                ->setOrder($this->order ?: null)
                ->setLoadOccurrences($this->loadOccurrences)
                ->setLocale($this->locale)
                ->setOverlapThreshold(craft()->calendar_settings->getOverlapThreshold());

            $parentAttributes = $attributes;
            if ($eventListOptions->loadOccurrences()) {
                $this->setAttribute('limit', null);
                $this->setAttribute('offset', null);

                if (isset($attributes['limit'])) {
                    unset($parentAttributes['limit'], $parentAttributes['offset']);
                }
            } else {
                $this->setAttribute('limit', null);
                $this->setAttribute('offset', null);
            }

            $eventIds = parent::ids($attributes);

            $eventList = new EventList($eventIds, $eventListOptions);

            $this->eventList   = $eventList;

            if ($eventListOptions->loadOccurrences()) {
                $this->cachedTotal = $this->eventList->getTotal();
            } else {
                $this->cachedTotal = parent::total($attributes);
            }

            $this->setAttribute('limit', $limit);
            $this->setAttribute('offset', $offset);
        }

        return $this->eventList;
    }

    /**
     * Returns an element at a specific offset.
     *
     * @param int $offset The offset.
     *
     * @return Calendar_EventModel|null - The element, if there is one.
     */
    public function nth($offset)
    {
        if (null === $this->eventList) {
            $this->find($this->getAttributes());
        }

        return isset($this->eventList[$offset]) ? $this->eventList[$offset] : null;
    }

    /**
     * Returns the total elements that match the criteria.
     *
     * @param array|null $attributes
     *
     * @return int
     */
    public function total($attributes = null)
    {
        if (null === $this->cachedTotal) {
            $this->find($attributes);
        }

        return $this->cachedTotal;
    }


    /**
     * Returns an iterator for traversing over the events.
     *
     * Required by the IteratorAggregate interface.
     *
     * @return \ArrayIterator
     */
    public function getIterator()
    {
        if (null === $this->eventList) {
            $this->find();
        }

        return new \ArrayIterator($this->eventList->getEvents());
    }


    /**
     * Returns whether an element exists at a given offset. Required by the ArrayAccess interface.
     *
     * @param mixed $offset
     *
     * @return bool
     */
    public function offsetExists($offset)
    {
        return $this->nth($offset) !== null;
    }

    /**
     * Returns the element at a given offset. Required by the ArrayAccess interface.
     *
     * @param mixed $offset
     *
     * @return mixed
     */
    public function offsetGet($offset)
    {
        return $this->nth($offset);
    }

    /**
     * Sets the element at a given offset. Required by the ArrayAccess interface.
     *
     * @param mixed $offset
     * @param mixed $item
     *
     * @return null
     */
    public function offsetSet($offset, $item)
    {
        $this->eventList[$offset] = $item;
    }

    /**
     * Unsets an element at a given offset. Required by the ArrayAccess interface.
     *
     * @param mixed $offset
     *
     * @return null
     */
    public function offsetUnset($offset)
    {
        unset($this->eventList[$offset]);
    }
}
