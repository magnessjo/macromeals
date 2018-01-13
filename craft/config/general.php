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
    'enableCsrfProtection' => false,
    'environmentVariables' => [
      'siteUrl'  => 'https://macromeals.joshmagness.me/',
      'basePath' => '/srv/http/macromeals/shared/uploads/',
      'pluginPath' => '/srv/http/macromeals/craft/plugins'
    ],
  ],

  '.dev' => [
    'devMode' => true,
    'enableCsrfProtection' => false,
    'environmentVariables' => [
      'siteUrl'  => 'https://macromeals.localhost.dev/',
      'basePath' => '/Users/magnessjo/Sites/personal/macromeals/source/assets/uploads',
      'pluginPath' => '/Users/magnessjo/Sites/personal/macromeals/craft/plugins'
    ],
  ],

  '.life' => [
    'devMode' => false,
    'enableCsrfProtection' => false,
    'environmentVariables' => [
      'siteUrl'  => 'https://www.macromeals.life/',
      'basePath' => '/srv/http/macromeals/shared/uploads/',
      'pluginPath' => '/srv/http/macromeals/craft/plugins'
    ],
  ],

];
