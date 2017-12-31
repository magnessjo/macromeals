<?php

namespace Craft;

use Calendar\Library\ColorHelper;

/**
 * @property int    $id
 * @property string $name
 * @property string $handle
 * @property string $description
 * @property string $color
 * @property bool   $hasUrls
 * @property string $eventTemplate
 * @property int    $fieldLayoutId
 * @property string $titleFormat
 * @property string $titleLabel
 * @property string $hasTitleField
 * @property string $descriptionFieldHandle
 * @property string $locationFieldHandle
 * @property string $icsHash
 */
class Calendar_CalendarModel extends BaseModel
{
    const COLOR_LIGHTEN_MULTIPLIER = 0.2;
    const COLOR_DARKEN_MULTIPLIER  = -0.2;

    /** @var Calendar_CalendarLocaleModel */
    private $localeCache;

    /**
     * @return Calendar_CalendarModel
     */
    public static function create()
    {
        $model             = new Calendar_CalendarModel();
        $model->color      = ColorHelper::randomColor();
        $model->titleLabel = 'Title';

        return $model;
    }

    /**
     * Returns the calendar $name property
     *
     * @return string
     */
    public function __toString()
    {
        return $this->name;
    }

    /**
     * Regenerates the ICS Hash, sets it and returns it
     */
    public function regenerateIcsHash()
    {
        $hash = uniqid(sha1($this->id), true);

        $this->icsHash = $hash;

        return $hash;
    }

    /**
     * @return string - hex
     */
    public function getLighterColor()
    {
        return ColorHelper::lightenDarkenColour($this->color, self::COLOR_LIGHTEN_MULTIPLIER);
    }

    /**
     * @return string
     */
    public function getDarkerColor()
    {
        return ColorHelper::lightenDarkenColour($this->color, self::COLOR_DARKEN_MULTIPLIER);
    }

    /**
     * @return string - "black" or "white"
     */
    public function getContrastColor()
    {
        return ColorHelper::getContrastYIQ($this->color);
    }

    /**
     * @return null|string
     */
    public function getIcsUrl()
    {
        if (null === $this->icsHash) {
            return null;
        }

        static $urlBase;
        if (null === $urlBase) {
            $cpTrigger = craft()->config->get('cpTrigger');

            $urlBase = UrlHelper::getActionUrl('calendar/calendarsApi/ics');
            $urlBase = str_replace($cpTrigger . '/', '', $urlBase);
        }


        return $urlBase . '/' . $this->icsHash . '.ics';
    }

    /**
     * @return array
     */
    public function getDescriptionFieldHandles()
    {
        $fieldList = array(Craft::t('None'));
        foreach ($this->getFieldLayout()->getFields() as $fieldModel) {
            $field = $fieldModel->getField();

            $fieldList[$field->handle] = $field->name;
        }

        return $fieldList;
    }

    /**
     * @return array
     */
    public function getLocationFieldHandles()
    {
        $fieldList = array(Craft::t('None'));
        foreach ($this->getFieldLayout()->getFields() as $fieldModel) {
            $field = $fieldModel->getField();

            $fieldList[$field->handle] = $field->name;
        }

        return $fieldList;
    }

    /**
     * @return null|string
     */
    public function getEventUrlFormat()
    {
        $locales = $this->getLocales();

        if (!$this->hasUrls) {
            return null;
        }

        if (isset($locales[craft()->getLocale()->id])) {
            return $locales[craft()->getLocale()->id]->eventUrlFormat;
        }

        return null;
    }

    /**
     * Returns the calendar's locale models
     *
     * @return Calendar_CalendarLocaleModel[]
     */
    public function getLocales()
    {
        if (null === $this->localeCache) {
            $this->localeCache = array();
            if ($this->id) {
                $this->localeCache = calendar()->calendars->getCalendarLocales($this->id, 'locale');
            }
        }

        return $this->localeCache;
    }

    /**
     * @param Calendar_CalendarLocaleModel[] $locales
     *
     * @return $this
     */
    public function setLocales(array $locales)
    {
        $this->localeCache = $locales;

        return $this;
    }

    /**
     * @return array
     */
    public function behaviors()
    {
        return array(
            'fieldLayout' => new FieldLayoutBehavior(CalendarPlugin::FIELD_LAYOUT_TYPE),
        );
    }

    /**
     * @return array
     */
    protected function defineAttributes()
    {
        return array(
            'id'                     => AttributeType::Number,
            'name'                   => AttributeType::String,
            'handle'                 => AttributeType::String,
            'description'            => AttributeType::String,
            'color'                  => AttributeType::String,
            'hasUrls'                => AttributeType::Bool,
            'eventTemplate'          => AttributeType::String,
            'fieldLayoutId'          => AttributeType::Number,
            'titleFormat'            => AttributeType::String,
            'titleLabel'             => array(AttributeType::String, 'default' => 'Label'),
            'hasTitleField'          => array(AttributeType::Bool, 'default' => true),
            'descriptionFieldHandle' => AttributeType::String,
            'locationFieldHandle'    => AttributeType::String,
            'icsHash'                => AttributeType::String,
        );
    }
}
