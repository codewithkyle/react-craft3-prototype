<?php

return [
    '*' => [
        'defaultWeekStartDay' => 1,
        'omitScriptNameInUrls' => true,
        'cpTrigger' => 'webmaster',
        'securityKey' => getenv('SECURITY_KEY'),
        'useProjectConfigFile' => true,
        'enableCsrfProtection' => false,
    ],
    'dev' => [
        'devMode' => true,
    ],
    'staging' => [
        'allowAdminChanges' => true,
    ],
    'production' => [
        'allowAdminChanges' => false,
    ],
];
