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

class Calendar_EventWidget extends BaseWidget
{
    /** @var bool */
    public $multipleInstances = true;

    /**
     * @inheritDoc IComponentType::getName()
     *
     * @return string
     */
    public function getName()
    {
        return Craft::t('Quick Event');
    }

    /**
     * @return string
     */
    public function getIconPath()
    {
        return CRAFT_PLUGINS_PATH . 'calendar/resources/icon-mask.svg';
    }

    /**
     * @inheritDoc IWidget::getBodyHtml()
     *
     * @return string|false
     */
    public function getBodyHtml()
    {
        /** @var Calendar_SettingsModel $pluginSettings */
        $pluginSettings = craft()->plugins->getPlugin('calendar')->getSettings();

        /** @var Calendar_CalendarsService $calendarsService */
        $calendarsService = craft()->calendar_calendars;

        craft()->templates->includeJsResource('calendar/js/widget/event.js');
        craft()->templates->includeCssResource('calendar/css/widget/event.css');
        return craft()->templates->render(
            'calendar/_widgets/event/body',
            array(
                'event'           => new Calendar_EventModel(),
                'calendarOptions' => $calendarsService->getAllAllowedCalendarTitles(),
                'settings'        => $this->getSettings(),
            )
        );
    }

    /**
     * @return int
     */
    public function getColspan()
    {
        return 1;
    }
}
