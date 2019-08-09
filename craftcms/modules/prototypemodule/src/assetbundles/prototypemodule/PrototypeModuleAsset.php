<?php
/**
 * prototype module for Craft CMS 3.x
 *
 * Prototyping a RESTful API using Craft 3 as a headless CMS.
 *
 * @link      https://kyleandrews.dev/
 * @copyright Copyright (c) 2019 Kyle Andrews
 */

namespace modules\prototypemodule\assetbundles\PrototypeModule;

use Craft;
use craft\web\AssetBundle;
use craft\web\assets\cp\CpAsset;

/**
 * @author    Kyle Andrews
 * @package   PrototypeModule
 * @since     1.0.0
 */
class PrototypeModuleAsset extends AssetBundle
{
    // Public Methods
    // =========================================================================

    /**
     * @inheritdoc
     */
    public function init()
    {
        $this->sourcePath = "@modules/prototypemodule/assetbundles/prototypemodule/dist";

        $this->depends = [
            CpAsset::class,
        ];

        $this->js = [
            'js/PrototypeModule.js',
        ];

        $this->css = [
            'css/PrototypeModule.css',
        ];

        parent::init();
    }
}
