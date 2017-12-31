<?php

namespace Craft;

/**
 * @property int    $id
 * @property int    $calendarId
 * @property string $locale
 * @property bool   $enabledByDefault
 * @property string $eventUrlFormat
 */
class Calendar_CalendarLocaleModel extends BaseModel
{
    /**
     * @return array
     */
    protected function defineAttributes()
    {
        return array(
            'id'               => AttributeType::Number,
            'calendarId'       => AttributeType::Number,
            'locale'           => AttributeType::Locale,
            'enabledByDefault' => array(AttributeType::Bool, 'default' => true),
            'eventUrlFormat'   => AttributeType::UrlFormat,
        );
    }
}
