<?php
namespace Craft;

class SproutSeo_OptimizeService extends BaseApplicationComponent
{
	public $rawMetadata = false;

	/**
	 * @var array
	 */
	protected $schemas;

	/**
	 * Sprout SEO Globals data
	 *
	 * @var SproutSeo_GlobalsModel $globals
	 */
	public $globals;

	/**
	 * The active Section integration with Section and Element info
	 *
	 * $urlEnabledSection->element will have the element that matches
	 * the matchedElementVariable from the $context
	 *
	 * @var SproutSeo_UrlEnabledSectionModel $urlEnabledSection
	 */
	public $urlEnabledSection;

	/**
	 * @var SproutSeo_MetadataModel $prioritizedMetadataModel
	 */
	public $prioritizedMetadataModel;

	/**
	 * @var SproutSeo_MetadataModel $codeMetadata
	 */
	public $codeMetadata = array();

	/**
	 * @var
	 */
	public $codeSection;

	public function init()
	{
		$schemaIntegrations = craft()->plugins->call('registerSproutSeoSchemas');

		foreach ($schemaIntegrations as $plugin => $schemas)
		{
			/**
			 * @var SproutSeoBaseSchema $map
			 */
			foreach ($schemas as $schema)
			{
				$this->schemas[$schema->getUniqueKey()] = $schema;
			}
		}
	}

	/**
	 * @return array
	 */
	public function getSchemas()
	{
		return $this->schemas;
	}

	/**
	 * Returns a list of available schema maps for display in a Main Entity select field
	 *
	 * @return array
	 */
	public function getSchemaOptions()
	{
		$options = array();

		foreach ($this->schemas as $uniqueKey => $instance)
		{
			$options[] = array(
				'value' => $uniqueKey,
				'label' => $instance->getName()
			);
		}

		return $options;
	}

	/**
	 * Returns a schema map instance (based on $uniqueKey) or $default
	 *
	 * @param string $uniqueKey
	 * @param null   $default
	 *
	 * @return mixed|null
	 */
	public function getSchemaByUniqueKey($uniqueKey, $default = null)
	{
		return array_key_exists($uniqueKey, $this->schemas) ? $this->schemas[$uniqueKey] : $default;
	}

	/**
	 * Add values to the master $this->codeMetadata array
	 *
	 * @param $meta
	 */
	public function updateMeta($meta)
	{
		if (count($meta))
		{
			foreach ($meta as $key => $value)
			{
				if ($key == 'section' OR $key == 'default')
				{
					if ($key == 'default')
					{
						craft()->deprecator->log('meta default key deprecated', 'craft.sproutSeo.meta `default` key has been deprecated. Use `section` key instead: {% do craft.sproutSeo.meta( section: "' . $value . '"") %}');
					}

					$this->codeSection = $value;
				}
				else
				{
					$this->codeMetadata[$key] = $value;
				}
			}
		}
	}

	/**
	 * Get all metadata (Meta Tags and Structured Data) for the page
	 *
	 * @param $context
	 *
	 * @return \Twig_Markup
	 */
	public function getMetadata(&$context)
	{
		$output   = null;
		$settings = craft()->plugins->getPlugin('sproutseo')->getSettings();

		$this->globals                  = sproutSeo()->globalMetadata->getGlobalMetadata();
		$this->urlEnabledSection        = sproutSeo()->sectionMetadata->getUrlEnabledSectionsViaContext($context);
		$this->prioritizedMetadataModel = $this->getPrioritizedMetadataModel();

		$metadata = array(
			'globals' => $this->globals,
			'meta'    => $this->prioritizedMetadataModel->getMetaTagData(),
			'schema'  => $this->getStructuredData()
		);

		if ($this->rawMetadata == true)
		{
			return $metadata;
		}

		// Output metadata
		if ($settings->enableMetadataRendering)
		{
			$output = $this->renderMetadata($metadata);
		}

		// Add metadata variable to Twig context
		if ($settings->metadataVariable)
		{
			$context[$settings->metadataVariable] = $metadata;
		}

		return $output;
	}

