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

use Calendar\Library\PermissionsHelper;

class CalendarPlugin extends BasePlugin
{
    const FIELD_LAYOUT_TYPE = 'Calendar_Event';

    const EVENT_BEFORE_SAVE   = 'onBeforeSave';
    const EVENT_AFTER_SAVE    = 'onAfterSave';
    const EVENT_BEFORE_DELETE = 'onBeforeDelete';
    const EVENT_AFTER_DELETE  = 'onAfterDelete';

    const VIEW_MONTH     = 'month';
    const VIEW_WEEK      = 'week';
    const VIEW_DAY       = 'day';
    const VIEW_EVENTS    = 'events';
    const VIEW_CALENDARS = 'calendars';

    const PERMISSIONS_HELP_LINK = 'https://solspace.com/craft/calendar/docs/demo-templates';

    /** @var string */
    private $version = '1.10.5';

    /** @var string */
    private $schemaVersion = '1.5.5';

    /** @var string */
    private $releaseFeedUrl = 'https://solspace.com/craft/updates/calendar.json';

    /** @var string */
    private $developer = 'Solspace';

    /** @var string */
    private $developerUrl = 'https://solspace.com/craft/calendar';

    /** @var string */
    private $documentationUrl = 'https://solspace.com/craft/calendar';

    /** @var array */
    private $javascriptTranslationKeys = array(
        'Couldn’t save event.',
        'Event saved.',
        'Refresh',
        'New Event',
        'Starts',
        'Ends',
        'Repeats',
        'Edit',
        'Delete',
        'Delete occurrence',
        'Are you sure?',
        'Are you sure you want to delete this event?',
        'Couldn’t save event.',
        'Are you sure you want to enable ICS sharing for this calendar?',
        'Are you sure you want to disable ICS sharing for this calendar?',
    );

    /**
     * Includes CSS and JS files
     * Registers custom class auto-loader
     */
    public function init()
    {
        parent::init();

        craft()->on('i18n.onAddLocale', array(craft()->calendar_events, 'addLocaleHandler'));
        craft()->on('i18n.onAddLocale', array(craft()->calendar_calendars, 'addLocaleHandler'));

        if (craft()->request->isCpRequest() && craft()->userSession->isLoggedIn()) {
            craft()->templates->includeCssResource('calendar/css/main.css');
            craft()->templates->includeJsResource('calendar/js/main.js');
            craft()->templates->includeJsResource('calendar/js/fullcalendar/lib/moment.min.js');

            foreach ($this->javascriptTranslationKeys as $key) {
                craft()->templates->includeTranslations($key);
            }
            craft()->templates->hook('calendar.prepareCpTemplate', array($this, 'prepareCpTemplate'));
        }

        $this->registerAutoLoader();
    }

    /**
     * @return string
     */
    public function getName()
    {
        return Craft::t('Calendar');
    }

    /**
     * @return string
     */
    public function getVersion()
    {
        return $this->version;
    }

    /**
     * @inheritDoc IPlugin::getSchemaVersion()
     *
     * @return string|null
     */
    public function getSchemaVersion()
    {
        return $this->schemaVersion;
    }

    /**
     * @return string
     */
    public function getDeveloper()
    {
        return $this->developer;
    }

    /**
     * @return string
     */
    public function getDeveloperUrl()
    {
        return $this->developerUrl;
    }

    /**
     * @return string
     */
    public function getDocumentationUrl()
    {
        return $this->documentationUrl;
    }

    /**
     * @inheritDoc IPlugin::getReleaseFeedUrl()
     *
     * @return string|null
     */
    public function getReleaseFeedUrl()
    {
        return $this->releaseFeedUrl;
    }

    /**
     * @inheritDoc IPlugin::getDescription()
     *
     * @return string|null
     */
    public function getDescription()
    {
        return Craft::t('Create full-featured calendars and recurring events with exceptions.');
    }

    /**
     * @return bool
     */
    public function hasCpSection()
    {
        return true;
    }

    /**
     * @return bool
     */
    public function hasSettings()
    {
        return true;
    }

    /**
     * @return string
     */
    public function getSettingsHtml()
    {
        return craft()->templates->render('calendar/settings');
    }

