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

class DayDuration extends AbstractDuration
{
    /**
     * Duration constructor.
     * Must get a valid start and end date from $targetDate
     *
     * @param Carbon $targetDate
     */
    protected function init(Carbon $targetDate)
    {
        $startDate = Carbon::createFromTimestampUTC($targetDate->getTimestamp());
        $startDate->setTime(0, 0, 0);

        $endDate = $startDate->copy();
        $endDate->setTime(23, 59, 59);
        
        $this->startDate         = $startDate;
        $this->endDate           = $endDate;
    }
}
