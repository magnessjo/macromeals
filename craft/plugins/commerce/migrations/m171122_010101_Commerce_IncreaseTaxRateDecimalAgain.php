<?php
namespace Craft;

class m171122_010101_Commerce_IncreaseTaxRateDecimalAgain extends BaseMigration
{
    public function safeUp()
    {
        $this->alterColumn('commerce_taxrates','rate','decimal(14,10)');
    }
}
