<?php

namespace Calendar\Library\DataObjects;

use Calendar\Library\Carbon;
use Craft\DateTime;

class OccurrenceLoader
{
    /** @var int */
    private $limit;

    /** @var Carbon */
    private $rangeStart;

    /** @var Carbon */
    private $rangeEnd;

    /** @var bool */
    private $loadOccurrences;

    /**
     * @param array $configuration
     *
     * @return OccurrenceLoader
     */
    public static function create(array $configuration)
    {
        $occurrenceRangeStart = null;
        if (isset($configuration['occurrenceRangeStart'])) {
            $occurrenceRangeStart = new Carbon($configuration['occurrenceRangeStart'], DateTime::UTC);
        }

        $occurrenceRangeEnd = null;
        if (isset($configuration['occurrenceRangeEnd'])) {
            $occurrenceRangeEnd = new Carbon($configuration['occurrenceRangeEnd'], DateTime::UTC);
        }

        $occurrenceLimit = null;
        if (isset($configuration['occurrenceLimit'])) {
            $occurrenceLimit = (int) $configuration['occurrenceLimit'];
        }

        $loadOccurrences = true;
        if (isset($configuration['loadOccurrences'])) {
            $loadOccurrences = $configuration['loadOccurrences'];
        }

        return new OccurrenceLoader(
            $occurrenceRangeStart,
            $occurrenceRangeEnd,
            $occurrenceLimit,
            $loadOccurrences
        );
    }

    /**
     * OccurrenceLoader constructor.
     *
     * @param Carbon|null $rangeStart
     * @param Carbon|null $rangeEnd
     * @param int|null    $limit
     * @param bool        $loadOccurrences
     */
    public function __construct(
        Carbon $rangeStart = null,
        Carbon $rangeEnd = null,
        $limit = null,
        $loadOccurrences = true
    ) {
        if ($rangeStart) {
            $rangeStart->setTime(0, 0, 0);
        }

        if ($rangeEnd) {
            $rangeEnd->setTime(23, 59, 59);
        }

        $this->rangeStart      = $rangeStart;
        $this->rangeEnd        = $rangeEnd;
        $this->limit           = (int)$limit;
        $this->loadOccurrences = (bool)$loadOccurrences;
    }

    /**
     * @return int
     */
    public function getLimit()
    {
        return $this->limit;
    }

    /**
     * @return Carbon
     */
    public function getRangeStart()
    {
        return $this->rangeStart;
    }

    /**
     * @return Carbon
     */
    public function getRangeEnd()
    {
        return $this->rangeEnd;
    }

    /**
     * @return bool
     */
    public function getLoadOccurrences()
    {
        return (bool)$this->loadOccurrences;
    }
}
