
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
    'environmentVariables' => [
      'siteUrl'  => 'https://www.macromeals.life/',
      'basePath' => '/srv/http/macromeals/shared/uploads/',
      'pluginPath' => '/srv/http/macromeals/craft/plugins'
    ]
  ],

  // Dev environment settings
  'dev' => [
    'devMode' => true,
    'aliases' => [
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




<?php

return [

  '*' => [
    'usePathInfo' => false,
    'timezone' => 'America/New_York',
    'omitScriptNameInUrls' => true,
    'preventUserEnumeration' => true,
    'overridePhpSessionLocation' => true,
    'requireMatchingUserAgentForSession' => false,
    'autoLoginAfterAccountActivation' => true,
    'enableCsrfProtection' => true,
    'tokenParam' => 'craftToken',
    'environmentVariables' => [
      'siteUrl'  => 'https://www.macromeals.life/',
      'basePath' => '/srv/http/macromeals/shared/uploads/',
      'pluginPath' => '/srv/http/macromeals/craft/plugins'
    ]
  ],

  '.me' => [
    'devMode' => false,
    'enableCsrfProtection' => true,
    'environmentVariables' => [
      'siteUrl'  => 'https://macromeals.joshmagness.me/',
      'basePath' => '/srv/http/macromeals/shared/uploads/',
      'pluginPath' => '/srv/http/macromeals/craft/plugins'
    ],
  ],

  '.dev' => [
    'devMode' => true,
    'enableCsrfProtection' => true,
    'environmentVariables' => [
      'siteUrl'  => 'https://macrocommerce.localhost.dev/',
      'basePath' => '/Users/magnessjo/Sites/personal/macrocommerce/source/assets/uploads',
      'pluginPath' => '/Users/magnessjo/Sites/personal/macrocommerce/craft/plugins'
    ],
  ],

  '.life' => [
    'devMode' => false,
    'enableCsrfProtection' => true,
    'environmentVariables' => [
      'siteUrl'  => 'https://www.macromeals.life/',
      'basePath' => '/srv/http/macromeals/shared/uploads/',
      'pluginPath' => '/srv/http/macromeals/craft/plugins'
    ],
  ],

];
