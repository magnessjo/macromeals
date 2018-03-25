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

namespace Calendar\Library\Events;

use Calendar\Library\Carbon;
use Calendar\Library\DataObjects\OccurrenceLoader;
use Calendar\Library\DateHelper;
use Calendar\Library\DateTimeUTC;
use Calendar\Library\Duration\EventDuration;
use Calendar\Library\PermissionsHelper;
use Calendar\Library\RecurrenceHelper;
use Craft\Calendar_EventModel;
use Craft\Calendar_SelectDateModel;
use Craft\DateTime;
use Craft\UserModel;
use Library\Events\TinyBaseModel;
use RRule\RRule;

class Event extends TinyBaseModel
{
    /** @var int */
    private $authorId;

    /** @var UserModel */
    private $author;

    /** @var string */
    private $slug;

    /** @var string */
    private $url;

    /** @var bool */
    private $enabled;

    /** @var string */
    private $status;

    /** @var DateTime */
    private $dateCreated;

    /** @var Carbon */
    private $startDate;

    /** @var Carbon */
    private $endDate;

    /** @var bool */
    private $allDay;

    /** @var bool */
    private $multiDay;

    /** @var bool */
    private $repeating;

    /** @var int */
    private $interval;

    /** @var string */
    private $freq;

    /** @var array */
    private $byMonth;

    /** @var array */
    private $byMonthDay;

    /** @var array */
    private $byDay;

    /** @var int */
    private $untilType;

    /** @var Carbon */
    private $untilDate;

    /** @var bool */
    private $finite;

    /** @var bool */
    private $infinite;

    /** @var int */
    private $count;

    /** @var int */
    private $repeatsOnRule;

    /** @var bool */
    private $repeatsOnSelectDates;

    /** @var string */
    private $rrule;

    /** @var RRule */
    private $rruleObject;

    /** @var string */
    private $readableRepeatRule;

    /** @var string */
    private $simplifiedRepeatRule;

    /** @var bool */
    private $editable;

    /** @var Calendar */
    private $calendar;

    /** @var array|string[] */
    private $exceptions;

    /** @var array|\DateTime[] */
    private $selectDates;

    /** @var Event[] */
    private $occurrences;

    /**
     * @return Event
     */
    public static function create()
    {
        $event = new self();

        $event->calendar = new Calendar();

        return $event;
    }

    /**
     * @param Calendar_EventModel $eventModel
     * @param Carbon              $targetDate
     * @param OccurrenceLoader    $occurrenceLoader
     *
     * @return Event
     */
    public static function createFromModel(
        Calendar_EventModel $eventModel,
        Carbon $targetDate = null,
        OccurrenceLoader $occurrenceLoader = null
    ) {
        $startDate = $eventModel->getStartDateCarbon();
        $endDate   = $eventModel->getEndDateCarbon();

        if (null !== $targetDate && null !== $startDate) {
            $diffInSeconds = $startDate->diffInSeconds($endDate);

            $startDate->setDateTime(
                $targetDate->year,
                $targetDate->month,
                $targetDate->day,
                $startDate->hour,
                $startDate->minute,
                $startDate->second
            );
            $endDate = $startDate->copy();
            $endDate->addSeconds($diffInSeconds);
        }

        $event                       = new Event();
        $event->id                   = $eventModel->id;
        $event->title                = $eventModel->title;
        $event->locale               = $eventModel->locale;
        $event->content              = $eventModel->getContent();
        $event->enabled              = $eventModel->enabled;
        $event->status               = $eventModel->status;
        $event->dateCreated          = $eventModel->dateCreated;
        $event->authorId             = $eventModel->authorId;
        $event->author               = $eventModel->author;
        $event->slug                 = $eventModel->slug;
        $event->url                  = $eventModel->url;
        $event->startDate            = $startDate;
        $event->endDate              = $endDate;
        $event->allDay               = $eventModel->allDay;
        $event->multiDay             = $eventModel->isMultiDay();
        $event->repeating            = $eventModel->repeats();
        $event->interval             = $eventModel->interval;
        $event->freq                 = $eventModel->getFrequency();
        $event->byDay                = $eventModel->getRepeatsByWeekDaysAbsolute();
        $event->byMonthDay           = $eventModel->getRepeatsByMonthDays();
        $event->byMonth              = $eventModel->getRepeatsByMonths();
        $event->untilType            = $eventModel->getUntilType();
        $event->untilDate            = $eventModel->getUntilCarbon();
        $event->finite               = $eventModel->isFinite();
        $event->infinite             = $eventModel->isInfinite();
        $event->count                = $eventModel->count;
        $event->repeatsOnRule        = $eventModel->getRepeatsOnRule();
        $event->repeatsOnSelectDates = $eventModel->repeatsOnSelectDates();
        $event->rrule                = $eventModel->getRRuleRFCString();
        $event->rruleObject          = $eventModel->getRRuleObject();
        $event->readableRepeatRule   = $eventModel->getHumanReadableRepeatsString();
        $event->simplifiedRepeatRule = $eventModel->getSimplifiedRepeatRule();
        $event->calendar             = Calendar::createFromModel($eventModel->getCalendar());
        $event->exceptions           = $eventModel->getExceptionDateStrings();
        $event->selectDates          = $eventModel->getSelectDatesAsDates();
        $event->editable             = $eventModel->isEditable();

        if (null !== $occurrenceLoader) {
            $event->loadOccurrences($occurrenceLoader);
        }

        return $event;
    }

