<?php

use craft\elements\Entry;
use craft\helpers\UrlHelper;

return [
    'endpoints' => [
        'courses/all.json' => function() {
            return [
                'elementType' => Entry::class,
                'criteria' => ['section' => 'courses'],
                'transformer' => function(Entry $entry) {
                    return [
                        'title' => $entry->title,
                    ];
                },
            ];
        },
    ]
];
