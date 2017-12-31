<?php

namespace Calendar\Library\CodePack\Components;

interface ComponentInterface
{
    /**
     * ComponentInterface constructor.
     *
     * @param string $location
     */
    public function __construct($location);

    /**
     * Calls the installation of this component
     *
     * @param string $prefix
     */
    public function install($prefix = null);
}
