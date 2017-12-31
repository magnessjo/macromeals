<?php

namespace Calendar\Library\ColorJizz\Formats;

use Calendar\Library\ColorJizz\ColorJizz;

/**
 * CMYK represents the CMYK color format
 *
 * @author Mikee Franklin <mikeefranklin@gmail.com>
 */
class CMYK extends ColorJizz
{

    /**
     * The cyan
     *
     * @var float
     */
    private $cyan;

    /**
     * The magenta
     *
     * @var float
     */
    private $magenta;

    /**
     * The yellow
     *
     * @var float
     */
    private $yellow;

    /**
     * The key (black)
     *
     * @var float
     */
    private $key;

    /**
     * Create a new CMYK color
     *
     * @param float $cyan
     * @param float $magenta
     * @param float $yellow
     * @param float $key
     */
    public function __construct($cyan, $magenta, $yellow, $key)
    {
        $this->toSelf  = "toCMYK";
        $this->cyan    = $cyan;
        $this->magenta = $magenta;
        $this->yellow  = $yellow;
        $this->key     = $key;
    }

    public static function create($cyan, $magenta, $yellow, $key)
    {
        return new CMYK($cyan, $magenta, $yellow, $key);
    }

    /**
     * Get the amount of Cyan
     *
     * @return int The amount of cyan
     */
    public function getCyan()
    {
        return $this->cyan;
    }


    /**
     * Get the amount of Magenta
     *
     * @return int The amount of magenta
     */
    public function getMagenta()
    {
        return $this->magenta;
    }


    /**
     * Get the amount of Yellow
     *
     * @return int The amount of yellow
     */
    public function getYellow()
    {
        return $this->yellow;
    }


    /**
     * Get the key (black)
     *
     * @return int The amount of black
     */
    public function getKey()
    {
        return $this->key;
    }

    /**
     * Convert the color to Hex format
     *
     * @return Hex the color in Hex format
     */
    public function toHex()
    {
        return $this->toRGB()->toHex();
    }

    /**
     * Convert the color to RGB format
     *
     * @return RGB the color in RGB format
     */
    public function toRGB()
    {
        return $this->toCMY()->toRGB();
    }

    /**
     * Convert the color to XYZ format
     *
     * @return XYZ the color in XYZ format
     */
    public function toXYZ()
    {
        return $this->toRGB()->toXYZ();
    }

    /**
     * Convert the color to Yxy format
     *
     * @return Yxy the color in Yxy format
     */
    public function toYxy()
    {
        return $this->toXYZ()->toYxy();
    }

    /**
     * Convert the color to HSV format
     *
     * @return HSV the color in HSV format
     */
    public function toHSV()
    {
        return $this->toRGB()->toHSV();
    }

    /**
     * Convert the color to CMY format
     *
     * @return CMY the color in CMY format
     */
    public function toCMY()
    {
        $cyan    = ($this->cyan * (1 - $this->key) + $this->key);
        $magenta = ($this->magenta * (1 - $this->key) + $this->key);
        $yellow  = ($this->yellow * (1 - $this->key) + $this->key);

        return new CMY($cyan, $magenta, $yellow);
    }

    /**
     * Convert the color to CMYK format
     *
     * @return CMYK the color in CMYK format
     */
    public function toCMYK()
    {
        return $this;
    }

    /**
     * Convert the color to CIELab format
     *
     * @return CIELab the color in CIELab format
     */
    public function toCIELab()
    {
        return $this->toRGB()->toCIELab();
    }

    /**
     * Convert the color to CIELCh format
     *
     * @return CIELCh the color in CIELCh format
     */
    public function toCIELCh()
    {
        return $this->toCIELab()->toCIELCh();
    }

    /**
     * A string representation of this color in the current format
     *
     * @return string The color in format: $cyan,$magenta,$yellow,$key
     */
    public function __toString()
    {
        return sprintf('%s,%s,%s,%s', $this->cyan, $this->magenta, $this->yellow, $this->key);
    }
}
