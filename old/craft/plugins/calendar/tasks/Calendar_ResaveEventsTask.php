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

class Calendar_ResaveEventsTask extends BaseTask
{
    private $elementType;
    private $localeId;
    private $eventIds;

    /**
     * @return string
     */
    public function getDescription()
    {
        $elementType = craft()->elements->getElementType($this->getSettings()->elementType);

        return Craft::t(
            'Resaving {type}',
            array(
                'type' => StringHelper::toLowerCase($elementType->getName()),
            )
        );
    }

    /**
     * @return int
     */
    public function getTotalSteps()
    {
        $settings = $this->getSettings();

        // Let's save ourselves some trouble and just clear all the caches for this element type
        craft()->templateCache->deleteCachesByElementType($settings->elementType);

        // Now find the affected element IDs
        $criteria         = craft()->elements->getCriteria($settings->elementType, $settings->criteria);
        $criteria->offset = null;
        $criteria->limit  = null;
        $criteria->order  = null;

        $this->elementType = $criteria->getElementType()->getClassHandle();
        $this->localeId    = $criteria->locale;
        $this->eventIds    = $criteria->ids();

        return count($this->eventIds);
    }

    /**
     * @inheritDoc ITask::runStep()
     *
     * @param int $step
     *
     * @return bool
     */
    public function runStep($step)
    {
        try {
            $event = craft()->elements->getElementById(
                $this->eventIds[$step],
                $this->elementType,
                $this->localeId
            );

            if (!$event) {
                return true;
            }

            if ($event instanceof Calendar_EventModel) {
                $calendar = $event->getCalendar();

                if (!$calendar->hasTitleField) {
                    $event->getContent()->title = craft()->templates->renderObjectTemplate(
                        $calendar->titleFormat,
                        $event
                    );
                }
            }

            if (craft()->elements->saveElement($event, false)) {
                return true;
            }

            $error = sprintf(
                'Encountered the following validation errors when trying to save %s element "%s" with the ID "%d":',
                strtolower($event->getElementType()),
                $event->title,
                $event->id
            );

            foreach ($event->getAllErrors() as $attributeError) {
                $error .= "\n - {$attributeError}";
            }

            return $error;
        } catch (\Exception $e) {
            return sprintf(
                'An exception was thrown while trying to save the %s with the ID “%d”: %s',
                $this->elementType,
                $this->eventIds[$step],
                $e->getMessage()
            );
        }
    }

    /**
     * @inheritDoc BaseSavableComponentType::defineSettings()
     * @return array
     */
    protected function defineSettings()
    {
        return array(
            'elementType' => AttributeType::String,
            'criteria'    => AttributeType::Mixed,
        );
    }
}
