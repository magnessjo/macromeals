<?php
namespace Craft;

class SproutSeo_SectionMetadataRecord extends BaseRecord
{
	/**
	 * @return string
	 */
	public function getTableName()
	{
		return 'sproutseo_metadata_sections';
	}

	/**
	 * @return array
	 */
	protected function defineAttributes()
	{
		return array(
			'urlEnabledSectionId' => array(AttributeType::Number),
			'isCustom'            => array(AttributeType::Bool, 'default' => false, 'required' => true),
			'enabled'             => array(AttributeType::Bool, 'default' => false, 'required' => true),
			'type'                => array(AttributeType::String),

			'name'                 => array(AttributeType::String, 'required' => true),
			'handle'               => array(AttributeType::String, 'required' => true),
			'uri'                  => array(AttributeType::String),
			'priority'             => array(AttributeType::Number, 'maxLength' => 2, 'decimals' => 1, 'default' => '0.5', 'required' => true),
			'changeFrequency'      => array(AttributeType::String, 'maxLength' => 7, 'default' => 'weekly', 'required' => true),

			// Optimized Meta
			'optimizedTitle'       => array(AttributeType::String),
			'optimizedDescription' => array(AttributeType::Mixed),
			'optimizedImage'       => array(AttributeType::String),
			'optimizedKeywords'    => array(AttributeType::String),

			// Structured Data
			'schemaTypeId'         => array(AttributeType::String),
			'schemaOverrideTypeId' => array(AttributeType::String),

			'enableMetaDetailsSearch'      => array(AttributeType::Bool, 'default' => false, 'required' => false),
			'enableMetaDetailsOpenGraph'   => array(AttributeType::Bool, 'default' => false, 'required' => false),
			'enableMetaDetailsTwitterCard' => array(AttributeType::Bool, 'default' => false, 'required' => false),
			'enableMetaDetailsGeo'         => array(AttributeType::Bool, 'default' => false, 'required' => false),
			'enableMetaDetailsRobots'      => array(AttributeType::Bool, 'default' => false, 'required' => false),
			'title'                        => array(AttributeType::String),
			'appendTitleValue'             => array(AttributeType::String),
			'description'                  => array(AttributeType::Mixed),
			'keywords'                     => array(AttributeType::String),

			'robots'                         => array(AttributeType::String),
			'canonical'                      => array(AttributeType::String),

			'region'                         => array(AttributeType::String),
			'placename'                      => array(AttributeType::String),
			'latitude'                       => array(AttributeType::String),
			'longitude'                      => array(AttributeType::String),

			// Open Graph
			'ogType'                         => array(AttributeType::String),
			'ogUrl'                          => array(AttributeType::String),
			'ogSiteName'                     => array(AttributeType::String),
			'ogTitle'                        => array(AttributeType::String),
			'ogDescription'                  => array(AttributeType::Mixed),
			'ogImage'                        => array(AttributeType::String),
			'ogTransform'                    => array(AttributeType::String),
			'ogAuthor'                       => array(AttributeType::String),
			'ogPublisher'                    => array(AttributeType::String),
			'ogAudio'                        => array(AttributeType::String),
			'ogVideo'                        => array(AttributeType::String),
			'ogLocale'                       => array(AttributeType::String),

			// Twitter Cards
			'twitterCard'                    => array(AttributeType::String),
			'twitterUrl'                     => array(AttributeType::String),
			'twitterSite'                    => array(AttributeType::String),
			'twitterTitle'                   => array(AttributeType::String),
			'twitterDescription'             => array(AttributeType::Mixed),
			'twitterImage'                   => array(AttributeType::String),
			'twitterTransform'               => array(AttributeType::String),
			'twitterCreator'                 => array(AttributeType::String),

			// Fields for Twitter Player Card
			'twitterPlayer'                  => array(AttributeType::String),
			'twitterPlayerStream'            => array(AttributeType::String),
			'twitterPlayerStreamContentType' => array(AttributeType::String),
			'twitterPlayerWidth'             => array(AttributeType::String),
			'twitterPlayerHeight'            => array(AttributeType::String),
		);
	}

	/**
	 * Create a new instance of the current class. This allows us to
	 * properly unit test our service layer.
	 *
	 * @return BaseRecord
	 */
	public function create()
	{
		$class  = get_class($this);
		$record = new $class();

		return $record;
	}
}
