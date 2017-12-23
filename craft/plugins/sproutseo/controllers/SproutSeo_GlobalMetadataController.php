<?php
namespace Craft;

class SproutSeo_GlobalMetadataController extends BaseController
{
	/**
	 * Save Globals to the database
	 *
	 * @throws HttpException
	 */
	public function actionSaveGlobalMetadata()
	{
		$this->requirePostRequest();

		$postData = craft()->request->getPost('sproutseo.globals');
		$globalKeys = craft()->request->getPost('globalKeys');

		$addressInfoId = sproutSeo()->address->saveAddressByPost();

		if ($addressInfoId)
		{
			$postData['identity']['addressId'] = $addressInfoId;
		}

		$globalKeys = explode(',', $globalKeys);

		if (isset($postData['identity']['foundingDate']))
		{
			$postData['identity']['foundingDate'] = DateTime::createFromString($postData['identity']['foundingDate'], craft()->timezone);
		}

		$globals = SproutSeo_GlobalsModel::populateModel($postData);

		$globalMetadata = $this->populateGlobalMetadata($postData);

		$globals->meta = JsonHelper::encode($globalMetadata);

		$identity = $globals->identity;

		if (isset($identity['@type']) && $identity['@type'] == 'Person')
		{
			// Clean up our organization subtypes when the Person type is selected
			unset($identity['organizationSubTypes']);

			$globals->identity = $identity;
		}

		if (sproutSeo()->globalMetadata->saveGlobalMetadata($globalKeys, $globals))
		{
			craft()->userSession->setNotice(Craft::t('Globals saved.'));

			$this->redirectToPostedUrl($globals);
		}
		else
		{
			craft()->userSession->setError(Craft::t('Unable to save globals.'));

			craft()->urlManager->setRouteVariables(array(
				'globals' => $globals
			));
		}
	}

	/**
	 * Save the Verify Ownership Structured Data to the database
	 *
	 * @throws HttpException
	 */
	public function actionSaveVerifyOwnership()
	{
		$this->requirePostRequest();

		$ownershipMeta = craft()->request->getPost('sproutseo.meta.ownership');
		$globalKeys    = 'ownership';

		// Remove empty items from multi-dimensional array
		$ownershipMeta = array_filter(array_map('array_filter', $ownershipMeta));

		$ownershipMetaWithKeys = array();

		foreach ($ownershipMeta as $key => $meta)
		{
			if (count($meta) == 3)
			{
				$ownershipMetaWithKeys[$key]['service']          = $meta[0];
				$ownershipMetaWithKeys[$key]['metaTag']          = $meta[1];
				$ownershipMetaWithKeys[$key]['verificationCode'] = $meta[2];
			}
		}

		$globals = SproutSeo_GlobalsModel::populateModel(array(
			$globalKeys => $ownershipMetaWithKeys
		));

		if (sproutSeo()->globalMetadata->saveGlobalMetadata(array($globalKeys), $globals))
		{
			craft()->userSession->setNotice(Craft::t('Globals saved.'));

			$this->redirectToPostedUrl($globals);
		}
		else
		{
			craft()->userSession->setError(Craft::t('Unable to save globals.'));

			craft()->urlManager->setRouteVariables(array(
				'globals' => $globals
			));
		}
	}

