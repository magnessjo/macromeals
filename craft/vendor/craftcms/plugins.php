<?php

$vendorDir = dirname(__DIR__);

return array (
  'macromeals/macromeals-commerce' => 
  array (
    'class' => 'macromeals\\macromealscommerce\\MacroMealsCommerce',
    'basePath' => $vendorDir . '/macromeals/macromeals-commerce/src',
    'handle' => 'macromeals-commerce',
    'aliases' => 
    array (
      '@macromeals/macromealscommerce' => $vendorDir . '/macromeals/macromeals-commerce/src',
    ),
    'name' => 'Macro Meals Commerce',
    'version' => '1.0.0',
    'description' => 'Macro Meals Commerce Plugin',
    'developer' => 'Josh Magness',
    'developerUrl' => 'joshmagness.me',
    'documentationUrl' => 'https://github.com/https://github.com/magnessjo/Macro-Meals-Commerce-Plugin/macro-meals-commerce/blob/master/README.md',
    'changelogUrl' => 'https://raw.githubusercontent.com/https://github.com/magnessjo/Macro-Meals-Commerce-Plugin/macro-meals-commerce/master/CHANGELOG.md',
    'hasCpSettings' => false,
    'hasCpSection' => false,
  ),
  'craftcms/commerce' => 
  array (
    'class' => 'craft\\commerce\\Plugin',
    'basePath' => $vendorDir . '/craftcms/commerce/src',
    'handle' => 'commerce',
    'aliases' => 
    array (
      '@craft/commerce' => $vendorDir . '/craftcms/commerce/src',
    ),
    'name' => 'Craft Commerce',
    'version' => 'dev-develop',
    'description' => 'An amazingly powerful and flexible e-commerce platform for Craft CMS.',
    'developer' => 'Pixel & Tonic',
    'developerUrl' => 'https://craftcommerce.com',
    'developerEmail' => 'support@craftcms.com',
    'documentationUrl' => 'https://github.com/craftcms/docs',
  ),
  'solspace/craft3-calendar' => 
  array (
    'class' => 'Solspace\\Calendar\\Calendar',
    'basePath' => $vendorDir . '/solspace/craft3-calendar/src',
    'handle' => 'calendar',
    'aliases' => 
    array (
      '@Solspace/Calendar' => $vendorDir . '/solspace/craft3-calendar/src',
    ),
    'name' => 'Calendar',
    'version' => '2.0.0-beta.7',
    'schemaVersion' => '2.0.1',
    'description' => 'The most powerful event management plugin for Craft.',
    'developer' => 'Solspace',
    'developerUrl' => 'https://solspace.com/craft/calendar',
    'documentationUrl' => 'https://solspace.com/craft/calendar/docs',
    'changelogUrl' => 'https://raw.githubusercontent.com/solspace/craft3-calendar/master/CHANGELOG.md',
    'hasCpSection' => true,
  ),
);
