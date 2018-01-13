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

class Calendar_TwigExtension extends \Twig_Extension
{
    /**
     * @deprecated since 1.26 (to be removed in 2.0), not used anymore internally
     */
    public function getName()
    {
        return get_class($this);
    }

    /**
     * @return \Twig_TokenParser[]
     */
    public function getTokenParsers()
    {
        return array(
            new RequireEventEditPermissions_TokenParser(),
        );
    }

}
