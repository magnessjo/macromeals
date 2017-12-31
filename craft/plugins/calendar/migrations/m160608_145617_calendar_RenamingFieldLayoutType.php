<?php
namespace Craft;

/**
 * The class name is the UTC timestamp in the format of mYYMMDD_HHMMSS_pluginHandle_migrationName
 */
class m160608_145617_calendar_RenamingFieldLayoutType extends BaseMigration
{
    /**
     * Any migration code in here is wrapped inside of a transaction.
     *
     * @return bool
     */
    public function safeUp()
    {
        craft()->db
            ->createCommand()
            ->update(
                'fieldlayouts',
                array('type' => 'Calendar_Event'),
                'type=:elementType',
                array(':elementType' => 'calendar_event_layout')
            );

        return true;
    }
}
