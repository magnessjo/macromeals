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

use Calendar\Library\DatabaseHelper;
use Calendar\Library\DateHelper;
use Calendar\Library\DateTimeUTC;
use Calendar\Library\Exceptions\EventException;
use Calendar\Library\PermissionsHelper;
use Calendar\Library\RecurrenceHelper;

class Calendar_EventsController extends BaseController
{
    const EVENT_FIELD_NAME = 'calendarEvent';

    protected $allowAnonymous = array('actionSaveEvent');

    /**
     * @throws HttpException
     */
    public function actionEventsIndex()
    {
        $this->requireEventPermission();
        $variables['calendars'] = craft()->calendar_calendars->getAllAllowedCalendars();

        $this->renderTemplate('calendar/events/_index', $variables);
    }

    /**
     * @param array $variables
     *
     * @throws HttpException
     * @throws \Craft\Exception
     */
    public function actionEditEvent(array $variables = array())
    {
        $this->requireEventPermission();

        /** @var Calendar_CalendarsService $calendarService */
        $calendarService = craft()->calendar_calendars;
        $calendarOptions = craft()->calendar_calendars->getAllAllowedCalendarTitles();
        $calendarHandle  = isset($variables['calendarHandle']) ? $variables['calendarHandle'] : null;

        $calendar = null;
        if ($calendarHandle) {
            $calendar = $calendarService->getCalendarByHandle($calendarHandle);
        }

        if (!craft()->isLocalized()) {
            $variables['localeIds']      = null;
            $variables['localeId']       = null;
            $variables['enabledLocales'] = null;
        }

        $variables["localeIds"] = craft()->i18n->getEditableLocaleIds();
        if (!isset($variables['localeId']) || empty($variables['localeId'])) {
            $variables['localeId'] = craft()->language;

            if (!in_array($variables['localeId'], $variables['localeIds'], true)) {
                if (empty($variables['localeIds'])) {
                    throw new Exception("You don't have permission to edit any locales");
                }
                $variables['localeId'] = $variables['localeIds'][0];
            }
        } else {
            // Make sure they were requesting a valid locale
            if (!in_array($variables['localeId'], $variables['localeIds'], true)) {
                throw new HttpException(404);
            }
        }

        // Now let's set up the actual event
        if (empty($variables['event'])) {
            $eventId = isset($variables['eventId']) ? $variables['eventId'] : null;
            if ($eventId) {
                /** @var Calendar_EventModel $event */
                $event = craft()->calendar_events->getEventById($eventId, $variables['localeId'], false);

                if (!$event) {
                    throw new HttpException(
                        404,
                        Craft::t('Could not find an Event with ID {id}', array('id' => $eventId))
                    );
                }

                PermissionsHelper::requireEventEditPermissions($event);

                $title = $event->title;
                if (null === $calendar) {
                    $calendar = $event->getCalendar();
                }
            } else {
                $event = Calendar_EventModel::create();
                if (craft()->isLocalized() && isset($variables['localeId'])) {
                    $event->locale = $variables['localeId'];
                }
                $title = Craft::t('Create a new event');

                if ($calendar) {
                    $event->calendarId = $calendar->id;
                }
            }
        } else {
            /** @var Calendar_EventModel $event */
            $event   = $variables['event'];
            $eventId = $event->id;
            $title   = $event->title;

            if (null === $calendar) {
                $calendar = $event->getCalendar();
            }
        }

        $canManageAll = PermissionsHelper::checkPermission(PermissionsHelper::PERMISSION_EVENTS_FOR_ALL);
        if (!$canManageAll) {
            PermissionsHelper::requirePermission(
                PermissionsHelper::prepareNestedPermission(PermissionsHelper::PERMISSION_EVENTS_FOR, $calendar->id)
            );
        }

        $this->fillLocaleData($event, $variables);
        $this->fillEnabledLocales($event, $variables);

        $exceptions = craft()->calendar_exceptions->getExceptionsForEvent($event);

        $localeId = craft()->getLocale()->getId();
        $localeId = str_replace('_', '-', strtolower($localeId));
        if (file_exists(__DIR__ . '/../resources/js/moment/locale/' . $localeId . '.js')) {
            craft()->templates->includeJsResource('calendar/js/moment/locale/' . $localeId . '.js');
        }

        craft()->templates->includeJs('Craft.LivePreview.init('.JsonHelper::encode(array(
                'fields'        => '#title-field, #fields > div > div > .field, #fields > div > .field',
                'extraFields'   => '#settings',
                'previewUrl'    => $event->getUrl(),
                'previewAction' => 'calendar/events/preview',
                'previewParams' => array(
                    'eventId'    => $event->id,
                    'locale'     => $event->locale,
                    'calendarId' => $event->calendarId,
                )
            )).');');
        
        $variables = array_merge(
            $variables,
            array(
                'name'               => self::EVENT_FIELD_NAME,
                'event'              => $event,
                'title'              => $title,
                'calendar'           => $calendar,
                'calendarOptions'    => $calendarOptions,
                'frequencyOptions'   => RecurrenceHelper::getFrequencyOptions(),
                'repeatsByOptions'   => RecurrenceHelper::getRepeatsByOptions(),
                'weekDays'           => DateHelper::getWeekDaysShort(0, 2, true),
                'monthDays'          => DateHelper::getMonthDays(),
                'monthNames'         => DateHelper::getMonthNames(true),
                'continueEditingUrl' => 'calendar/events/{id}/{locale}',
                'exceptions'         => $exceptions,
                'userElementType'    => new ElementTypeVariable(craft()->elements->getElementType(ElementType::User)),
                'showPreviewBtn'     => $calendar->hasUrls,
                'shareUrl'           => $calendar->hasUrls ? $event->getUrl() : null,
                'crumbs'             => array(
                    array('label' => Craft::t('calendar'), 'url' => UrlHelper::getUrl('calendar')),
                    array('label' => Craft::t('Events'), 'url' => UrlHelper::getUrl('calendar/events')),
                    array(
                        'label' => $title,
                        'url'   => UrlHelper::getUrl(
                            'calendar/events/' . ($eventId ? $eventId : 'new/' . $calendarHandle)
                        ),
                    ),
                ),
            )
        );

        $this->renderTemplate('calendar/events/_edit', $variables);
    }

