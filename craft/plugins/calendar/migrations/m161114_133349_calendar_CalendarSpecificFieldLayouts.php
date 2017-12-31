<?php
namespace Craft;

/**
 * The class name is the UTC timestamp in the format of mYYMMDD_HHMMSS_pluginHandle_migrationName
 */
class m161114_133349_calendar_CalendarSpecificFieldLayouts extends BaseMigration
{
    /**
     * Any migration code in here is wrapped inside of a transaction.
     *
     * @return bool
     */
    public function safeUp()
    {
        $settings = craft()->db->createCommand()
                               ->select("settings")
                               ->from("plugins")
                               ->where(array("class" => "Calendar"))
                               ->queryScalar();

        $descriptionFieldHandle = $locationFieldHandle = null;
        if ($settings) {
            $json = json_decode($settings, true);

            if ($json) {
                if (isset($json["descriptionFieldHandle"]) && $json["descriptionFieldHandle"]) {
                    $descriptionFieldHandle = $json["descriptionFieldHandle"];
                }

                if (isset($json["locationFieldHandle"]) && $json["locationFieldHandle"]) {
                    $locationFieldHandle = $json["locationFieldHandle"];
                }
            }
        }

        $previousLayout = craft()->fields->getLayoutByType("Calendar_Event");

        craft()->db->createCommand()->addColumn("calendar_calendars", "fieldLayoutId", ColumnType::Int);
        craft()->db->createCommand()->addColumn("calendar_calendars", "descriptionFieldHandle", ColumnType::Varchar);
        craft()->db->createCommand()->addColumn("calendar_calendars", "locationFieldHandle", ColumnType::Varchar);

        craft()->db->createCommand()->addForeignKey(
            'calendar_calendars',
            'fieldLayoutId',
            'fieldlayouts',
            'id',
            'CASCADE'
        );

        if ($previousLayout->id) {
            craft()->db->createCommand()->update("calendar_calendars", array("fieldLayoutId" => $previousLayout->id));

            if ($descriptionFieldHandle) {
                craft()->db->createCommand()->update(
                    "calendar_calendars",
                    array("descriptionFieldHandle" => $descriptionFieldHandle)
                );
            }

            if ($locationFieldHandle) {
                craft()->db->createCommand()->update(
                    "calendar_calendars",
                    array("locationFieldHandle" => $locationFieldHandle)
                );
            }
        }

        return true;
    }
}
