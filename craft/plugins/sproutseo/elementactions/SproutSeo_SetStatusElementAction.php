<?php
namespace Craft;

class SproutSeo_SetStatusElementAction extends BaseElementAction
{
	// Public Methods
	// =========================================================================

	/**
	 * @inheritDoc IElementAction::getTriggerHtml()
	 *
	 * @return string|null
	 */
	public function getTriggerHtml()
	{
		return craft()->templates->render('sproutseo/_components/elementactions/setstatus');
	}

	/**
	 * @inheritDoc IElementAction::performAction()
	 *
	 * @param ElementCriteriaModel $criteria
	 *
	 * @return bool
	 */
	public function performAction(ElementCriteriaModel $criteria)
	{
		$status = $this->getParams()->status;

		// False by default
		$enable = 0;

		switch ($status)
		{
			case SproutSeo_RedirectStatuses::ON:
				$enable = '1';
				break;
			case SproutSeo_RedirectStatuses::OFF:
				$enable = '0';
				break;
		}

		$elementIds = $criteria->ids();

		foreach ($elementIds as $key => $redirectId)
		{
			$redirect = sproutSeo()->redirects->getRedirectById($redirectId);

			if ($redirect->method == SproutSeo_RedirectMethods::PageNotFound)
			{
				$this->setMessage(Craft::t('Unable to enabled 404 method'));
				return false;
			}
		}

		// Update their statuses
		craft()->db->createCommand()->update(
			'elements',
			array('enabled' => $enable),
			array('in', 'id', $elementIds)
		);

		if ($status == SproutSeo_RedirectStatuses::ON)
		{
			// Enable their locale as well
			craft()->db->createCommand()->update(
				'elements_i18n',
				array('enabled' => $enable),
				array('and', array('in', 'elementId', $elementIds), 'locale = :locale'),
				array(':locale' => $criteria->locale)
			);
		}

		// Clear their template caches
		craft()->templateCache->deleteCachesByElementId($elementIds);

		// Fire an 'onSetStatus' event
		$this->onSetStatus(new Event($this, array(
			'criteria'   => $criteria,
			'elementIds' => $elementIds,
			'status'     => $status,
		)));

		$this->setMessage(Craft::t('Statuses updated.'));

		return true;
	}

	// Events
	// -------------------------------------------------------------------------

	/**
	 * Fires an 'onSetStatus' event.
	 *
	 * @param Event $event
	 *
	 * @return null
	 */
	public function onSetStatus(Event $event)
	{
		$this->raiseEvent('onSetStatus', $event);
	}

	// Protected Methods
	// =========================================================================

	/**
	 * @inheritDoc BaseElementAction::defineParams()
	 *
	 * @return array
	 */
	protected function defineParams()
	{
		return array(
			'status' => array(
				AttributeType::Enum,
				'values'   => array(
					SproutSeo_RedirectStatuses::ON,
					SproutSeo_RedirectStatuses::OFF
				),
				'required' => true)
		);
	}
}
