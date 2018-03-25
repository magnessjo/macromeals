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

use Craft\Calendar_CalendarModel;
use Craft\FieldLayoutFieldModel;

class Calendar
{
    /** @var array */
    private static $fieldLayoutHandles;

    /** @var int */
    private $id;

    /** @var string */
    private $name;

    /** @var string */
    private $handle;

    /** @var string */
    private $color;

    /** @var string */
    private $lighterColor;

    /** @var string */
    private $darkerColor;

    /** @var string */
    private $contrastColor;

    /** @var string */
    private $descriptionFieldHandle;

    /** @var string */
    private $locationFieldHandle;

    /** @var string */
    private $icsHash;

    /** @var string */
    private $icsUrl;

    /**
     * @param Calendar_CalendarModel $calendarModel
     *
     * @return Calendar
     */
    public static function createFromModel(Calendar_CalendarModel $calendarModel = null)
    {
        $calendar = new Calendar();
        if (null === $calendarModel) {
            return $calendar;
        }

        $calendar->id                     = $calendarModel->id;
        $calendar->name                   = $calendarModel->name;
        $calendar->handle                 = $calendarModel->handle;
        $calendar->color                  = $calendarModel->color;
        $calendar->lighterColor           = $calendarModel->getLighterColor();
        $calendar->darkerColor            = $calendarModel->getDarkerColor();
        $calendar->contrastColor          = $calendarModel->getContrastColor();
        $calendar->descriptionFieldHandle = $calendarModel->descriptionFieldHandle;
        $calendar->locationFieldHandle    = $calendarModel->locationFieldHandle;
        $calendar->icsHash                = $calendarModel->icsHash;
        $calendar->icsUrl                 = $calendarModel->getIcsUrl();

        if (!isset(self::$fieldLayoutHandles[$calendar->id])) {
            /** @var FieldLayoutFieldModel[] $fields */
            $fields = \Craft\craft()->fields->getLayoutFieldsById($calendarModel->fieldLayoutId);

            $handles = array();
            foreach ($fields as $field) {
                $handles[] = $field->getField()->handle;
            }

            self::$fieldLayoutHandles[$calendar->id] = $handles;
        }

        return $calendar;
    }

    /**
     * @return array
     */
    public function getFieldLayoutFieldHandles()
    {
        return self::$fieldLayoutHandles[$this->id];
    }

    /**
     * @return int
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * @return string
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * @return string
     */
    public function getHandle()
    {
        return $this->handle;
    }

    /**
     * @return string
     */
    public function getColor()
    {
        return $this->color;
    }

    /**
     * @return string
     */
    public function getLighterColor()
    {
        return $this->lighterColor;
    }

    /**
     * @return string
     */
    public function getDarkerColor()
    {
        return $this->darkerColor;
    }

    /**
     * @return string
     */
    public function getContrastColor()
    {
        return $this->contrastColor;
    }

    /**
     * @return string
     */
    public function getDescriptionFieldHandle()
    {
        return $this->descriptionFieldHandle;
    }

    /**
     * @return string
     */
    public function getLocationFieldHandle()
    {
        return $this->locationFieldHandle;
    }

    /**
     * @return string
     */
    public function getIcsHash()
    {
        return $this->icsHash;
    }

    /**
     * @return string
     */
    public function getIcsUrl()
    {
        return $this->icsUrl;
    }
}
