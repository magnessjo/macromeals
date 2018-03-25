<?php
namespace Craft;

/**
 * The class name is the UTC timestamp in the format of mYYMMDD_HHMMSS_pluginHandle_migrationName
 */
class m170109_140549_calendar_AddCalendarIcsHash extends BaseMigration
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
                "calendar_calendars",
                "icsHash",
                array(
                    ColumnType::Varchar,
                    "length" => 200,
                )
            );

	    craft()
            ->db
            ->createCommand()
            ->createIndex(
                "calendar_calendars",
                "icsHash",
                true
            );

		return true;
	}
}
