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
    protected $allowAnonymous = true;

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

    public function actionLogout()
    {
        $this->requirePostRequest();
        $this->requireAcceptsJson();
        $request = Craft::$app->getRequest();
        $response = PrototypeModule::$instance->userService->logoutUser($request->getBodyParams());
        return json_encode($response);
    }

    public function actionSignup()
    {
        $this->requirePostRequest();
        $this->requireAcceptsJson();
        $request = Craft::$app->getRequest();
        $response = PrototypeModule::$instance->userService->signupUser($request->getBodyParams());
        return json_encode($response);
    }

    public function actionGetUserCourses()
    {
        $this->requirePostRequest();
        $this->requireAcceptsJson();
        $request = Craft::$app->getRequest();
        $response = PrototypeModule::$instance->userService->getCourses($request->getBodyParams());
        return json_encode($response);
    }

    public function actionPurchaseCourse()
    {
        $this->requirePostRequest();
        $this->requireAcceptsJson();
        $request = Craft::$app->getRequest();
        $response = PrototypeModule::$instance->userService->purchaseCourse($request->getBodyParams());
        return json_encode($response);
    }
}