    /**
     * Saves an event.
     */
    public function actionSaveEvent()
    {
        $this->requirePostRequest();

        $eventId = craft()->request->getPost('eventId');
        $locale  = craft()->request->getPost('locale') ?: craft()->locale->id;
        $event   = $this->getExistingOrNewEvent($eventId, $locale);

        $this->populateEventModel($event);

        if ($event->id) {
            PermissionsHelper::requireEventEditPermissions($event);
        }

        if (craft()->calendar_events->saveEvent($event)) {
            $values     = craft()->request->getPost(self::EVENT_FIELD_NAME);
            $exceptions = isset($values['exceptions']) ? $values['exceptions'] : array();
            craft()->calendar_exceptions->saveExceptions($event, $exceptions);

            $selectDates = array();
            if ($event->repeatsOnSelectDates()) {
                $selectDates = isset($values['selectDates']) ? $values['selectDates'] : array();
            }
            craft()->calendar_selectDates->saveDates($event, $selectDates);

            // Return JSON response if the request is an AJAX request
            if (craft()->request->isAjaxRequest()) {
                $this->returnJson(array('success' => true));
            } else {
                craft()->userSession->setNotice(Craft::t('Event saved.'));
                craft()->userSession->setFlash('calendar_event_saved', true);
                $this->redirectToPostedUrl($event);
            }
        } else {
            // Return JSON response if the request is an AJAX request
            if (craft()->request->isAjaxRequest()) {
                $this->returnJson(array('success' => false));
            } else {
                craft()->userSession->setError(Craft::t('Couldn’t save event.'));

                // Send the event back to the template
                craft()->urlManager->setRouteVariables(array('event' => $event, 'errors' => $event->getErrors()));
            }
        }
    }

    /**
     * Previews an entry.
     *
     * @return null
     * @throws HttpException
     * @throws EventException
     */
    public function actionPreview()
    {
        $this->requirePostRequest();
        $event = $this->getEventModel();

        // Set the language to the user's preferred locale so DateFormatter returns the right format
        craft()->setLanguage(craft()->getTargetLanguage(true));

        $this->populateEventModel($event);

        $this->showEvent($event);
    }

