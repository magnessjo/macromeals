<?php
namespace Craft;

/**
 * The class name is the UTC timestamp in the format of mYYMMDD_HHMMSS_pluginHandle_migrationName
 */
class m170907_073346_calendar_FixCalendarI18nForeignKeys extends BaseMigration
{
	/**
	 * Any migration code in here is wrapped inside of a transaction.
	 *
	 * @return bool
	 */
	public function safeUp()
	{
        $this->dropForeignKey(
	        'calendar_calendars_i18n',
            'calendarId'
        );

	    $existingIds = craft()->db->createCommand()
            ->select('id')
            ->from('calendar_calendars')
            ->queryColumn();

	    array_walk($existingIds, function (&$value) {
	        $value = (int) $value;
        });

	    $conditions = 'calendarId NOT IN(' . implode(',', $existingIds) . ') OR calendarId IS NULL';

        craft()->db->createCommand()
            ->delete(
                'calendar_calendars_i18n',
                $conditions
            );

        craft()->db->createCommand()->addForeignKey(
            'calendar_calendars_i18n',
            'calendarId',
            'calendar_calendars',
            'id',
            'CASCADE',
            'CASCADE'
        );

        return true;
	}
}
