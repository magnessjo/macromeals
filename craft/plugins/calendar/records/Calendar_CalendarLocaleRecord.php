<?php

namespace Craft;

/**
 * @property int    $id
 * @property int    $calendarId
 * @property string $locale
 * @property bool   $enabledByDefault
 */
class Calendar_CalendarLocaleRecord extends BaseRecord
{
    const TABLE = 'calendar_calendars_i18n';

    /**
     * @return string
     */
    public function getTableName()
    {
        return self::TABLE;
    }

    /**
     * @return array
     */
    public function defineRelations()
    {
        return array(
            'calendar' => array(
                self::BELONGS_TO,
                'Calendar_CalendarRecord',
                'calendarId',
                'required' => true,
                'onDelete' => static::CASCADE,
                'onUpdate' => static::CASCADE,
            ),
            'locale'   => array(
                static::BELONGS_TO,
                'LocaleRecord',
                'locale',
                'required' => true,
                'onDelete' => static::CASCADE,
                'onUpdate' => static::CASCADE,
            ),
        );
    }

    /**
     * @return array
     */
    public function defineIndexes()
    {
        return array(
            array('columns' => array('calendarId', 'locale'), 'unique' => true),
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
            'locale'           => array(AttributeType::Locale, 'required' => true),
            'enabledByDefault' => array(AttributeType::Bool, 'default' => true),
            'eventUrlFormat'   => AttributeType::UrlFormat,
        );
    }
}
