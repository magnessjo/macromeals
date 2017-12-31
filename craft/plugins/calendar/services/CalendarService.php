<?php

namespace Craft;

class CalendarService extends BaseApplicationComponent
{
    /** @var Calendar_CalendarsService */
    public $calendars;

    /** @var Calendar_EventsService */
    public $events;

    /** @var Calendar_ExceptionsService */
    public $exceptions;

    /** @var Calendar_SelectDatesService */
    public $selectDates;

    /** @var Calendar_SettingsService */
    public $settings;

    /** @var Calendar_ViewDataService */
    public $viewData;

    /**
     * Loads Calendar services
     */
    public function init()
    {
        parent::init();

        $this->calendars   = Craft::app()->getComponent('calendar_calendars');
        $this->events      = Craft::app()->getComponent('calendar_events');
        $this->exceptions  = Craft::app()->getComponent('calendar_exceptions');
        $this->selectDates = Craft::app()->getComponent('calendar_selectDates');
        $this->settings    = Craft::app()->getComponent('calendar_settings');
        $this->viewData    = Craft::app()->getComponent('calendar_viewData');
    }
}