    /**
     * Deletes an event.
     */
    public function actionDeleteEvent()
    {
        $this->requireEventPermission();
        $this->requirePostRequest();

        $eventId         = craft()->request->getRequiredPost('eventId');
        $eventWasDeleted = craft()->calendar_events->deleteEventById($eventId);

        if ($eventWasDeleted) {
            // Return JSON response if the request is an AJAX request
            if (craft()->request->isAjaxRequest()) {
                $this->returnJson(array('success' => true));
            } else {
                craft()->userSession->setNotice(Craft::t('Event deleted.'));
                $this->redirectToPostedUrl();
            }
        } else {
            // Return JSON response if the request is an AJAX request
            if (craft()->request->isAjaxRequest()) {
                $this->returnJson(array('success' => false));
            } else {
                craft()->userSession->setError(Craft::t('Couldn’t delete event.'));
            }
        }
    }

    /**
     * @param int    $eventId
     * @param string $locale
     *
     * @return Calendar_EventModel
     * @throws Exception
     */
    private function getExistingOrNewEvent($eventId = null, $locale = null)
    {
        if ($eventId) {
            /** @var Calendar_EventModel $event */
            $event = craft()->calendar_events->getEventById($eventId, $locale, false);

            if (!$event) {
                throw new Exception(Craft::t('Could not find an Event with ID {id}', array('id' => $eventId)));
            }
        } else {
            $event = Calendar_EventModel::create($locale);
        }

        return $event;
    }

    /**
     * Parses the $postedValues and extracts recurrence rules if there are any
     * Updates the $event model
     *
     * @param Calendar_EventModel $event
     * @param array               $postedValues
     *
     * @throws EventException
     */
    private function handleRepeatRules(Calendar_EventModel $event, array $postedValues)
    {
        if (!isset($postedValues['repeats'])) {
            return;
        }

        $event->rrule      = null;
        $event->freq       = null;
        $event->interval   = null;
        $event->until      = null;
        $event->count      = null;
        $event->byDay      = null;
        $event->byMonth    = null;
        $event->byMonthDay = null;
        $event->byYearDay  = null;

        if (!$postedValues['repeats']) {
            return;
        }

        $selectedFrequency = $postedValues['frequency'];
        $selectedInterval  = abs((int)$postedValues['interval']);

        if ($selectedInterval < 1) {
            $event->addError('interval', Craft::t('Event interval must be a positive number'));

            return;
        }

        $event->freq = $selectedFrequency;

        if ($selectedFrequency == RecurrenceHelper::SELECT_DATES) {
            return;
        }

        $event->interval = $selectedInterval;

        $untilType = isset($postedValues['untilType']) ? $postedValues['untilType'] : Calendar_EventModel::UNTIL_TYPE_FOREVER;
        switch ($untilType) {
            case Calendar_EventModel::UNTIL_TYPE_UNTIL:
                $until = null;
                if (isset($postedValues['untilDate']['date']) && $postedValues['untilDate']['date']) {
                    $until = DateTimeUTC::createFromString($postedValues['untilDate']);
                    $until->setTime(23, 59, 59);
                    $event->until = $until;
                } else {
                    $event->addError('untilType', Craft::t('End repeat date must be specified'));
                }

                break;

            case Calendar_EventModel::UNTIL_TYPE_COUNT:
                $count = isset($postedValues['count']) ? (int)$postedValues['count'] : 0;
                if ($count) {
                    $event->count = $count;
                } else {
                    $event->addError('untilType', Craft::t('End repeat count must be specified'));
                }

                break;
        }


        switch ($event->freq) {
            case RecurrenceHelper::DAILY:
                break;

            case RecurrenceHelper::WEEKLY:
                if (!isset($postedValues['weekly']['repeatsByWeekDay'])) {
                    $event->addError('byDay', Craft::t('Event repeat rules not specified'));

                    return;
                }

                $repeatsByWeekDay = $postedValues['weekly']['repeatsByWeekDay'];
                $event->byDay     = !empty($repeatsByWeekDay) ? implode(',', $repeatsByWeekDay) : null;
                break;

            case RecurrenceHelper::MONTHLY:
                $repeatsBy = $postedValues['monthly']['repeatsBy'];

                if ($repeatsBy == 'byDay') {
                    if (!isset($postedValues['monthly']['repeatsByWeekDay'])
                        || !(isset($postedValues['monthly']['repeatsByDayInterval']))
                    ) {
                        $event->addError('byDay', Craft::t('Event repeat rules not specified'));

                        return;
                    }
                    $repeatsByWeekDay     = $postedValues['monthly']['repeatsByWeekDay'];
                    $repeatsByDayInterval = (int)$postedValues['monthly']['repeatsByDayInterval'];

                    $repeatsByWeekDay = array_map(
                        function ($value) use ($repeatsByDayInterval) {
                            return sprintf('%d%s', $repeatsByDayInterval, $value);
                        },
                        $repeatsByWeekDay
                    );

                    $event->byDay = !empty($repeatsByWeekDay) ? implode(',', $repeatsByWeekDay) : null;
                } elseif ($repeatsBy == 'byMonthDay') {
                    $repeatsByMonthDay = $postedValues['monthly']['repeatsByMonthDay'];
                    $event->byMonthDay = !empty($repeatsByMonthDay) ? implode(',', $repeatsByMonthDay) : null;
                }

                break;

            case RecurrenceHelper::YEARLY:
                $repeatsByDay = isset($postedValues['yearly']['repeatsBy']) && $postedValues['yearly']['repeatsBy'] == 'byDay';

                if ($repeatsByDay) {
                    if (!isset($postedValues['yearly']['repeatsByWeekDay'])
                        || !(isset($postedValues['yearly']['repeatsByMonth']))
                    ) {
                        $event->addError('byDay', Craft::t('Event repeat rules not specified'));

                        return;
                    }

                    $repeatsByDayInterval = (int)$postedValues['yearly']['repeatsByDayInterval'];
                    $repeatsByWeekDay     = $postedValues['yearly']['repeatsByWeekDay'];
                    $repeatsByMonth       = $postedValues['yearly']['repeatsByMonth'];

                    if (is_array($repeatsByWeekDay)) {
                        $repeatsByWeekDay = array_map(
                            function ($value) use ($repeatsByDayInterval) {
                                return sprintf('%d%s', $repeatsByDayInterval, $value);
                            },
                            $repeatsByWeekDay
                        );
                    }

                    $event->byDay   = !empty($repeatsByWeekDay) ? implode(',', $repeatsByWeekDay) : null;
                    $event->byMonth = !empty($repeatsByMonth) ? implode(',', $repeatsByMonth) : null;
                }

                break;

            default:
                throw new EventException(sprintf("Frequency type '%s' not recognized", $event->freq));
                break;
        }

        $event->rrule = $event->getRRuleRFCString();
    }

