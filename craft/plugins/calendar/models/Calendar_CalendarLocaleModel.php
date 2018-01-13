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