    /**
     * @param Event       $originalEvent
     * @param Carbon|null $targetDate
     *
     * @return Event
     */
    public static function cloneForDate(Event $originalEvent, Carbon $targetDate = null)
    {
        $startDate = $originalEvent->getStartDate()->copy();
        $endDate   = $originalEvent->getEndDate()->copy();

        $event = clone $originalEvent;

        if (null !== $targetDate && null !== $startDate) {
            $diffInSeconds = $startDate->diffInSeconds($endDate);

            $startDate->setDateTime(
                $targetDate->year,
                $targetDate->month,
                $targetDate->day,
                $startDate->hour,
                $startDate->minute,
                $startDate->second
            );
            $endDate = $startDate->copy();
            $endDate->addSeconds($diffInSeconds);
        }

        $event->startDate            = $startDate;
        $event->endDate              = $endDate;

        return $event;
    }

    /**
     * @return int
     */
    public function getAuthorId()
    {
        return $this->authorId;
    }

    /**
     * @return UserModel
     */
    public function getAuthor()
    {
        return $this->author;
    }

    /**
     * @return string
     */
    public function getSlug()
    {
        return $this->slug;
    }

    /**
     * @return string
     */
    public function getUrl()
    {
        return $this->url;
    }

    /**
     * @return boolean
     */
    public function isEnabled()
    {
        return $this->enabled;
    }

    /**
     * @return string
     */
    public function getStatus()
    {
        return $this->status;
    }

    /**
     * @return DateTime
     */
    public function getDateCreated()
    {
        return $this->dateCreated;
    }

    /**
     * @return DateTime
     */
    public function getPostDate()
    {
        return $this->dateCreated;
    }

    /**
     * @return Carbon
     */
    public function getStartDate()
    {
        return $this->startDate;
    }

    /**
     * @return Carbon
     */
    public function getEndDate()
    {
        return $this->endDate;
    }

    /**
     * @return EventDuration
     */
    public function getDuration()
    {
        if (null === $this->startDate || null === $this->endDate) {
            return new EventDuration(new \DateInterval('PT0S'));
        }

        $startDate = $this->startDate->copy();
        $endDate   = $this->endDate->copy();

        if ($this->isAllDay()) {
            $endDate->addSecond();
        }

        return new EventDuration($startDate->diff($endDate));
    }

    /**
     * @return boolean
     */
    public function isAllDay()
    {
        return (bool) $this->allDay;
    }

    /**
     * @return bool
     */
    public function isMultiDay()
    {
        return (bool) $this->multiDay;
    }

    /**
     * @return bool
     */
    public function isCurrentlyHappening()
    {
        static $currentDate;
        if (null === $currentDate) {
            $local       = new Carbon('now', \Craft\craft()->getTimeZone());
            $currentDate = new Carbon($local->format('Y-m-d H:i:s'), DateTime::UTC);
        }

        return $this->isHappeningOn($currentDate);
    }

    /**
     * @param string|Carbon $date
     *
     * @return bool
     */
    public function isHappeningOn($date)
    {
        if (!$date instanceof Carbon) {
            $date = new Carbon($date, DateTime::UTC);
        }

        return $date->between($this->getStartDate(), $this->getEndDate());
    }

    /**
     * @return bool
     */
    public function isRepeating()
    {
        return (bool) $this->repeating;
    }

