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
use craft\elements\User;

/**
 * @author    Kyle Andrews
 * @package   PrototypeModule
 * @since     1.0.0
 */
class UserService extends Component
{
    // Public Methods
    // =========================================================================

    /*
     * @return mixed
     */
    public function loginUser(Array $params)
    {
        $response['success'] = true;
    
        $loginName = $params['email'];
        $password = $params['password'];
        
        $user = Craft::$app->getUsers()->getUserByUsernameOrEmail($loginName);
    
        if(!$user){
            $response['success'] = false;
            $response['errors'] = [
                '0' => [
                    'id' => 'email',
                    'message' => 'Incorrect email address.'
                ]
            ];
            return $response;
        }
    
        // Make sure they can be validated
        if ($user->password === null) {
            // Delay again to match $user->authenticate()'s delay
            Craft::$app->getSecurity()->validatePassword('p@ss1w0rd', '$2y$13$nj9aiBeb7RfEfYP3Cum6Revyu14QelGGxwcnFUKXIrQUitSodEPRi');
            $response['success'] = false;
            $response['errors'] = [
                '0' => [
                    'id' => 'password',
                    'message' => 'Incorrect password.'
                ]
            ];
            return $response;
        }
    
        // Did they submit a valid password, and is the user capable of being logged-in?
        if (!$user->authenticate($password)) {
            $response['success'] = false;
            $response['errors'] = [
                '0' => [
                    'id' => 'password',
                    'message' => 'Incorrect password.'
                ]
            ];
            return $response;
        }
    
        // Try logging them in
        if (!Craft::$app->getUser()->login($user, 1)) {
            // Unknown error
            $response['success'] = false;
            $response['errors'] = [
                '0' => [
                    'id' => 'email',
                    'message' => 'An unknown error occurred.'
                ],
                '1' => [
                    'id' => 'password',
                    'message' => 'An unknown error occurred.'
                ]
            ];
            return $response;
        }

        $token = Craft::$app->request->getCsrfToken();
        $response['token'] = $token;
        $user->setFieldValue('sessionToken', $token);
        Craft::$app->getElements()->saveElement($user, true);
    
        return $response;    
    }

    public function logoutUser(Array $params)
    {
        $response['success'] = true;
        $response['errors'] = [];

        if (!isset($params['token']))
        {
            $response['success'] = false;
            $response['errors'][] = [ 'message' => 'Missing token' ];
            return $response;
        }

        $user = User::find()->sessionToken($params['token'])->one();

        if (empty($user))
        {
            $response['success'] = false;
            $response['errors'][] = [ 'message' => 'Invalid token' ];
            return $response;
        }

        $user->setFieldValue('sessionToken', null);
        Craft::$app->getElements()->saveElement($user, true);

        return $response;
    }

    public function signupUser(Array $params)
    {
        $response['success'] = true;
        $response['errors'] = [];

        if (!isset($params['name']))
        {
            $response['success'] = false;
            $response['errors'][] = [
                'id' => 'name',
                'message' => 'This field is required.'
            ];
        }

        if (!isset($params['email']))
        {
            $response['success'] = false;
            $response['errors'][] = [
                'id' => 'email',
                'message' => 'This field is required.'
            ];
        }

        if (!isset($params['password']))
        {
            $response['success'] = false;
            $response['errors'][] = [
                'id' => 'password',
                'message' => 'This field is required.'
            ];
        }

        if (!$response['success'])
        {
            return $response;
        }

        $name = $params['name'];
        $email = $params['email'];
        $password = $params['password'];

        $existingUser = Craft::$app->getUsers()->getUserByUsernameOrEmail($email);
        if(!empty($existingUser))
        {
            $response['success'] = false;
            $response['errors'][] = [
                'id' => 'email',
                'message' => 'Email address already exists. Try signing in.'
            ];
            return $response;
        }

        $user = new User();
        $user->newPassword = $password;
        $user->email = $email;
        $user->username = $user->email;
        $user->firstName = $name;
        $token = Craft::$app->request->getCsrfToken();
        $response['token'] = $token;
        $user->setFieldValue('sessionToken', $token);

        if (!Craft::$app->getElements()->saveElement($user, true))
        {
            $response['success'] = false;
            $response['errors'][] = [
                'message' => 'Failed to create account, please try again later.'
            ];
            return $response;
        }

        Craft::$app->getUsers()->activateUser($user);

        return $response;
    }

    public function getCourses(Array $params)
    {
        $response['success'] = true;
        $response['errors'] = [];

        if (!isset($params['token']))
        {
            $response['success'] = false;
            $response['errors'][] = [ 'message' => 'Missing token' ];
            return $response;
        }

        $user = User::find()->sessionToken($params['token'])->one();

        if (empty($user))
        {
            $response['success'] = false;
            $response['errors'][] = [ 'message' => 'Invalid token' ];
            return $response;
        }

        $response['courses'] = json_decode($user->getFieldValue('courses'));

        return $response;
    }
}