    /**
     * @return array
     */
    public function registerUserPermissions()
    {
        /** @var Calendar_CalendarModel[] $calendars */
        $calendars = craft()->calendar_calendars->getAllCalendars();

        $editEventsPermissions = array(
            PermissionsHelper::PERMISSION_EVENTS_FOR_ALL => array(
                "label" => Craft::t("All calendars"),
            )
        );
        foreach ($calendars as $calendar) {
            $suffix = ':' . $calendar->id;

            $editEventsPermissions[PermissionsHelper::PERMISSION_EVENTS_FOR . $suffix] = array(
                'label' => Craft::t('"{name}" calendar', array('name' => $calendar->name)),
            );
        }

        return array(
            PermissionsHelper::PERMISSION_CALENDARS => array(
                'label'  => Craft::t('Administrate Calendars'),
                'nested' => array(
                    PermissionsHelper::PERMISSION_CREATE_CALENDARS => array('label' => Craft::t('Create Calendars')),
                    PermissionsHelper::PERMISSION_EDIT_CALENDARS   => array('label' => Craft::t('Edit Calendars')),
                    PermissionsHelper::PERMISSION_DELETE_CALENDARS => array('label' => Craft::t('Delete Calendars')),
                ),
            ),
            PermissionsHelper::PERMISSION_EVENTS    => array(
                'label'  => Craft::t('Manage events in'),
                'nested' => $editEventsPermissions,
            ),
            PermissionsHelper::PERMISSION_SETTINGS  => array('label' => Craft::t('Settings')),
        );
    }

    /**
     * On install - insert a default calendar
     *
     * @return void
     */
    public function onAfterInstall()
    {
        $this->registerAutoLoader();

        /** @var Calendar_CalendarsService $calendarsService */
        $calendarsService = craft()->calendar_calendars;

        $defaultCalendar              = Calendar_CalendarModel::create();
        $defaultCalendar->name        = "Default";
        $defaultCalendar->handle      = "default";
        $defaultCalendar->description = "The default calendar";

        $calendarsService->saveCalendar($defaultCalendar, false);

        /** @var LocaleModel[] $locales */
        $locales = craft()->i18n->getSiteLocales();

        $rows = array();
        foreach ($locales as $locale) {
            $rows[] = array($defaultCalendar->id, $locale->id, true);
        }

        craft()
            ->db
            ->createCommand()
            ->insertAll(
                "calendar_calendars_i18n",
                array("calendarId", "locale", "enabledByDefault"),
                $rows
            );
    }

    /**
     * @return Calendar_SettingsModel
     */
    protected function getSettingsModel()
    {
        return new Calendar_SettingsModel();
    }

    /**
     * @return string
     */
    public function getSettingsUrl()
    {
        return 'calendar/settings';
    }

