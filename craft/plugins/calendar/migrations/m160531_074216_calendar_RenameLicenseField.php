<?php
namespace Craft;

/**
 * The class name is the UTC timestamp in the format of mYYMMDD_HHMMSS_pluginHandle_migrationName
 */
class m160531_074216_calendar_RenameLicenseField extends BaseMigration
{
	/**
	 * Any migration code in here is wrapped inside of a transaction.
	 *
	 * @return bool
	 */
	public function safeUp()
	{
		$query = craft()->db->createCommand("SELECT settings FROM craft_plugins WHERE class = 'Calendar' LIMIT 1");

		$results = $query->queryColumn();
		if (isset($results[0])) {
			$settings = $results[0];
			$settings = json_decode($settings);

			// Rename Licence to License
			if (is_object($settings) && isset($settings->licence)) {
				$settings->license = $settings->licence;
				unset($settings->licence);

				$settingsJson = json_encode($settings, JSON_FORCE_OBJECT);

				$command = craft()->db->createCommand("UPDATE craft_plugins SET settings = :settings WHERE class = 'Calendar' LIMIT 1");
				$command->execute(array(':settings' => $settingsJson));
			}
		}

		return true;
	}
}
