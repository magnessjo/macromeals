<?php
namespace Craft;

/**
 * The class name is the UTC timestamp in the format of mYYMMDD_HHMMSS_pluginHandle_migrationName
 */
class m170214_122842_calendar_AddingEventTitleOption extends BaseMigration
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
                'titleFormat',
                array(
                    ColumnType::Varchar,
                    'length' => 200,
                )
            );

        craft()
            ->db
            ->createCommand()
            ->addColumn(
                'calendar_calendars',
                'hasTitleField',
                array(
                    ColumnType::Bool,
                    'default'  => true,
                    'required' => true,
                )
            );

        craft()
            ->db
            ->createCommand()
            ->addColumn(
                'calendar_calendars',
                'titleLabel',
                array(
                    ColumnType::Varchar,
                    'length'  => 200,
                    'default' => 'Title',
                )
            );

        return true;
    }
}
