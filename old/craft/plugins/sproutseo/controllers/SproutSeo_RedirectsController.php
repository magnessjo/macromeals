<?php

namespace Craft;

/**
 * Redirects controller
 */
class SproutSeo_RedirectsController extends BaseController
{
	/**
	 * Loads the Redirect index page
	 *
	 * @throws HttpException
	 */
	public function actionRedirectIndex()
	{
		$this->renderTemplate('sproutseo/redirects/_index');
	}

	/**
	 * Edit a Redirect
	 *
	 * @param array $variables
	 *
	 * @throws HttpException
	 */
	public function actionEditRedirect(array $variables = array())
	{
		$variables['methodOptions'] = sproutSeo()->redirects->getMethods();

		$variables['subTitle'] = Craft::t('Create a new redirect');

		// Now let's set up the actual redirect
		if (empty($variables['redirect']))
		{
			if (!empty($variables['redirectId']))
			{
				$variables['subTitle'] = Craft::t('Edit redirect');
				$variables['redirect'] = sproutSeo()->redirects->getRedirectById($variables['redirectId']);

				if (!$variables['redirect'])
				{
					throw new HttpException(404);
				}
			}
			else
			{
				$variables['redirect'] = new SproutSeo_RedirectModel();
			}
		}

		$variables['continueEditingUrl'] = 'sproutseo/redirects/{id}';

		$variables['crumbs'] = array(
			array('label' => Craft::t('Redirects'), 'url' => UrlHelper::getUrl('redirects'))
		);

		$this->renderTemplate('sproutseo/redirects/_edit', $variables);
	}

	/**
	 * Saves a Redirect
	 */
	public function actionSaveRedirect()
	{
		$this->requirePostRequest();

		$redirectId = craft()->request->getPost('redirectId');

		if ($redirectId)
		{
			$redirect = sproutSeo()->redirects->getRedirectById($redirectId);

			if (!$redirect)
			{
				throw new Exception(Craft::t('No redirect exists with the ID “{id}”', array(
					'id' => $redirectId
				)));
			}
		}
		else
		{
			$redirect = new SproutSeo_RedirectModel();
		}

		// Set the event attributes, defaulting to the existing values for
		// whatever is missing from the post data
		$redirect->oldUrl  = craft()->request->getPost('oldUrl', $redirect->oldUrl);
		$redirect->newUrl  = craft()->request->getPost('newUrl');
		$redirect->method  = craft()->request->getPost('method');
		$redirect->regex   = craft()->request->getPost('regex');
		$redirect->enabled = craft()->request->getPost('enabled');
		$redirect->count   = craft()->request->getPost('count') != null ? craft()->request->getPost('count') : 0 ;

		if (sproutSeo()->redirects->saveRedirect($redirect))
		{
			craft()->userSession->setNotice(Craft::t('Redirect saved.'));

			$this->redirectToPostedUrl($redirect);
		}
		else
		{
			craft()->userSession->setError(Craft::t('Couldn’t save redirect.'));

			// Send the event back to the template
			craft()->urlManager->setRouteVariables(array(
				'redirect' => $redirect
			));
		}
	}

	/**
	 * Deletes a Redirect
	 */
	public function actionDeleteRedirect()
	{
		$this->requirePostRequest();

		$redirectId = craft()->request->getRequiredPost('redirectId');

		if (craft()->elements->deleteElementById($redirectId))
		{
			craft()->userSession->setNotice(Craft::t('Redirect deleted.'));
			$this->redirectToPostedUrl();
		}
		else
		{
			craft()->userSession->setError(Craft::t('Couldn’t delete redirect.'));
		}
	}
}
