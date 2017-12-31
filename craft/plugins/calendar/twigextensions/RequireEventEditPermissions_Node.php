<?php

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
