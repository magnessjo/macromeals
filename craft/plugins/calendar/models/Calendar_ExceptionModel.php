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

use Calendar\Library\DateTimeUTC;

/**
 * @property int      $eventId
 * @property DateTime $date
 */
class Calendar_ExceptionModel extends BaseModel
{
    /**
     * @return array
     */
    protected function defineAttributes()
    {
        return array(
            'id'      => AttributeType::Number,
            'eventId' => AttributeType::Number,
            'date'    => AttributeType::DateTime,
        );
    }

    /**
     * @return DateTimeUTC
     */
    public function getDateUTC()
    {
        $copy = new DateTimeUTC();
        $copy->setTimestamp($this->date->getTimestamp());

        return $copy;
    }
}