    /**
     * @return int
     */
    public function getInterval()
    {
        return $this->interval;
    }

    /**
     * @return string
     */
    public function getFreq()
    {
        return $this->freq;
    }

    /**
     * @return array
     */
    public function getByMonth()
    {
        return $this->byMonth;
    }

    /**
     * @return array
     */
    public function getByYearDay()
    {
        return $this->byYearDay;
    }

    /**
     * @return array
     */
    public function getByMonthDay()
    {
        return $this->byMonthDay;
    }

    /**
     * @return array
     */
    public function getByDay()
    {
        return $this->byDay;
    }

    /**
     * @return int
     */
    public function getUntilType()
    {
        return $this->untilType;
    }

    /**
     * @return Carbon
     */
    public function getUntilDate()
    {
        return $this->untilDate;
    }

    /**
     * @return int
     */
    public function getCount()
    {
        return $this->count;
    }

    /**
     * @return int
     */
    public function getRepeatsOnRule()
    {
        return $this->repeatsOnRule;
    }

    /**
     * @return string
     */
    public function getRRule()
    {
        return $this->rrule;
    }

    /**
     * @return string
     */
    public function getReadableRepeatRule()
    {
        return $this->readableRepeatRule;
    }

    /**
     * @return string
     */
    public function getSimplifiedRepeatRule()
    {
        return $this->simplifiedRepeatRule;
    }

    /**
     * @return bool
     */
    public function isEditable()
    {
        return $this->editable;
    }

    /**
     * @return Calendar
     */
    public function getCalendar()
    {
        return $this->calendar;
    }

    /**
     * @return array|\string[]
     */
    public function getExceptions()
    {
        return $this->exceptions;
    }

    /**
     * @return array|\DateTime[]
     */
    public function getSelectDates()
    {
        return $this->selectDates;
    }

    /**
     * @return Event[]
     */
    public function getOccurrences()
    {
        return $this->occurrences;
    }

    /**
     * Returns an array of \DateTime objects for each recurrence
     *
     * @return array|\DateTime[]
     */
    public function getOccurrenceDates()
    {
        return $this->getOccurrenceDatesBetween();
    }

    /**
     * @param \DateTime|null $rangeStart
     * @param \DateTime|null $rangeEnd
     *
     * @return array|\DateTIme[]
     */
    public function getOccurrenceDatesBetween(\DateTime $rangeStart = null, \DateTime $rangeEnd = null)
    {
        $occurrences = array();

        if ($this->isRepeating()) {
            if ($this->repeatsOnSelectDates) {
                $selectDates = [];
                foreach ($this->selectDates as $date) {
                    if ($rangeStart && $rangeStart > $date) {
                        continue;
                    }

                    if ($rangeEnd && $rangeEnd < $date) {
                        break;
                    }

                    $selectDates[] = $date;
                }

                $occurrences = array_merge($occurrences, $selectDates);
            } else {
                $rrule = $this->rruleObject;
                if (null !== $rrule) {
                    if ($this->infinite) {
                        $rangeStart = $rangeStart ?: new Carbon('today', DateTime::UTC);
                        $rangeEnd = $rangeEnd ?: new Carbon('+6 months', DateTime::UTC);
                    }

                    $occurrences = array_merge($occurrences, $rrule->getOccurrencesBetween($rangeStart, $rangeEnd));
                }
            }
        }

        DateHelper::sortArrayOfDates($occurrences);

        return $occurrences;
    }

    /**
     * @return int
     */
    public function getOccurrenceCount()
    {
        return count($this->getOccurrences());
    }

