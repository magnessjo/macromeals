
<?php

return [
  // Global settings
  '*' => [
    'defaultWeekStartDay' => 0,
    'cpTrigger' => 'admin',
    'securityKey' => getenv('SECURITY_KEY'),
    'usePathInfo' => false,
    'timezone' => 'America/New_York',
    'omitScriptNameInUrls' => true,
    'preventUserEnumeration' => true,
    'overridePhpSessionLocation' => true,
    'requireMatchingUserAgentForSession' => false,
    'autoLoginAfterAccountActivation' => true,
    'enableCsrfProtection' => true,
    'tokenParam' => 'craftToken',
    'siteUrl'  => 'https://www.macromeals.life/',
    'aliases' => [
      '@siteUrl' => 'https://www.macromeals.life/',
      '@assetBaseUrl' => 'https://www.macromeals.life/',
      '@assetBasePath' => '/srv/http/macromeals/shared/uploads/',
      '@pluginPath' => '/srv/http/macromeals/craft/plugins',
    ],
  ],

  // Dev environment settings
  'dev' => [
    'devMode' => true,
    'siteUrl'  => 'https://macrocommerce.localhost.dev/',
    'aliases' => [
      '@siteUrl' => 'https://macrocommerce.localhost.dev/',
      '@assetBaseUrl' => 'https://macrocommerce.localhost.dev/',
      '@assetBasePath' => '/Users/magnessjo/Sites/personal/macrocommerce/source/assets/uploads',
      '@pluginPath' => '/Users/magnessjo/Sites/personal/macrocommerce/craft/plugins',
    ],
  ],

  'staging' => [
    'devMode' => false,
    'aliases' => [
      '@assetBaseUrl' => 'https://macromeals.joshmagness.me/',
      '@assetBasePath' => '/srv/http/macromeals/shared/uploads/',
      '@pluginPath' => '/srv/http/macromeals/craft/plugins',
    ],
  ],

];
