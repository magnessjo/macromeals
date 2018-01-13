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

interface EventCollectionInterface
{
    /**
     * @return Carbon
     */
    public function getDate();

    /**
     * @return Carbon
     */
    public function getStartDate();

    /**
     * @return Carbon
     */
    public function getEndDate();

    /**
     * @return Event[]
     */
    public function getEvents();
}
