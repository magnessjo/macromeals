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

class Calendar_EventFieldType extends BaseElementFieldType
{
    /** @var string $elementType */
    protected $elementType = 'Calendar_Event';

    /**
     * Returns the label for the "Add" button.
     *
     * @access protected
     * @return string
     */
    protected function getAddButtonLabel()
    {
        return Craft::t('Add an event');
    }
}