	/**
	 * @param $postData
	 *
	 * @return SproutSeo_MetadataModel
	 */
	public function populateGlobalMetadata($postData)
	{
		$settings = craft()->plugins->getPlugin('sproutseo')->getSettings();
		$locale   = craft()->i18n->getLocaleById(craft()->language);
		$localeId = $locale->id;

		$oldGlobals        = sproutSeo()->globalMetadata->getGlobalMetadata();
		$oldIdentity       = isset($oldGlobals) ? $oldGlobals->identity : null;
		$identity          = isset($postData['identity']) ? $postData['identity'] : $oldIdentity;
		$oldSocialProfiles = isset($oldGlobals) ? $oldGlobals->social : array();

		if (isset($postData['settings']['ogTransform']))
		{
			$identity['ogTransform'] = $postData['settings']['ogTransform'];
		}

		if (isset($postData['settings']['twitterTransform']))
		{
			$identity['twitterTransform'] = $postData['settings']['twitterTransform'];
		}

		$globalMetadata     = new SproutSeo_MetadataModel();
		$siteName           = craft()->getSiteName();

		$urlSetting         = isset($postData['identity']['url']) ? $postData['identity']['url'] : null;
		$siteUrl            = SproutSeoOptimizeHelper::getGlobalMetadataSiteUrl($urlSetting);

		$socialProfiles     = isset($postData['social']) ? $postData['social'] : $oldSocialProfiles;
		$twitterProfileName = SproutSeoOptimizeHelper::getTwitterProfileName($socialProfiles);

		$twitterCard        = (isset($postData['settings']['defaultTwitterCard']) && $postData['settings']['defaultTwitterCard']) ? $postData['settings']['defaultTwitterCard'] : 'summary';

		$ogType             = (isset($postData['settings']['defaultOgType']) && $postData['settings']['defaultOgType']) ? $postData['settings']['defaultOgType'] : 'website';

		$robots             = isset($postData['robots']) ? $postData['robots'] : $oldGlobals->robots;
		$robotsMetaValue    = SproutSeoOptimizeHelper::prepareRobotsMetadataValue($robots);

		if ($settings->localeIdOverride)
		{
			$localeId = $settings->localeIdOverride;
		}

		$facebookPage = SproutSeoOptimizeHelper::getFacebookPage($socialProfiles);

		if ($facebookPage)
		{
			$globalMetadata->ogPublisher = $facebookPage;
		}

		if ($identity)
		{
			$identityName         = isset($identity['name']) ? $identity['name'] : null;
			$optimizedTitle       = $identityName;
			$optimizedDescription = isset($identity['description']) ? $identity['description'] : null;
			$optimizedImage       = isset($identity['image'][0]) ? $identity['image'][0] : null;

			$globalMetadata->optimizedTitle       = $optimizedTitle;
			$globalMetadata->optimizedDescription = $optimizedDescription;
			$globalMetadata->optimizedImage       = $optimizedImage;

			$globalMetadata->title       = $optimizedTitle;
			$globalMetadata->description = $optimizedDescription;
			$globalMetadata->keywords    = isset($identity['keywords']) ? $identity['keywords'] : null;

			$globalMetadata->robots    = $robotsMetaValue;
			$globalMetadata->canonical = $siteUrl;

			// @todo - Add location info
			$globalMetadata->region    = "";
			$globalMetadata->placename = "";
			$globalMetadata->position  = "";
			$globalMetadata->latitude  = isset($postData['identity']['latitude'])  ? $postData['identity']['latitude'] : "";
			$globalMetadata->longitude = isset($postData['identity']['longitude']) ? $postData['identity']['longitude'] : "";

			$globalMetadata->ogType        = $ogType;
			$globalMetadata->ogSiteName    = $siteName;
			$globalMetadata->ogUrl         = $siteUrl;
			$globalMetadata->ogTitle       = $optimizedTitle;
			$globalMetadata->ogDescription = $optimizedDescription;
			$globalMetadata->ogImage       = $optimizedImage;
			$globalMetadata->ogImage       = $optimizedImage;
			$globalMetadata->ogTransform   = isset($identity['ogTransform']) ? $identity['ogTransform'] : null;
			$globalMetadata->ogLocale      = $localeId;

			$globalMetadata->twitterCard        = $twitterCard;
			$globalMetadata->twitterSite        = $twitterProfileName;
			$globalMetadata->twitterCreator     = $twitterProfileName;
			$globalMetadata->twitterUrl         = $siteUrl;
			$globalMetadata->twitterTitle       = $optimizedTitle;
			$globalMetadata->twitterDescription = $optimizedDescription;
			$globalMetadata->twitterImage       = $optimizedImage;
			$globalMetadata->twitterTransform   = isset($identity['twitterTransform']) ? $identity['twitterTransform'] : null;
		}

		return $globalMetadata;
	}
}
