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

  '*.macromeals.life' => [
    'devMode' => false,
    'overridePhpSessionLocation' => false,
    'environmentVariables' => [
      'siteUrl'  => 'https://www.macromeals.life/',
      'basePath' => '/srv/http/macromeals/source/assets/',
    ],
  ],

  'macromeals.localhost.dev' => [
    'devMode' => true,
    'overridePhpSessionLocation' => false,
    'environmentVariables' => [
      'siteUrl'  => 'https://macromeals.localhost.dev/',
      'basePath' => '/Users/joshmagness/Sites/personals/macromeals/source/assets/images/uploads',
    ],
  ],

];
