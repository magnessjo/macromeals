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
