<?php
namespace Craft;

/**
 * The class name is the UTC timestamp in the format of mYYMMDD_HHMMSS_pluginHandle_migrationName
 */
class m160516_063653_calendar_SelectDatesTable extends BaseMigration
{
    /**
     * Any migration code in here is wrapped inside of a transaction.
     *
     * @return bool
     */
    public function safeUp()
    {
        $columns = array(
            'eventId' => array('column' => 'integer', 'required' => true),
            'date'    => array('column' => 'datetime', 'required' => true),
        );

        craft()->db->createCommand()->createTable('calendar_select_dates', $columns);

        craft()->db->createCommand()->createIndex('calendar_select_dates', 'eventId,date', false);

        craft()->db->createCommand()->addForeignKey(
            'calendar_select_dates',
            'eventId',
            'calendar_events',
            'id',
            'CASCADE',
            'CASCADE'
        );

        return true;
    }
}
