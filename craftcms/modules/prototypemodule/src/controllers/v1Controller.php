<?php
/**
 * prototype module for Craft CMS 3.x
 *
 * Prototyping a RESTful API using Craft 3 as a headless CMS.
 *
 * @link      https://kyleandrews.dev/
 * @copyright Copyright (c) 2019 Kyle Andrews
 */

namespace modules\prototypemodule\controllers;

use modules\prototypemodule\PrototypeModule;

use Craft;
use craft\web\Controller;
use craft\web\Session;

/**
 * @author    Kyle Andrews
 * @package   PrototypeModule
 * @since     1.0.0
 */
class V1Controller extends Controller
{

    // Protected Properties
    // =========================================================================

    /**
     * @var    bool|array Allows anonymous access to this controller's actions.
     *         The actions must be in 'kebab-case'
     * @access protected
     */
    protected $allowAnonymous = ['login'];

    // Public Methods
    // =========================================================================
    public function actionLogin()
    {
        $this->requirePostRequest();
        $this->requireAcceptsJson();
        $request = Craft::$app->getRequest();
        $response = PrototypeModule::$instance->userService->loginUser($request->getBodyParams());
        return json_encode($response);
    }
}
