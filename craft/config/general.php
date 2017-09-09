<?php

return [

  '*' => [
    'usePathInfo' => false,
    'timezone' => 'America/New_York',
    'omitScriptNameInUrls' => true,
    'preventUserEnumeration' => true,
    'overridePhpSessionLocation' => true,
    'requireMatchingUserAgentForSession' => false,
  ],

  'www.macromeals.life' => [
    'devMode' => true,
    'overridePhpSessionLocation' => false,
    'environmentVariables' => [
      'siteUrl'  => 'https://www.macromeals.life/',
      'basePath' => '/srv/http/macromeals/shared/uploads/',
    ],
  ],

  'macromeals.joshmagness.me' => [
    'devMode' => true,
    'overridePhpSessionLocation' => false,
    'environmentVariables' => [
      'siteUrl'  => 'http://macromeals.joshmagness.me/',
      'basePath' => '/srv/http/macromeals/shared/uploads/',
    ],
  ],

  'macromeals.localhost.dev' => [
    'devMode' => true,
    'overridePhpSessionLocation' => false,
    'enableCsrfProtection' => false,
    'environmentVariables' => [
      'siteUrl'  => 'https://macromeals.localhost.dev/',
      'basePath' => '/Users/magnessjo/Sites/personal/macromeals/source/assets/uploads',
    ],
  ],

];