    /**
     * @param Calendar_EventModel $event
     * @param array               $variables
     *
     * @throws HttpException
     */
    private function fillLocaleData(Calendar_EventModel $event, array &$variables)
    {
        $variables['enabledLocales'] = array();
        $variables['localeIds']      = array_keys($event->getCalendar()->getLocales());

        if (craft()->isLocalized() && empty($variables['localeIds'])) {
            throw new HttpException(
                403,
                Craft::t('Your account doesn’t have permission to edit any of this site’s locales.')
            );
        } else if (!craft()->isLocalized()) {
            $variables["localeIds"] = array(craft()->locale->id);
        }
    }

    /**
     * Add enabledLocales to the variables array
     *
     * @param Calendar_EventModel $event
     * @param array               $variables
     */
    private function fillEnabledLocales(Calendar_EventModel $event, array &$variables)
    {
        $variables['enabledLocales'] = array();
        if (!craft()->isLocalized()) {
            $variables["enabledLocales"] = array(craft()->locale->id);
            return;
        }

        if ($event->id) {
            $variables['enabledLocales'] = craft()->elements->getEnabledLocalesForElement($event->id);
        } else {
            $variables['enabledLocales'] = array();

            /** @var Calendar_CalendarLocaleModel $locale */
            foreach ($event->getCalendar()->getLocales() as $localeId => $locale) {
                if ($locale->enabledByDefault) {
                    $variables['enabledLocales'][] = $localeId;
                }
            }
        }
    }

    /**
     * Triggers a 404 if there are no event edit permissions for the current user
     */
    private function requireEventPermission()
    {
        $hasPermission = PermissionsHelper::checkPermission(PermissionsHelper::PERMISSION_EVENTS_FOR, true);

        if (!$hasPermission) {
            craft()->getUser()->requirePermission('trigger-calendar-event-access-denied');
        }
    }

