<?php
/**
 * Calendar for Craft
 *
 * @package       Solspace:Calendar
 * @author        Solspace, Inc.
 * @copyright     Copyright (c) 2010-2018, Solspace, Inc.
 * @link          https://solspace.com/craft/calendar
 * @license       https://solspace.com/software/license-agreement
 */

namespace Craft;

class Calendar_SettingsService extends BaseApplicationComponent
{
    /** @var Calendar_SettingsModel */
    private static $settingsModel;

    /**
     * @return int
     */
    public function getOverlapThreshold()
    {
        return $this->getSettingsModel()->overlapThreshold;
    }

    /**
     * @return int
     */
    public function getTimeInterval()
    {
        return $this->getSettingsModel()->timeInterval;
    }

    /**
     * @return int
     */
    public function getEventDuration()
    {
        return $this->getSettingsModel()->eventDuration;
    }

    /**
     * @return bool
     */
    public function isAllDayDefault()
    {
        return $this->getSettingsModel()->allDay;
    }

    /**
     * @return string
     */
    public function getDescriptionFieldHandle()
    {
        return $this->getSettingsModel()->descriptionFieldHandle;
    }

    /**
     * @return string
     */
    public function getLocationFieldHandle()
    {
        return $this->getSettingsModel()->locationFieldHandle;
    }

    /**
     * @return bool
     */
    public function isDemoBannerDisabled()
    {
        return $this->getSettingsModel()->isDemoBannerDisabled();
    }

    /**
     * @return bool
     */
    public function isMiniCalEnabled()
    {
        return $this->getSettingsModel()->isMiniCalEnabled();
    }

    /**
     * @return bool
     */
    public function showDisabledEvents()
    {
        return $this->getSettingsModel()->showDisabledEvents;
    }

    /**
     * @return bool
     */
    public function isQuickCreateEnabled()
    {
        return $this->getSettingsModel()->quickCreateEnabled;
    }

    /**
     * @return bool
     */
    public function isAuthoredEventEditOnly()
    {
        return $this->getSettingsModel()->authoredEventEditOnly;
    }

    /**
     * Disables the demo-install banner in month view
     *
     * @return bool
     */
    public function dismissDemoBanner()
    {
        $plugin = craft()->plugins->getPlugin('calendar');

        if ($plugin) {
            /** @var Calendar_SettingsModel $settings */
            $settings                     = $plugin->getSettings();
            $settings->demoBannerDisabled = true;

            $settingsArray = $settings->getAttributes();

            craft()->plugins->savePluginSettings($plugin, $settingsArray);

            return true;
        }

        return false;
    }

    /**
     * @return Calendar_SettingsModel
     */
    public function getSettingsModel()
    {
        if (is_null(self::$settingsModel)) {
            /** @var CalendarPlugin $plugin */
            $plugin              = craft()->plugins->getPlugin('calendar');
            self::$settingsModel = $plugin->getSettings();
        }

        return self::$settingsModel;
    }
}
