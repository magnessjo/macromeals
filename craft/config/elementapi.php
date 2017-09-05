<?php
namespace Craft;

$slug = craft()->request->getPost('type');
$criteria = craft()->elements->getCriteria(ElementType::Category);
$criteria->group = 'protein';
$criteria->slug = $slug;

$category = $criteria->find();

return [
  'endpoints' => [
    'meals.json' => [
      'elementType' => 'Commerce_Product',
      'criteria' => [
        'commerce' => 'meals',
        'relatedTo' => [
          'targetElement' => $category
        ],
      ],
      'transformer' => function(Commerce_ProductModel $product) {

        $image =  $product->productImage->first();
        $chartPhoto = $product->productPieChart->first();

        return [
          'title' => $product->title,
          'subtitle' => $product->subTitle,
          'ingredients' => $product->ingredients,
          'image' => $image ? $image->url : null,
          'macros' => $product->productMacros,
          'chart' => $chartPhoto ? $chartPhoto->url : null
        ];
      },
    ]
  ]
];
