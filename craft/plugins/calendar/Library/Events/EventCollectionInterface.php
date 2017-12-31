<?php

namespace Calendar\Library\Events;

use Calendar\Library\Carbon;

interface EventCollectionInterface
{
    /**
     * @return Carbon
     */
    public function getDate();

    /**
     * @return Carbon
     */
    public function getStartDate();

    /**
     * @return Carbon
     */
    public function getEndDate();

    /**
     * @return Event[]
     */
    public function getEvents();
}
