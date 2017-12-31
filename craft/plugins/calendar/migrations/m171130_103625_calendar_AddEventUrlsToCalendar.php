<?php
namespace Craft;

/**
 * The class name is the UTC timestamp in the format of mYYMMDD_HHMMSS_pluginHandle_migrationName
 */
class m171130_103625_calendar_AddEventUrlsToCalendar extends BaseMigration
{
	/**
	 * Any migration code in here is wrapped inside of a transaction.
	 *
	 * @return bool
	 */
	public function safeUp()
	{
        craft()
            ->db
            ->createCommand()
            ->addColumn(
                'calendar_calendars',
                'hasUrls',
                array(
                    ColumnType::Bool,
                )
            );

        craft()
            ->db
            ->createCommand()
            ->addColumn(
                'calendar_calendars_i18n',
                'eventUrlFormat',
                array(
                    ColumnType::Varchar,
                    'length' => 255,
                )
            );

        craft()
            ->db
            ->createCommand()
            ->addColumn(
                'calendar_calendars',
                'eventTemplate',
                array(
                    ColumnType::Varchar,
                    'length' => 255,
                )
            );

        return true;
    }
}
