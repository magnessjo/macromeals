<?php

namespace Craft;

use Calendar\Library\DateTimeUTC;

/**
 * @property int      $eventId
 * @property DateTime $date
 */
class Calendar_SelectDateModel extends BaseModel
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
