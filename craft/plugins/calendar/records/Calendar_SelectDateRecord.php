<?php

namespace Craft;

/**
 * @property int                  $id
 * @property DateTime             $date
 * @property int                  $eventId
 * @property Calendar_EventRecord $event
 */
class Calendar_SelectDateRecord extends BaseRecord
{
    /**
     * @return string
     */
    public function getTableName()
    {
        return 'calendar_select_dates';
    }

    /**
     * @return array
     */
    public function defineRelations()
    {
        return array(
            'event' => array(
                self::BELONGS_TO,
                'Calendar_EventRecord',
                'eventId',
                'required' => true,
                'onDelete' => self::CASCADE,
            ),
        );
    }

    /**
     * @return array
     */
    public function defineIndexes()
    {
        return array(
            array('columns' => array('eventId', 'date')),
        );
    }

    /**
     * @return array
     */
    protected function defineAttributes()
    {
        return array(
            'date' => AttributeType::DateTime,
        );
    }
}
