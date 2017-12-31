<?php

namespace Calendar\Library\Attributes;

use Calendar\Library\DatabaseHelper;
use Calendar\Library\Exceptions\AttributeException;

abstract class AbstractAttributes
{
    const SORT_ASC  = 'ASC';
    const SORT_DESC = 'DESC';

    /** @var array */
    protected $validAttributes;

    /** @var string */
    private $order;

    /** @var string */
    private $sort;

    /** @var int */
    private $limit;

    /** @var array */
    private $attributes;

    /** @var array */
    private $conditions;

    /**
     * @param array|null $attributes
     *
     * @throws AttributeException
     */
    public final function __construct($attributes = null)
    {
        // A list of valid attributes must be present in the child class
        // If none are provided - an exception is thrown
        if (is_null($this->validAttributes)) {
            throw new AttributeException('No valid attributes defined for ' . __CLASS__);
        }

        $this->attributes = array();
        $this->conditions = array();
        $this->setSort(self::SORT_ASC);
        $this->parseAttributes($attributes);
        $this->buildConditions();
    }

    /**
     * @return \CDbCriteria
     */
    public function getCriteria()
    {
        $criteria = new \CDbCriteria();

        foreach ($this->attributes as $name => $value) {
            list ($operator, $value) = DatabaseHelper::prepareOperator($value);

            switch ($operator) {
                case DatabaseHelper::OPERATOR_NOT_IN:
                    $criteria->addNotInCondition($name, $value);
                    break;

                case DatabaseHelper::OPERATOR_IN:
                    $criteria->addInCondition($name, $value);
                    break;

                case DatabaseHelper::OPERATOR_NOT_EQUAL:
                default:
                    $criteria->addCondition("$name $operator :$name");
                    $criteria->params[$name] = $value;

                    break;
            }
        }

        if ($this->order) {
            $criteria->order = $this->order . ' ' . $this->sort;
        }

        if ($this->limit) {
            $criteria->limit = $this->limit;
        }

        return $criteria;
    }

    /**
     * @param string $value
     */
    private function setOrder($value)
    {
        $this->order = $value;
    }

    /**
     * @param int $value
     */
    private function setLimit($value)
    {
        $this->limit = (int)$value;
    }

    /**
     * @param string $value
     */
    private function setSort($value)
    {
        $this->sort = strtoupper($value) === self::SORT_ASC ? self::SORT_ASC : self::SORT_DESC;
    }

    /**
     * Parses all attributes, if any of the passed attributes does not exist in self::$validAttributes
     * An exception is thrown
     *
     * @param array $attributes
     *
     * @throws AttributeException
     */
    private function parseAttributes($attributes = null)
    {
        if (empty($attributes)) {
            return;
        }

        foreach ($attributes as $attribute => $value) {
            if (is_null($value)) {
                unset($attributes[$attribute]);
                continue;
            }

            if (in_array($attribute, array('order', 'limit', 'sort'))) {
                switch ($attribute) {
                    case 'order':
                        $this->setOrder($value);
                        break;

                    case 'limit':
                        $this->setLimit($value);
                        break;

                    case 'sort':
                        $this->setSort($value);
                        break;
                }

                unset($attributes[$attribute]);
                continue;
            }

            if (!in_array($attribute, $this->validAttributes)) {
                throw new AttributeException(
                    sprintf(
                        'Attribute "%s" is not allowed. Allowed attributes are: "%s"',
                        $attribute,
                        implode('", "', $this->validAttributes)
                    )
                );
            }
        }

        $this->attributes = $attributes;
    }

    /**
     * Builds the conditions array
     */
    private function buildConditions()
    {
        $conditions = array();

        if (!is_null($this->order)) {
            if (in_array($this->order, $this->validAttributes)) {
                $conditions['order'] = $this->order;
                $conditions['order'] .= ' ' . $this->sort;
            } else {
                throw new AttributeException(
                    sprintf(
                        'Cannot order by "%s". Allowed order fields are: "%s"',
                        $this->order,
                        implode('", "', $this->validAttributes)
                    )
                );
            }
        }

        if (!is_null($this->limit)) {
            $conditions['limit'] = $this->limit;
        }

        $this->conditions = $conditions;
    }
}
