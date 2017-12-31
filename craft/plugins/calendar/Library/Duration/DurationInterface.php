<?php

namespace Calendar\Library\Duration;

use Calendar\Library\Carbon;

interface DurationInterface
{
    /**
     * @return Carbon
     */
    public function getStartDate();

    /**
     * @return Carbon
     */
    public function getEndDate();

    /**
     * Duration constructor.
     * Must get a valid start and end date from $targetDate
     *
     * @param Carbon $targetDate
     */
    public function __construct(Carbon $targetDate);
}
