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

namespace Calendar\Library\Attributes;

class CalendarAttributes extends AbstractAttributes
{
    protected $validAttributes = array(
        'id',
        'name',
        'handle',
        'color',
    );
}
