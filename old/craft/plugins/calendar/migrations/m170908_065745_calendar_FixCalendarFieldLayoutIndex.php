<?php
namespace Craft;

/**
 * The class name is the UTC timestamp in the format of mYYMMDD_HHMMSS_pluginHandle_migrationName
 */
class m170908_065745_calendar_FixCalendarFieldLayoutIndex extends BaseMigration
{
	/**
	 * Any migration code in here is wrapped inside of a transaction.
	 *
	 * @return bool
	 */
	public function safeUp()
	{
        $this->dropForeignKey(
            'calendar_calendars',
            'fieldLayoutId'
        );

        $this->addForeignKey(
            'calendar_calendars',
            'fieldLayoutId',
            'fieldlayouts',
            'id',
            'SET NULL'
        );

		return true;
	}
}
