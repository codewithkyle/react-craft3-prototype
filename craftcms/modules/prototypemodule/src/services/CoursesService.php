<?php
/**
 * prototype module for Craft CMS 3.x
 *
 * Prototyping a RESTful API using Craft 3 as a headless CMS.
 *
 * @link      https://kyleandrews.dev/
 * @copyright Copyright (c) 2019 Kyle Andrews
 */

namespace modules\prototypemodule\services;

use modules\prototypemodule\PrototypeModule;

use Craft;
use craft\base\Component;

/**
 * @author    Kyle Andrews
 * @package   PrototypeModule
 * @since     1.0.0
 */
class CoursesService extends Component
{
    // Public Methods
    // =========================================================================

    /*
     * @return mixed
     */
    public function exampleService()
    {
        $result = 'something';

        return $result;
    }
}
