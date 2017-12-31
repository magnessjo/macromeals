<?php
namespace Craft;

/**
 * The class name is the UTC timestamp in the format of mYYMMDD_HHMMSS_pluginHandle_migrationName
 */
class m161205_160857_calendar_AddingCalendarI18n extends BaseMigration
{
    /**
     * Any migration code in here is wrapped inside of a transaction.
     *
     * @return bool
     */
    public function safeUp()
    {
        $columns = array(
            'calendarId'       => array('column' => ColumnType::Int, 'required' => true),
            'locale'           => array('column' => ColumnType::Varchar, 'required' => true),
            'enabledByDefault' => array('column' => ColumnType::TinyInt, 'default' => true),
        );

        craft()->db->createCommand()->createTable('calendar_calendars_i18n', $columns);

        craft()->db->createCommand()->createIndex('calendar_calendars_i18n', 'calendarId,locale', true);

        craft()->db->createCommand()->addForeignKey(
            'calendar_calendars_i18n',
            'calendarId',
            'calendar_calendars',
            'id',
            'CASCADE'
        );

        craft()->db->createCommand()->addForeignKey(
            'calendar_calendars_i18n',
            'locale',
            'locales',
            'locale',
            'CASCADE',
            'CASCADE'
        );

        /** @var LocaleModel[] $locales */
        $locales = craft()->i18n->getSiteLocales();

        /** @var Calendar_CalendarModel[] $calendars */
        $calendars = craft()->calendar_calendars->getAllCalendars();

        foreach ($calendars as $calendar) {
            $rows = array();
            foreach ($locales as $locale) {
                $rows[] = array($calendar->id, $locale->id, true);
            }

            craft()
                ->db
                ->createCommand()
                ->insertAll(
                    "calendar_calendars_i18n",
                    array("calendarId", "locale", "enabledByDefault"),
                    $rows
                );
        }

        return true;
    }
}