	/**
	 * Prioritize our meta data
	 * ------------------------------------------------------------
	 *
	 * Loop through and select the highest ranking value for each attribute in our SproutSeo_MetadataModel
	 *
	 * 1) Code Metadata
	 * 2) Element Metadata
	 * 3) Section Metadata
	 * 4) Global Metadata
	 * 5) Blank
	 *
	 * @return SproutSeo_MetadataModel
	 */
	public function getPrioritizedMetadataModel()
	{
		$metaLevels = SproutSeo_MetadataLevels::getConstants();

		$prioritizedMetadataLevels = array();

		foreach ($metaLevels as $key => $metaLevel)
		{
			$prioritizedMetadataLevels[$metaLevel] = null;
		}

		$prioritizedMetadataModel = new SproutSeo_MetadataModel();

		$schemaTypeId         = null;
		$schemaOverrideTypeId = null;

		foreach ($prioritizedMetadataLevels as $level => $model)
		{
			$metadataModel = new SproutSeo_MetadataModel();
			$codeMetadata  = $this->getCodeMetadata($level);

			// Assume our canonical URL is the current URL unless there is a codeOverride
			if ($level == SproutSeo_MetadataLevels::CodeMetadata)
			{
				$prioritizedMetadataModel->canonical  = SproutSeoOptimizeHelper::prepareCanonical($prioritizedMetadataModel);
				$prioritizedMetadataModel->ogUrl      = SproutSeoOptimizeHelper::prepareCanonical($prioritizedMetadataModel);
				$prioritizedMetadataModel->twitterUrl = SproutSeoOptimizeHelper::prepareCanonical($prioritizedMetadataModel);
			}

			$metadataModel = $metadataModel->setMeta($level, $codeMetadata);

			$prioritizedMetadataLevels[$level] = $metadataModel;
			$metadataModel->keywords           = !is_null($metadataModel->optimizedKeywords) ? $metadataModel->optimizedKeywords : $metadataModel->keywords;

			foreach ($prioritizedMetadataModel->getAttributes() as $key => $value)
			{
				// Test for a value on each of our models in their order of priority
				if ($metadataModel->getAttribute($key))
				{
					$prioritizedMetadataModel[$key] = $metadataModel[$key];
				}

				// Make sure our schema type and override are all or nothing
				// if we find the $metadataModel doesn't have a value for schemaOverrideTypeId
				// then we should make sure the $prioritizedMetadataModel also has a null value
				// otherwise we still keep our lower level value
				if ($key == 'schemaOverrideTypeId' &&
					$metadataModel['schemaTypeId'] != null &&
					$metadataModel->getAttribute($key) == null
				)
				{
					$prioritizedMetadataModel[$key] = null;
				}

				// Make sure all our strings are trimmed
				if (is_string($prioritizedMetadataModel[$key]))
				{
					$prioritizedMetadataModel[$key] = trim($prioritizedMetadataModel[$key]);
				}
			}
		}

		// Remove the ogAuthor value if we don't have an article
		if ($prioritizedMetadataModel->ogType != 'article')
		{
			$prioritizedMetadataModel->ogAuthor    = null;
			$prioritizedMetadataModel->ogPublisher = null;
		}
		else
		{
			$prioritizedMetadataModel->ogDateCreated = null;
			$prioritizedMetadataModel->ogDateUpdated = null;
			$prioritizedMetadataModel->ogExpiryDate  = null;

			if (isset($this->urlEnabledSection->element->dateCreated) && $this->urlEnabledSection->element->dateCreated)
			{
				$prioritizedMetadataModel->ogDateCreated = $this->urlEnabledSection->element->dateCreated->iso8601();
			}

			if (isset($this->urlEnabledSection->element->dateUpdated) && $this->urlEnabledSection->element->dateUpdated)
			{
				$prioritizedMetadataModel->ogDateUpdated = $this->urlEnabledSection->element->dateUpdated->iso8601();
			}

			if (isset($this->urlEnabledSection->element->expiryDate) && $this->urlEnabledSection->element->expiryDate)
			{
				$prioritizedMetadataModel->ogExpiryDate = $this->urlEnabledSection->element->expiryDate->iso8601();
			}
		}

		$prioritizedMetadataModel->title = SproutSeoOptimizeHelper::prepareAppendedTitleValue(
			$prioritizedMetadataModel,
			$prioritizedMetadataLevels[SproutSeo_MetadataLevels::SectionMetadata],
			$prioritizedMetadataLevels[SproutSeo_MetadataLevels::GlobalMetadata]
		);

		$prioritizedMetadataModel->robots = SproutSeoOptimizeHelper::prepareRobotsMetadataValue($prioritizedMetadataModel->robots);

		// let's just prepare assets for final metadatamodel
		SproutSeoOptimizeHelper::prepareAssetUrls($prioritizedMetadataModel);

		// Trim descriptions to maxMetaDescriptionLength or 160 characters
		$descriptionLength = sproutSeo()->settings->getDescriptionLength();

		$prioritizedMetadataModel->optimizedDescription = mb_substr($prioritizedMetadataModel->optimizedDescription, 0, $descriptionLength);
		$prioritizedMetadataModel->description          = mb_substr($prioritizedMetadataModel->description, 0, $descriptionLength);
		$prioritizedMetadataModel->ogDescription        = mb_substr($prioritizedMetadataModel->ogDescription, 0, $descriptionLength);
		$prioritizedMetadataModel->twitterDescription   = mb_substr($prioritizedMetadataModel->twitterDescription, 0, $descriptionLength);

		return $prioritizedMetadataModel;
	}

