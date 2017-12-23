<?php
namespace Craft;

class SproutSeo_ChangePermanentMethodElementAction extends BaseElementAction
{
	/**
	 * @inheritDoc IComponentType::getName()
	 *
	 * @return string
	 */
	public function getName()
	{
		return Craft::t('Update Method to 301');
	}

	/**
	 * @inheritDoc IElementAction::isDestructive()
	 *
	 * @return bool
	 */
	public function isDestructive()
	{
		return false;
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
		$elementIds = $criteria->ids();

		$response = false;

		// Call updateMethods service
		$response = sproutSeo()->redirects->updateMethods($elementIds, SproutSeo_RedirectMethods::Permanent);

		$message = sproutSeo()->redirects->getMethodUpdateResponse($response);

		$this->setMessage($message);

		return $response;
	}

	/**
	 * @inheritDoc BaseElementAction::defineParams()
	 *
	 * @return array
	 */
	protected function defineParams()
	{
		return array();
	}
}