    /**
     * @return array
     */
    public function registerCpRoutes()
    {
        $datePattern = '(?P<view>month|week|day)/(?P<year>\d+)/(?P<month>\d+)/(?P<day>\d+)';

        return array(
            'calendar'                                                      => array('action' => 'calendar/settings/defaultView'),
            'calendar/calendars'                                            => array('action' => 'calendar/calendars/calendarsIndex'),
            'calendar/calendars/new'                                        => array('action' => 'calendar/calendars/editCalendar'),
            'calendar/calendars/(?P<calendarHandle>\w+)'                    => array('action' => 'calendar/calendars/editCalendar'),
            'calendar/calendars/delete'                                     => array('action' => 'calendar/calendars/deleteCalendar'),
            'calendar/events'                                               => array('action' => 'calendar/events/eventsIndex'),
            'calendar/events/deleteEvent'                                   => array('action' => 'calendar/events/deleteEvent'),
            'calendar/events/new'                                           => array('action' => 'calendar/events/editEvent'),
            'calendar/events/new/(?P<calendarHandle>\w+)'                   => array('action' => 'calendar/events/editEvent'),
            'calendar/events/new/(?P<calendarHandle>\w+)/(?P<localeId>\w+)' => array('action' => 'calendar/events/editEvent'),
            'calendar/events/(?P<eventId>\d+)'                              => array('action' => 'calendar/events/editEvent'),
            'calendar/events/(?P<eventId>\d+)/(?P<localeId>\w+)'            => array('action' => 'calendar/events/editEvent'),
            // API calls
            'calendar/events/api/modifyDate'                                => array('action' => 'calendar/eventsApi/modifyDate'),
            'calendar/events/api/modifyDuration'                            => array('action' => 'calendar/eventsApi/modifyDuration'),
            'calendar/events/api/create'                                    => array('action' => 'calendar/eventsApi/create'),
            'calendar/events/api/delete'                                    => array('action' => 'calendar/eventsApi/delete'),
            'calendar/events/api/deleteOccurrence'                          => array('action' => 'calendar/eventsApi/deleteOccurrence'),
            // Views
            'calendar/month'                                                => array('action' => 'calendar/view/monthData'),
            'calendar/view/(?P<view>month|week|day)'                        => array('action' => 'calendar/view/targetTime'),
            'calendar/view/' . $datePattern                                 => array('action' => 'calendar/view/targetTime'),
            // Settings
            'calendar/settings/license'                                     => array('action' => 'calendar/settings/license'),
            'calendar/settings/general'                                     => array('action' => 'calendar/settings/general'),
            'calendar/settings/events'                                      => array('action' => 'calendar/settings/events'),
            'calendar/settings/guest-access'                                => array('action' => 'calendar/settings/guestAccess'),
            'calendar/settings/ics'                                         => array('action' => 'calendar/settings/ics'),
            'calendar/settings/demo-templates'                              => array('action' => 'calendar/codePack/listContents'),
        );
    }

    /**
     * Prepares a CP template.
     *
     * @param mixed &$context The current template context
     */
    public function prepareCpTemplate(&$context)
    {
        $context['subnav'] = array();

        $context['subnav']['month'] = array(
            'label' => Craft::t('Month'),
            'url'   => UrlHelper::getCpUrl('calendar/view/month'),
            'class' => 'icon-cog',
        );
        $context['subnav']['week']  = array(
            'label' => Craft::t('Week'),
            'url'   => UrlHelper::getCpUrl('calendar/view/week'),
        );
        $context['subnav']['day']   = array(
            'label' => Craft::t('Day'),
            'url'   => UrlHelper::getCpUrl('calendar/view/day'),
        );

        if (PermissionsHelper::checkPermission(PermissionsHelper::PERMISSION_EVENTS_FOR, true)) {
            $context['subnav']['events'] = array(
                'label' => Craft::t('Events'),
                'url'   => UrlHelper::getCpUrl('calendar/events'),
            );
        }

        if (PermissionsHelper::checkPermission(PermissionsHelper::PERMISSION_CALENDARS)) {
            $context['subnav']['calendars'] = array(
                'label' => Craft::t('Calendars'),
                'url'   => UrlHelper::getCpUrl('calendar/calendars'),
            );
        }

        if (PermissionsHelper::checkPermission(PermissionsHelper::PERMISSION_SETTINGS)) {
            $context['subnav']['settings'] = array(
                'label' => Craft::t('Settings'),
                'url'   => UrlHelper::getCpUrl('calendar/settings'),
            );
        }
    }

    /**
     * @return Calendar_TwigExtension
     */
    public function addTwigExtension()
    {
        Craft::import('plugins.calendar.twigextensions.Calendar_TwigExtension');
        Craft::import('plugins.calendar.twigextensions.RequireEventEditPermissions_TokenParser');
        Craft::import('plugins.calendar.twigextensions.RequireEventEditPermissions_Node');

        return new Calendar_TwigExtension();
    }

    /**
     * Register custom class auto-loader
     * Since Craft 2.x does not yet support PSR-0
     */
    private function registerAutoLoader()
    {
        require_once __DIR__ . '/vendor/autoload.php';
    }
}

if (!function_exists('calendar')) {
    /**
     * @return CalendarService
     */
    function calendar()
    {
        static $instance;

        if (null === $instance) {
            $instance = Craft::app()->getComponent('calendar');
        }

        return $instance;
    }
}
