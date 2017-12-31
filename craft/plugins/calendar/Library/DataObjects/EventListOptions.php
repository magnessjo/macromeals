<?php

namespace Calendar\Library\DataObjects;

use Calendar\Library\Carbon;

class EventListOptions
{
    const SORT_ASC  = "ASC";
    const SORT_DESC = "DESC";

    /** @var Carbon */
    private $rangeStart;

    /** @var Carbon */
    private $rangeEnd;

    /** @var int */
    private $limit;

    /** @var int */
    private $offset;

    /** @var bool */
    private $loadOccurrences;

    /** @var int */
    private $overlapThreshold;

    /** @var string */
    private $order;

    /** @var bool */
    private $shuffle;

    /** @var string */
    private $sort;

    /** @var string */
    private $locale;

    /**
     * EventListOptions constructor.
     */
    public function __construct()
    {
        $this->sort = self::SORT_ASC;
    }

    /**
     * @return Carbon
     */
    public function getRangeStart()
    {
        return $this->rangeStart;
    }

    /**
     * @param \DateTime $rangeStart
     *
     * @return $this
     */
    public function setRangeStart(\DateTime $rangeStart = null)
    {
        if ($rangeStart) {
            $rangeStart = Carbon::createFromTimestampUTC($rangeStart->getTimestamp());
        }

        $this->rangeStart = $rangeStart;

        return $this;
    }

    /**
     * @return Carbon
     */
    public function getRangeEnd()
    {
        return $this->rangeEnd;
    }

    /**
     * @param \DateTime $rangeEnd
     *
     * @return $this
     */
    public function setRangeEnd(\DateTime $rangeEnd = null)
    {
        if ($rangeEnd) {
            $rangeEnd = Carbon::createFromTimestampUTC($rangeEnd->getTimestamp());
        }

        $this->rangeEnd = $rangeEnd;

        return $this;
    }

    /**
     * @return int
     */
    public function getLimit()
    {
        return $this->limit;
    }

    /**
     * @param int $limit
     *
     * @return $this
     */
    public function setLimit($limit = null)
    {
        if (null !== $limit) {
            $limit = (int)$limit;
        }

        $this->limit = $limit;

        return $this;
    }

    /**
     * @return int
     */
    public function getOffset()
    {
        return $this->offset;
    }

    /**
     * @param int $offset
     *
     * @return $this
     */
    public function setOffset($offset = null)
    {
        if (null !== $offset) {
            $offset = (int)$offset;
        }

        $this->offset = $offset;

        return $this;
    }

    /**
     * @return string
     */
    public function getOrder()
    {
        return $this->order;
    }

    /**
     * @param string $order
     *
     * @return $this
     */
    public function setOrder($order)
    {
        if (preg_match('/^rand\(\)$/i', $order)) {
            $this->setShuffle(true);
            $this->setSort(null);
        }

        if (preg_match("/(.+)\s+(DESC|ASC)$/i", $order, $matches)) {
            $order = $matches[1];
            $this->setSort($matches[2]);
        }

        $this->order = $order;

        return $this;
    }

    /**
     * @return bool
     */
    public function isShuffle()
    {
        return $this->shuffle;
    }

    /**
     * @param bool $shuffle
     *
     * @return $this
     */
    public function setShuffle($shuffle)
    {
        $this->shuffle = (bool) $shuffle;

        return $this;
    }

    /**
     * @return string
     */
    public function getSort()
    {
        return $this->sort;
    }

    /**
     * @param string $sort
     *
     * @return $this
     */
    public function setSort($sort)
    {
        if (null === $sort) {
            $this->sort = null;
        } else {
            $this->sort = strtoupper($sort) === self::SORT_DESC ? self::SORT_DESC : self::SORT_ASC;
        }

        return $this;
    }

    /**
     * @return boolean
     */
    public function loadOccurrences()
    {
        return $this->loadOccurrences;
    }

    /**
     * @param bool $loadOccurrences
     *
     * @return $this
     */
    public function setLoadOccurrences($loadOccurrences = true)
    {
        $this->loadOccurrences = (bool)$loadOccurrences;

        return $this;
    }

    /**
     * @return int
     */
    public function getOverlapThreshold()
    {
        return $this->overlapThreshold;
    }

    /**
     * @param int $overlapThreshold
     *
     * @return $this
     */
    public function setOverlapThreshold($overlapThreshold = null)
    {
        if (!is_null($overlapThreshold)) {
            $overlapThreshold = (int)$overlapThreshold;
        }

        $this->overlapThreshold = $overlapThreshold;

        return $this;
    }

    /**
     * @return string
     */
    public function getLocale()
    {
        return $this->locale;
    }

    /**
     * @param string $locale
     *
     * @return $this
     */
    public function setLocale($locale)
    {
        $this->locale = $locale;

        return $this;
    }
}
