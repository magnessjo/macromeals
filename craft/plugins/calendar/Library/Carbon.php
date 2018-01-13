<?php
/**
 * Calendar for Craft
 *
 * @package       Solspace:Calendar
 * @author        Solspace, Inc.
 * @copyright     Copyright (c) 2010-2018, Solspace, Inc.
 * @link          https://solspace.com/craft/calendar
 * @license       https://solspace.com/software/license-agreement
 */

namespace Calendar\Library;

use Craft\Craft;

class Carbon extends \Carbon\Carbon
{
    /**
     * Overrides the default ::format() method to include translations for date words
     *
     * @param string $format
     *
     * @return mixed|string
     */
    public function format($format)
    {
        $value = parent::format($format);

        // Get the "words".  Split on anything that is not a unicode letter.
        preg_match_all('/[\p{L}]+/u', $value, $words);

        if ($words && isset($words[0]) && count($words[0]) > 0)
        {
            foreach ($words[0] as $word)
            {
                $originalWord = $word;

                if ($word === 'May')
                {
                    if (strpos($format, 'F') !== false)
                    {
                        $word = 'May-W';
                    }
                }

                // Translate and swap out.
                $translatedWord = Craft::t($word);

                $value = str_replace($originalWord, $translatedWord, $value);
            }
        }

        // Return the translated value.
        return $value;
    }
}
