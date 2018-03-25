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

/**
 * @property int                  $id
 * @property DateTime             $date
 * @property int                  $eventId
 * @property Calendar_EventRecord $event
 */
class Calendar_ExceptionRecord extends BaseRecord
{
    /**
     * @return string
     */
    public function getTableName()
    {
        return 'calendar_exceptions';
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
