<?php

namespace Craft;

/**
 * SproutSeo - Redirect element type
 */
class SproutSeo_RedirectElementType extends BaseElementType
{
	/**
	 * Returns the element type name.
	 *
	 * @return string
	 */
	public function getName()
	{
		return Craft::t('Sprout SEO Redirects');
	}

	/**
	 * Returns whether this element type has content.
	 *
	 * @return bool
	 */
	public function hasContent()
	{
		return false;
	}

	/**
	 * @inheritDoc IElementType::hasStatuses()
	 *
	 * @return bool
	 */
	public function hasStatuses()
	{
		return true;
	}

	/**
	 * Returns whether this element type has titles.
	 *
	 * @return bool
	 */
	public function hasTitles()
	{
		return false;
	}

	/**
	 * @return bool
	 */
	public function isLocalized()
	{
		return false;
	}

	/**
	 * Returns the attributes that can be shown/sorted by in table views.
	 *
	 * @param string|null $source
	 *
	 * @return array
	 */
	public function defineTableAttributes($source = null)
	{
		return array(
			'oldUrl' => Craft::t('Old Url'),
			'newUrl' => Craft::t('New Url'),
			'method' => Craft::t('Method'),
			'count'  => Craft::t('Count'),
			'test'   => Craft::t('Test')
		);
	}

	/**
	 * Returns the attributes that can be sorted by in table views.
	 *
	 * @param string|null $source
	 *
	 * @return array
	 */
	public function defineSortableAttributes($source = null)
	{
		return array(
			'oldUrl' => Craft::t('Old Url'),
			'newUrl' => Craft::t('New Url'),
			'method' => Craft::t('Method'),
			'count'  => Craft::t('Count'),
		);
	}

	/**
	 * Returns this element type's sources.
	 *
	 * @param string|null $context
	 *
	 * @return array|false
	 */
	public function getSources($context = null)
	{
		$sources = array(
			'*' => array(
				'label'             => Craft::t('All redirects'),
				'structureId'       => sproutSeo()->redirects->getStructureId(),
				'structureEditable' => true
			)
		);

		$methods = SproutSeo_RedirectMethods::getConstants();

		$plugin      = craft()->plugins->getPlugin('sproutseo');
		$seoSettings = $plugin->getSettings();

		foreach ($methods as $code => $method)
		{
			if ($method == 404)
			{
				if (!$seoSettings->enable404RedirectLog)
				{
					continue;
				}
			}

			$key   = 'method:' . $method;
			$label = $method . ' - ' . preg_replace('/([a-z])([A-Z])/', '$1 $2', $code);

			$sources[$key] = array(
				'label'             => $label,
				'criteria'          => array('method' => $method),
				'structureId'       => sproutSeo()->redirects->getStructureId(),
				'structureEditable' => true
			);
		}

		return $sources;
	}

	/**
	 * @inheritDoc IElementType::getAvailableActions()
	 *
	 * @param string|null $source
	 *
	 * @return array|null
	 */
	public function getAvailableActions($source = null)
	{
		$deleteAction = craft()->elements->getAction('Delete');

		$deleteAction->setParams(
			array(
				'confirmationMessage' => Craft::t('Are you sure you want to delete the selected redirects?'),
				'successMessage'      => Craft::t('Redirects deleted.'),
			)
		);

		$editAction = craft()->elements->getAction('Edit');
		$editAction->setParams(array(
			'label' => Craft::t('Edit Redirect'),
		));

		$changePermanentMethod = craft()->elements->getAction('SproutSeo_ChangePermanentMethod');
		$changeTemporaryMethod = craft()->elements->getAction('SproutSeo_ChangeTemporaryMethod');

		$setStatusAction = craft()->elements->getAction('SproutSeo_SetStatus');

		return array($deleteAction, $editAction, $changePermanentMethod, $changeTemporaryMethod, $setStatusAction);
	}

	/**
	 * Defines any custom element criteria attributes for this element type.
	 *
	 * @return array
	 */
	public function defineCriteriaAttributes()
	{
		return array(
			'id'     => AttributeType::Number,
			'oldUrl' => AttributeType::String,
			'newUrl' => AttributeType::String,
			'method' => AttributeType::Number
		);
	}

	public function defineSearchableAttributes()
	{
		return array('oldUrl', 'newUrl', 'method', 'regex');
	}

	/**
	 * @param BaseElementModel $element
	 * @param string           $attribute
	 *
	 * @return string
	 */
	public function getTableAttributeHtml(BaseElementModel $element, $attribute)
	{
		switch ($attribute)
		{
			case 'test':
				// Send link for testing
				$link = "<a href='{$element->oldUrl}' target='_blank' data-icon='world'></a>";

				if ($element->regex)
				{
					$link = " - ";
				}

				return $link;

			default:
				return parent::getTableAttributeHtml($element, $attribute);
				break;
		}
	}

	/**
	 * Modifies an element query targeting elements of this type.
	 *
	 * @param DbCommand            $query
	 * @param ElementCriteriaModel $criteria
	 *
	 * @return mixed
	 */
	public function modifyElementsQuery(DbCommand $query, ElementCriteriaModel $criteria)
	{
		$structureId = sproutSeo()->redirects->getStructureId();

		$query
			->addSelect('redirects.oldUrl, redirects.newUrl, redirects.method, redirects.id, redirects.regex, redirects.count')
			->join('sproutseo_redirects redirects', 'redirects.id = elements.id')
			->leftJoin('structures structures', 'structures.id = :structureId', array(':structureId' => $structureId))
			->leftJoin('structureelements structureelements', array('and', 'structureelements.structureId = structures.id', 'structureelements.elementId = redirects.id'));

		if ($criteria->id)
		{
			$query->andWhere(DbHelper::parseParam('redirects.id', $criteria->id, $query->params));
		}
		if ($criteria->method)
		{
			$query->andWhere(DbHelper::parseParam('redirects.method', $criteria->method, $query->params));
		}
		if ($criteria->oldUrl)
		{
			$query->andWhere(DbHelper::parseParam('redirects.oldUrl', $criteria->oldUrl, $query->params));
		}
		if ($criteria->newUrl)
		{
			$query->andWhere(DbHelper::parseParam('redirects.newUrl', $criteria->newUrl, $query->params));
		}
	}

	/**
	 * Populates an element model based on a query result.
	 *
	 * @param array $row
	 *
	 * @return array
	 */
	public function populateElementModel($row)
	{
		return SproutSeo_RedirectModel::populateModel($row);
	}

	/**
	 * Returns the HTML for an editor HUD for the given element.
	 *
	 * @param BaseElementModel $element
	 *
	 * @return string
	 */
	public function getEditorHtml(BaseElementModel $element)
	{
		$methodOptions = sproutSeo()->redirects->getMethods();
		// get template
		$html = craft()->templates->render('sproutseo/redirects/_editor', array(
			'redirect'      => $element,
			'methodOptions' => $methodOptions
		));

		// Everything else
		$html .= parent::getEditorHtml($element);

		return $html;
	}

	/**
	 * @inheritdoc BaseElementType::saveElement()
	 *
	 * @return bool
	 */
	public function saveElement(BaseElementModel $element, $params)
	{
		// Route this through RedirectsService::saveRedirect() so the proper redirect events get fired.
		$redirect         = new SproutSeo_RedirectModel();
		$redirect->id     = $element->id;
		$redirect->oldUrl = $params['oldUrl'];
		$redirect->newUrl = $params['newUrl'];
		$redirect->method = $params['method'];
		$redirect->regex  = $params['regex'];

		// send response
		return sproutSeo()->redirects->saveRedirect($redirect);;
	}
}
