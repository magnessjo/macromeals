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

namespace Calendar\Library\Duration;

use Calendar\Library\Exceptions\DurationException;
use Calendar\Library\Carbon;

abstract class AbstractDuration implements DurationInterface
{
    /** @var Carbon */
    protected $startDate;

    /** @var Carbon */
    protected $endDate;

    /**
     * AbstractDuration constructor.
     *
     * @param Carbon $targetDate
     *
     * @throws DurationException
     */
    public final function __construct(Carbon $targetDate)
    {
        $this->init($targetDate);
        
        if (is_null($this->startDate)) {
            throw new DurationException('Init method hasn\'t instantiated a startDate');
        }

        if (is_null($this->endDate)) {
            throw new DurationException('Init method hasn\'t instantiated an endDate');
        }
    }

    /**
     * Initialize all dates
     *
     * @param Carbon $targetDate
     */
    abstract protected function init(Carbon $targetDate);

    /**
     * @return Carbon
     */
    public final function getStartDate()
    {
        return $this->startDate;
    }

    /**
     * @return Carbon
     */
    public final function getEndDate()
    {
        return $this->endDate;
    }

    /**
     * Checks if the given $date is contained in between $durationStartDate and $durationEndDate
     *
     * @param Carbon $date
     *
     * @return bool
     */
    public function containsDate(Carbon $date)
    {
        return $date->between($this->startDate, $this->endDate);
    }
}