    /**
     * Fetches or creates an EntryModel.
     *
     * @return Calendar_EventModel
     */
    private function getEventModel()
    {
        $eventId = craft()->request->getPost('eventId');
        $localeId = craft()->request->getPost('locale');
        $calendarId = craft()->request->getPost('calendarId');

        if ($eventId) {
            $event = calendar()->events->getEventById($eventId, $localeId, false);

            if (!$event) {
                Craft::t('Could not find an Event with ID {id}', array('id' => $eventId));
            }
        } else {
            $event = Calendar_EventModel::create($localeId);
            $event->calendarId = $calendarId;
        }

        return $event;
    }

    /**
     * @param Calendar_EventModel $event
     *
     * @throws EventException
     * @throws HttpException
     */
    private function populateEventModel(Calendar_EventModel $event)
    {
        $eventId = $event->id;
        $values  = craft()->request->getPost(self::EVENT_FIELD_NAME);
        if (null === $values) {
            throw new HttpException('No event data posted');
        }

        // Update authors only if Craft PRO is enabled
        // And if the author is posted.
        // If not - it stays the same
        // By default the Logged in user ID is used
        if (craft()->getEdition() == Craft::Pro) {
            $authorList = craft()->request->getPost('author');
            if (is_array($authorList) && !empty($authorList)) {
                $authorId        = (int)reset($authorList);
                $event->authorId = $authorId;
            }
        }

        $isEnabled      = (bool)craft()->request->getPost('enabled', $event->enabled);
        $event->enabled = $isEnabled;

        if (isset($values['calendarId'])) {
            $event->calendarId = $values['calendarId'];
        }

        $isCalendarPublic = craft()->calendar_calendars->isCalendarPublic($event->getCalendar());

        $isNewAndPublic = !$event->id && !$isCalendarPublic;
        if ($eventId || $isNewAndPublic) {
            PermissionsHelper::requireCalendarEditPermissions($event->getCalendar());
        }

        if (isset($values['startDate'])) {
            $event->startDate = DateTimeUTC::createFromString($values['startDate']);
        }

        if (isset($values['endDate'])) {
            $event->endDate = DateTimeUTC::createFromString($values['endDate']);
        }

        if (isset($values['allDay'])) {
            $event->allDay = (bool)$values['allDay'];
        }

        if ($event->allDay && $event->startDate && $event->endDate) {
            $event->startDate->setTime(0, 0, 0);
            $event->endDate->setTime(23, 59, 59);
        }

        $startDateCarbon = $event->getStartDateCarbon();
        $endDateCarbon   = $event->getEndDateCarbon();

        if ($startDateCarbon && $endDateCarbon && $startDateCarbon->eq($endDateCarbon)) {
            $endDate = $endDateCarbon->addHour();
            $event->endDate->setTime(
                $endDate->hour,
                $endDate->minute,
                $endDate->second
            );
        }

        $this->handleRepeatRules($event, $values);

        if (isset($values['exceptions'])) {
            foreach ($values['exceptions'] as $date) {
                $exception = new Calendar_ExceptionModel();
                $exception->eventId = $event->id;
                $exception->date    = new DateTimeUTC($date);

                $event->addException($exception);
            }
        }

        if (isset($values['selectDates'])) {
            foreach ($values['selectDates'] as $date) {
                $selectDate = new Calendar_SelectDateModel();
                $selectDate->eventId = $event->id;
                $selectDate->date    = new DateTimeUTC($date);

                $event->addSelectDate($selectDate);
            }
        }

        $event->localeEnabled       = (bool)craft()->request->getPost('localeEnabled', $event->localeEnabled);
        $event->getContent()->title = craft()->request->getPost('title', $event->title);
        $event->setContentFromPost('fields');

        $event->slug = craft()->request->getPost('slug', $event->slug);
    }

    /**
     * Displays an entry.
     *
     * @param Calendar_EventModel $event
     *
     * @throws HttpException
     * @return null
     */
    private function showEvent(Calendar_EventModel $event)
    {
        craft()->setLanguage($event->locale);

        // Have this entry override any freshly queried entries with the same ID/locale
        craft()->elements->setPlaceholderElement($event);

        craft()->templates->getTwig()->disableStrictVariables();

        $this->renderTemplate($event->getCalendar()->eventTemplate, array(
            'event' => $event->getSimpleEventObject(),
        ));
    }
}
