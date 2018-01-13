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
 * @property int                    $id
 * @property string                 $name
 * @property string                 $handle
 * @property string                 $description
 * @property string                 $color
 * @property bool                   $hasUrls
 * @property string                 $eventTemplate
 * @property Calendar_EventRecord[] $events
 * @property int                    $fieldLayoutId
 * @property string                 $titleFormat
 * @property string                 $titleLabel
 * @property string                 $hasTitleField
 * @property string                 $descriptionFieldHandle
 * @property string                 $locationFieldHandle
 * @property string                 $icsHash
 */
class Calendar_CalendarRecord extends BaseRecord
{
    /**
     * @return string
     */
    public function getTableName()
    {
        return 'calendar_calendars';
    }

    /**
     * @return array
     */
    public function defineRelations()
    {
        return array(
            'events'      => array(
                self::HAS_MANY,
                'Calendar_EventRecord',
                'eventId',
            ),
            'fieldLayout' => array(
                static::BELONGS_TO,
                'FieldLayoutRecord',
                'onDelete' => static::SET_NULL,
            ),
        );
    }

    /**
     * @return array
     */
    public function defineIndexes()
    {
        return array(
            array('columns' => array('name'), 'unique' => true),
            array('columns' => array('handle'), 'unique' => true),
            array('columns' => array('icsHash'), 'unique' => false),
        );
    }

    /**
     * @return array
     */
    public function scopes()
    {
        return array(
            'ordered' => array('order' => 'name'),
        );
    }

    /**
     * @return array
     */
    protected function defineAttributes()
    {
        return array(
            'name'                   => array(AttributeType::Name, 'required' => true),
            'handle'                 => array(AttributeType::Handle, 'required' => true),
            'description'            => AttributeType::String,
            'color'                  => array(AttributeType::String, 'required' => true),
            'hasUrls'                => array(AttributeType::Bool, 'default' => false),
            'eventTemplate'          => AttributeType::String,
            'fieldLayoutId'          => AttributeType::Number,
            'titleFormat'            => AttributeType::String,
            'titleLabel'             => array(AttributeType::String, 'default' => 'Title'),
            'hasTitleField'          => array(AttributeType::Bool, 'default' => true, 'required' => true),
            'descriptionFieldHandle' => AttributeType::String,
            'locationFieldHandle'    => AttributeType::String,
            'icsHash'                => array(AttributeType::String, 'required' => false),
        );
    }
}
