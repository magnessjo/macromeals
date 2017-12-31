<?php

namespace Craft;

/**
 * @property int                        $id
 * @property int                        $calendarId
 * @property int                        $authorId
 * @property \DateTime                  $startDate
 * @property \DateTime                  $endDate
 * @property bool                       $allDay
 * @property string                     $rrule
 * @property string                     $freq
 * @property int                        $interval
 * @property int                        $count
 * @property \DateTime                  $until
 * @property string                     $byMonth
 * @property string                     $byYearDay
 * @property string                     $byMonthDay
 * @property string                     $byDay
 * @property ElementRecord              $element
 * @property Calendar_CalendarRecord    $calendar
 * @property Calendar_ExceptionRecord[] $exceptions
 */
class Calendar_EventRecord extends BaseRecord
{
    /**
     * @return string
     */
    public function getTableName()
    {
        return 'calendar_events';
    }

    /**
     * @return array
     */
    public function defineRelations()
    {
        return array(
            'element'    => array(
                static::BELONGS_TO,
                'ElementRecord',
                'id',
                'required' => true,
                'onDelete' => static::CASCADE,
            ),
            'calendar'   => array(
                self::BELONGS_TO,
                'Calendar_CalendarRecord',
                'calendarId',
                'required' => true,
                'onDelete' => self::CASCADE,
            ),
            'author'     => array(
                self::BELONGS_TO,
                'UserRecord',
                'authorId',
                'required' => false,
                'onDelete' => static::SET_NULL,
            ),
            'exceptions' => array(
                self::HAS_MANY,
                'Calendar_ExceptionRecord',
                'eventId',
            ),
        );
    }

    /**
     * @return array
     */
    public function defineIndexes()
    {
        return array(
            array('columns' => array('calendarId')),
            array('columns' => array('authorId')),
            array('columns' => array('startDate')),
            array('columns' => array('endDate')),
            array('columns' => array('startDate', 'endDate')),
            array('columns' => array('until')),
        );
    }

    /**
     * @return array
     */
    protected function defineAttributes()
    {
        return array(
            'authorId'   => array(AttributeType::Number),
            'startDate'  => array(AttributeType::DateTime, 'required' => true),
            'endDate'    => array(AttributeType::DateTime, 'required' => true),
            'allDay'     => array(AttributeType::Bool, 'required' => false),
            'rrule'      => array(AttributeType::String, 'required' => false),
            'freq'       => array(AttributeType::String, 'required' => false),
            'interval'   => array(AttributeType::Number, 'required' => false),
            'count'      => array(AttributeType::Number, 'required' => false),
            'until'      => array(AttributeType::DateTime, 'required' => false),
            'byMonth'    => array(AttributeType::String, 'required' => false),
            'byYearDay'  => array(AttributeType::String, 'required' => false),
            'byMonthDay' => array(AttributeType::String, 'required' => false),
            'byDay'      => array(AttributeType::String, 'required' => false),
        );
    }
}
