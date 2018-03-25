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

namespace Library\Events;

use Craft\ContentModel;
use Craft\Craft;
use Craft\Exception;
use Craft\FieldModel;
use Craft\StringHelper;

class TinyBaseModel
{
    /** @var int */
    protected $id;

    /** @var string */
    protected $title;

    /** @var string */
    protected $locale;

    /** @var ContentModel */
    protected $content;

    private $_fieldsByHandle;
    private $_preppedContent;

    /**
     * @param string $key
     *
     * @return mixed
     * @throws Exception
     */
    public function __get($key)
    {
        $getter = 'get' . StringHelper::toPascalCase($key);
        if (method_exists($this, $getter)) {
            return call_user_func(array($this, $getter));
        }

        $getter = 'is' . StringHelper::toPascalCase($key);
        if (method_exists($this, $getter)) {
            return call_user_func(array($this, $getter));
        }

        if ($this->getFieldByHandle($key)) {
            return $this->getFieldValue($key);
        }

        return $this->content->getAttribute($key);
    }

    /**
     * @param string $name
     *
     * @return bool
     */
    public function __isset($name)
    {
        if (property_exists($this, $name)) {
            return true;
        }

        return $this->content->__isset($name);
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
    public function getLocale()
    {
        return $this->locale;
    }

    /**
     * @return string
     */
    public function getTitle()
    {
        return $this->title;
    }

    /**
     * Returns the prepped content for a given field.
     *
     * @param string $fieldHandle
     *
     * @throws Exception
     * @return mixed
     */
    public function getFieldValue($fieldHandle)
    {
        if (!isset($this->_preppedContent) || !array_key_exists($fieldHandle, $this->_preppedContent)) {
            $field = $this->getFieldByHandle($fieldHandle);

            if (!$field) {
                throw new Exception(
                    Craft::t('No field exists with the handle “{handle}”', array('handle' => $fieldHandle))
                );
            }

            $content = $this->content;

            if (isset($content->$fieldHandle)) {
                $value = $content->$fieldHandle;
            } else {
                $value = null;
            }

            // Give the field type a chance to prep the value for use
            $fieldType = $field->getFieldType();

            if ($fieldType) {
                $fieldType->element = $this;
                $value              = $fieldType->prepValue($value);
            }

            $this->_preppedContent[$fieldHandle] = $value;
        }

        return $this->_preppedContent[$fieldHandle];
    }

    /**
     * Returns the field with a given handle.
     *
     * @param string $handle
     *
     * @return FieldModel|null
     */
    protected function getFieldByHandle($handle)
    {
        if (!isset($this->_fieldsByHandle) || !array_key_exists($handle, $this->_fieldsByHandle)) {
            $contentService = \Craft\craft()->content;

            $originalFieldContext         = $contentService->fieldContext;
            $contentService->fieldContext = $this->getFieldContext();

            $this->_fieldsByHandle[$handle] = \Craft\craft()->fields->getFieldByHandle($handle);

            $contentService->fieldContext = $originalFieldContext;
        }

        return $this->_fieldsByHandle[$handle];
    }

    /**
     * Returns the field context this element's content uses.
     *
     * @return string
     */
    private function getFieldContext()
    {
        return \Craft\craft()->content->fieldContext;
    }
}