    /**
     * Converts the object to an stdClass
     * With values valid for fullcalendar.io library
     *
     * @return \stdClass
     */
    public function toSimpleObject()
    {
        $object   = new \stdClass();
        $calendar = new \stdClass();

        $startDate = $this->startDate;
        $endDate   = $this->endDate;

        // This is a hack required by the fullcalendar.io lib
        // Since their end-dates are *exclusive*
        // Without this a 3 day all-day event would render in 2 days
        if ($this->isAllDay()) {
            $endDate = $endDate->copy()->addDay();
        }

        $calendar->id     = $this->getCalendar()->getId();
        $calendar->name   = $this->getCalendar()->getName();
        $calendar->handle = $this->getCalendar()->getHandle();

        $object->id                 = $this->id;
        $object->title              = $this->title;
        $object->slug               = $this->slug;
        $object->url                = $this->url;
        $object->start              = $startDate->toAtomString();
        $object->end                = $endDate->toAtomString();
        $object->allDay             = $this->isAllDay();
        $object->multiDay           = $this->isMultiDay();
        $object->repeats            = $this->isRepeating();
        $object->readableRepeatRule = $this->getReadableRepeatRule();
        $object->calendar           = $calendar;
        $object->editable           = $this->isEditable();
        $object->enabled            = (bool) $this->isEnabled();
        $object->backgroundColor    = $this->getCalendar()->getColor();
        $object->borderColor        = $this->getCalendar()->getDarkerColor();
        $object->textColor          = $this->getCalendar()->getContrastColor();

        foreach ($this->content->getAttributes() as $key => $value) {
            if (in_array($key, array('id', 'elementId', 'title'), true)) {
                continue;
            }

            // Skip fields that are not part of the calendar's field layout
            if (!in_array($key, $this->calendar->getFieldLayoutFieldHandles(), true)) {
                continue;
            }

            if (!isset($object->{$key})) {
                $object->{$key} = $value;
            }
        }

        return $object;
    }

    /**
     * @param array|OccurrenceLoader $occurrenceLoaderConfiguration
     *
     * @return Event
     */
    public function loadOccurrences($occurrenceLoaderConfiguration)
    {
        if ($occurrenceLoaderConfiguration instanceof OccurrenceLoader) {
            $occurrenceLoader = $occurrenceLoaderConfiguration;
        } else {
            $occurrenceLoader = OccurrenceLoader::create($occurrenceLoaderConfiguration);
        }

        if ($occurrenceLoader->getLoadOccurrences()) {
            $iterator    = 0;
            $occurrences = $this->getOccurrenceDatesBetween(
                $occurrenceLoader->getRangeStart(),
                $occurrenceLoader->getRangeEnd()
            );

            $storedOccurrenceList = array();
            foreach ($occurrences as $date) {
                $date = new Carbon($date->format('Y-m-d'), DateTime::UTC);
                if (in_array($date->toDateString(), $this->getExceptions(), true)) {
                    continue;
                }

                $storedOccurrenceList[] = self::cloneForDate($this, $date);
                $iterator++;

                if ($occurrenceLoader->getLimit() && $iterator >= $occurrenceLoader->getLimit()) {
                    break;
                }
            }

            $this->occurrences = $storedOccurrenceList;
        }

        return $this;
    }

    /**
     * Compare this event to another event's MultiDay property
     * Returns: -1    if this is multi-day and the other isn't
     *          1     if this is not multi-day, but the other is
     *          true  if both are multi-day
     *          false if both aren't multi-day
     *
     * @param Event $event
     *
     * @return int|bool
     */
    public function compareMultiDay(Event $event)
    {
        if ($this->isMultiDay() && !$event->isMultiDay()) {
            return -1;
        }

        if (!$this->isMultiDay() && $event->isMultiDay()) {
            return 1;
        }

        if ($this->isMultiDay() && $event->isMultiDay()) {
            return true;
        }

        return false;
    }

    /**
     * Compare this event to another event's MultiDay property
     * Returns: -1    if this is all-day and the other isn't
     *          1     if this is not all-day, but the other is
     *          true  if both are all-day
     *          false if both aren't all-day
     *
     * @param Event $event
     *
     * @return int|bool
     */
    public function compareAllDay(Event $event)
    {
        if ($this->isAllDay() && !$event->isAllDay()) {
            return -1;
        }

        if (!$this->isAllDay() && $event->isAllDay()) {
            return 1;
        }

        if ($this->isAllDay() && $event->isAllDay()) {
            return true;
        }

        return false;
    }

    /**
     * @param Event $event
     *
     * @return int
     */
    public function compareStartDates(Event $event)
    {
        return DateHelper::compareCarbons($this->getStartDate(), $event->getStartDate());
    }

    /**
     * @param Event $event
     *
     * @return int
     */
    public function compareEndDates(Event $event)
    {
        return DateHelper::compareCarbons($this->getEndDate(), $event->getEndDate());
    }

    /**
     * Get the diff in days between two events
     *
     * @param Event $event
     *
     * @return int
     */
    public function diffInDays(Event $event)
    {
        return DateHelper::carbonDiffInDays($this->getStartDate(), $event->getStartDate());
    }
}
