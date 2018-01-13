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

use Twig_Compiler;

class RequireEventEditPermissions_Node extends \Twig_Node
{
    public function compile(Twig_Compiler $compiler)
    {
        $compiler
            ->addDebugInfo($this)
            ->write('\Craft\craft()->calendar_events->requireEventEditPermissions(')
            ->subcompile($this->getNode('event'))
            ->write(");\n")
        ;
    }
}
