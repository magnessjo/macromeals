<?php
namespace PhpUnitsOfMeasure;

/**
 * Physical quantities with this trait
 * have units which are metric and therefore have
 * a standard set of prefixes.
 */
trait HasSIUnitsTrait
{
    /**
     * Given the patterns for generating the names and aliases,
     * generate the various metric units of measure and add
     * them to this physical quantity.
     *
     * Names and Aliases are created by replacing identifiers in the respective
     * patterns.  The current allowed replacement identifiers are:
     *   %p = the abbreviated SI prefix, like 'M' for 'megameter' or 'k' for 'kilogram'
     *   %P = the full SI prefix, like 'mega' for 'megameter' or 'kilo' for 'kilogram'
     *   %U = uppercase version of %P
     *
     * So for instance, in order to generate 'kg', 'mg', and 'g' names for SI units, the
     * appropriate pattern would be '%pg'.  Similarly, to generate 'kilogram', 'milligram',
     * and 'gram' aliases, the pattern would be '%Pgram'.
     *
     * The $siUnit given in the 1st parameter must be some SI unit in the series of units
     * to be generated by this method.  This value is necessary to establish a conversion
     * factor between this continuum of SI units and the Physical Quantity's native unit.
     *
     * The second parameter provides a scaling factor between the given SI unit in the first parameter
     * and the base unit of the SI continuum (ie, 'grams', 'meters', 'seconds', etc).  For instance,
     * if a Kilogram unit of measure was passed for the 1st parameter, it would be necessary to
     * then pass 1e-3 in the 2nd parameter to indicate that a gram is 1/1000 of the given unit.
     *
     * @param  UnitOfMeasure $siUnit             A unit in this physical quantity that is an SI unit of measure
     * @param  integer       $toBaseSiUnitFactor The power-of-ten factor that converts the given SI unit into the not-prefixed SI base unit (ie 1e-3 for kilograms)
     * @param  string        $namePattern        The pattern to apply to the base unit's name to generate a new SI unit name
     * @param  array         $aliasPatterns      The collection of alias patterns to use in generating a new SI unit's aliases
     */
    protected static function addMissingSIPrefixedUnits(
        UnitOfMeasure $siUnit,
        $toBaseSiUnitFactor,
        $namePattern,
        array $aliasPatterns = []
    ) {
        /**
         * The standard set of SI prefixes
         */
        $siPrefixes = [
            [
                'abbr_prefix' => 'Y',
                'long_prefix' => 'yotta',
                'factor'      => 1e24
            ],
            [
                'abbr_prefix' => 'Z',
                'long_prefix' => 'zetta',
                'factor'      => 1e21
            ],
            [
                'abbr_prefix' => 'E',
                'long_prefix' => 'exa',
                'factor'      => 1e18
            ],
            [
                'abbr_prefix' => 'P',
                'long_prefix' => 'peta',
                'factor'      => 1e15
            ],
            [
                'abbr_prefix' => 'T',
                'long_prefix' => 'tera',
                'factor'      => 1e12
            ],
            [
                'abbr_prefix' => 'G',
                'long_prefix' => 'giga',
                'factor'      => 1e9
            ],
            [
                'abbr_prefix' => 'M',
                'long_prefix' => 'mega',
                'factor'      => 1e6
            ],
            [
                'abbr_prefix' => 'k',
                'long_prefix' => 'kilo',
                'factor'      => 1e3
            ],
            [
                'abbr_prefix' => 'h',
                'long_prefix' => 'hecto',
                'factor'      => 1e2
            ],
            [
                'abbr_prefix' => 'da',
                'long_prefix' => 'deca',
                'factor'      => 1e1
            ],
            [
                'abbr_prefix' => '',
                'long_prefix' => '',
                'factor'      => 1
            ],
            [
                'abbr_prefix' => 'd',
                'long_prefix' => 'deci',
                'factor'      => 1e-1
            ],
            [
                'abbr_prefix' => 'c',
                'long_prefix' => 'centi',
                'factor'      => 1e-2
            ],
            [
                'abbr_prefix' => 'm',
                'long_prefix' => 'milli',
                'factor'      => 1e-3
            ],
            [
                'abbr_prefix' => 'µ',
                'long_prefix' => 'micro',
                'factor'      => 1e-6
            ],
            [
                'abbr_prefix' => 'n',
                'long_prefix' => 'nano',
                'factor'      => 1e-9
            ],
            [
                'abbr_prefix' => 'p',
                'long_prefix' => 'pico',
                'factor'      => 1e-12
            ],
            [
                'abbr_prefix' => 'f',
                'long_prefix' => 'femto',
                'factor'      => 1e-15
            ],
            [
                'abbr_prefix' => 'a',
                'long_prefix' => 'atto',
                'factor'      => 1e-18
            ],
            [
                'abbr_prefix' => 'z',
                'long_prefix' => 'zepto',
                'factor'      => 1e-21
            ],
            [
                'abbr_prefix' => 'y',
                'long_prefix' => 'yocto',
                'factor'      => 1e-24
            ],
        ];

        // Determine the conversion factor from the no-prefix SI unit to the physical quantity's native unit
        $noPrefixToNativeUnitFactor = $siUnit->convertValueToNativeUnitOfMeasure(1) * $toBaseSiUnitFactor;

        // For each of the standard SI prefixes, attempt to register a new unit of measure
        foreach ($siPrefixes as $prefixDefinition) {
            // Build a function for resolving a pattern into a unit name
            $parsePattern = function ($pattern) use ($prefixDefinition) {
                return strtr(
                    $pattern,
                    [
                        '%p' => $prefixDefinition['abbr_prefix'],
                        '%P' => $prefixDefinition['long_prefix'],
                        '%U' => strtoupper($prefixDefinition['long_prefix'])
                    ]
                );
            };

            // Generate the base name of the new unit
            $name = $parsePattern($namePattern);

            // Determine the factor that converts the new unit into the physical quantity's
            //   native unit of measure.
            $toNativeUnitFactor = $noPrefixToNativeUnitFactor * $prefixDefinition['factor'];

            // Instantiate the new unit of measure
            $newUnit = UnitOfMeasure::linearUnitFactory($name, $toNativeUnitFactor);

            // Generate the aliases of the new unit
            foreach ($aliasPatterns as $aliasPattern) {
                $newUnitAlias = $parsePattern($aliasPattern);
                $newUnit->addAlias($newUnitAlias);
            }

            // If the unit doesn't conflict with any of the already-existing units, register it
            if (!static::unitNameOrAliasesAlreadyRegistered($newUnit)) {
                static::addUnit($newUnit);
            }
        }
    }
}