	public function getStructuredData()
	{
		$schema = array();

		$identityType = $this->globals->identity['@type'];

		// Website Identity Schema
		if ($identityType)
		{
			// Determine if we have an Organization or Person Schema Type
			$schemaModel = 'Craft\SproutSeo_WebsiteIdentity' . $identityType . 'Schema';

			$identitySchema             = new $schemaModel();
			$identitySchema->addContext = true;

			$identitySchema->globals                  = $this->globals;
			$identitySchema->prioritizedMetadataModel = $this->prioritizedMetadataModel;

			if (isset($this->urlEnabledSection->element))
			{
				$identitySchema->element = $this->urlEnabledSection->element;
			}

			$schema['websiteIdentity'] = $identitySchema;
		}

		// Website Identity Website
		if ($this->globals->identity['name'])
		{
			$websiteSchema             = new SproutSeo_WebsiteIdentityWebsiteSchema();
			$websiteSchema->addContext = true;

			$websiteSchema->globals                  = $this->globals;
			$websiteSchema->prioritizedMetadataModel = $this->prioritizedMetadataModel;

			if (isset($this->urlEnabledSection->element))
			{
				$websiteSchema->element = $this->urlEnabledSection->element;
			}

			$schema['website'] = $websiteSchema;
		}

		$identity = $this->globals->identity;

		// Website Identity Place
		if (isset($identity['addressId']) && $identity['addressId'])
		{
			$placeSchema             = new SproutSeo_WebsiteIdentityPlaceSchema();
			$placeSchema->addContext = true;

			$placeSchema->globals                  = $this->globals;
			$placeSchema->prioritizedMetadataModel = $this->prioritizedMetadataModel;

			if (isset($this->urlEnabledSection->element))
			{
				$placeSchema->element = $this->urlEnabledSection->element;
			}

			$schema['place'] = $placeSchema;
		}

		$schema['mainEntity'] = $this->getMainEntityStructuredData();

		return $schema;
	}

	/**
	 * @return string
	 */
	public function getMainEntityStructuredData()
	{
		$schema = null;

		if ($this->prioritizedMetadataModel)
		{
			$schemaUniqueKey = $this->prioritizedMetadataModel->schemaTypeId;

			if ($schemaUniqueKey && isset($this->urlEnabledSection->element))
			{
				$schema               = $this->getSchemaByUniqueKey($schemaUniqueKey);
				$schema->attributes   = $this->prioritizedMetadataModel->getAttributes();
				$schema->addContext   = true;
				$schema->isMainEntity = true;

				$schema->globals                  = $this->globals;
				$schema->element                  = $this->urlEnabledSection->element;
				$schema->prioritizedMetadataModel = $this->prioritizedMetadataModel;
			}
		}

		return $schema;
	}

	/**
	 * @param $metadata
	 *
	 * @return string
	 */
	public function renderMetadata($metadata)
	{
		craft()->templates->setTemplatesPath(craft()->path->getPluginsPath());

		$output = craft()->templates->render('sproutseo/templates/_special/metadata', array(
			'metadata' => $metadata
		));

		craft()->templates->setTemplatesPath(craft()->path->getSiteTemplatesPath());

		return $output;
	}

	// Code Metadata
	// =========================================================================

	/**
	 * Store our codeMetadata in a place so we can access when we need to
	 *
	 * @todo - Rename method
	 *         This is named 'getCodeMetadata' but also handles overrides for Section and Element data.
	 *
	 * @return array
	 */
	public function getCodeMetadata($type = null)
	{
		$response = array();

		switch ($type)
		{
			case SproutSeo_MetadataLevels::SectionMetadata:
				$response = array(
					'urlEnabledSection' => $this->urlEnabledSection,
					'codeSection'       => $this->codeSection
				);
				break;

			case SproutSeo_MetadataLevels::ElementMetadata:
				if (isset($this->urlEnabledSection->element))
				{
					if (isset($this->urlEnabledSection->element->id))
					{
						$response = array('elementId' => $this->urlEnabledSection->element->id);
					}
				}
				break;

			case SproutSeo_MetadataLevels::CodeMetadata:
				$response = $this->codeMetadata;
				break;
		}

		return $response;
	}

	/**
	 * Returns the url enable section given the variable id
	 *
	 * @param $variableNameId string
	 * @return array
	 */
	public function getContextByElementVariable($variableIdValue, $variableNameId)
	{
		$response = array();

		$registeredUrlEnabledSectionsTypes = craft()->plugins->call('registerSproutSeoUrlEnabledSectionTypes');

		foreach ($registeredUrlEnabledSectionsTypes as $plugin => $urlEnabledSectionTypes)
		{
			foreach ($urlEnabledSectionTypes as $urlEnabledSectionType)
			{
				// Let's get the optimized metadata model
				$idVariableName = $urlEnabledSectionType->getIdVariableName();

        if($idVariableName == $variableNameId)
				{
					// example: entry, category, etc.
					$elementType = $urlEnabledSectionType->getMatchedElementVariable();
					$locale      = craft()->i18n->getLocaleById(craft()->language);
					$elementById = craft()->elements->getElementById($variableIdValue, $urlEnabledSectionType->getElementType(), $locale->id);

					if ($elementById)
					{
						$response = array(
							$elementType => $elementById
						);

						return $response;
					}
				}
			}
		}

		return $response;
	}
}
