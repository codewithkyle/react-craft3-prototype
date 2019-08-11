<?php

use craft\elements\Entry;
use craft\helpers\UrlHelper;

return [
    'endpoints' => [
        'courses.json' => function() {
            return [
                'elementType' => Entry::class,
                'criteria' => [
                    'section' => 'courses',
                    'with' => ['category'],
                ],
                'transformer' => function(Entry $entry) {
                    return [
                        'title' => $entry->title,
                        'description' => $entry->description,
                        'duration' => $entry->duration,
                        'points' => $entry->points,
                        'category' => $entry->category[0]->title,
                        'id' => $entry->id
                    ];
                },
            ];
        },
    ]
];
