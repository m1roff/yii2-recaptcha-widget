Google reCAPTCHA widget for Yii2
================================
Based on Google reCaptcha API 2.0 and 3.0.

Forked version of https://packagist.org/packages/himiklab/yii2-recaptcha-widget.

[![license](https://img.shields.io/badge/License-MIT-yellow.svg)]()

Installation
------------
The preferred way to install this extension is through [composer](http://getcomposer.org/download/).

* Either run

```
composer require --prefer-dist "m1roff/yii2-recaptcha-widget" "^1.0"
```


* [Sign up for an reCAPTCHA API keys](https://www.google.com/recaptcha/admin/create).

* Configure the component in your configuration file (web.php). The parameters siteKey and secret are optional.
But if you leave them out you need to set them in every validation rule and every view where you want to use this widget.
If a siteKey or secret is set in an individual view or validation rule that would overrule what is set in the config.

```php
'components' => [
    ReCaptchaConfig::COMPONENT_ID => [
        'class' => ReCaptchaConfig::class,
        'siteKeyV2' => 'your siteKey v2',
        'secretV2' => 'your secret key v2',
        'siteKeyV3' => 'your siteKey v3',
        'secretV3' => 'your secret key v3',
    ],
    ...
```

or use DI container:

```php
'container' => [
    'definitions' => [
        m1roff\yii2\recaptcha\ReCaptcha2::class => function ($container, $params, $config) {
            return new m1roff\yii2\recaptcha\ReCaptcha2(
                'your siteKey v2',
                '', // default
                $config
            );
        },
        m1roff\yii2\recaptcha\ReCaptchaValidator2::class => function ($container, $params, $config) {
            return new m1roff\yii2\recaptcha\ReCaptchaValidator2(
                'your secret key v2',
                '', // default
                null, // default
                null, // default
                $config
            );
        },
    ],
],
```

* Add `ReCaptchaValidator2` or `ReCaptchaValidator3` in your model, for example:

v2
```php
public $reCaptcha;

public function rules()
{
  return [
      // ...
      [['reCaptcha'], \m1roff\yii2\recaptcha\ReCaptchaValidator2::class,
        'secret' => 'your secret key', // unnecessary if reСaptcha is already configured
        'uncheckedMessage' => 'Please confirm that you are not a bot.'],
  ];
}
```

v3
```php
public $reCaptcha;

public function rules()
{
  return [
      // ...
      [['reCaptcha'], \m1roff\yii2\recaptcha\ReCaptchaValidator3::class,
        'secret' => 'your secret key', // unnecessary if reСaptcha is already configured
        'threshold' => 0.5,
        'action' => 'homepage',
      ],
  ];
}
```

Usage
-----
For example:

v2
```php
<?= $form->field($model, 'reCaptcha')->widget(
    \m1roff\yii2\recaptcha\ReCaptcha2::class,
    [
        'siteKey' => 'your siteKey', // unnecessary is reCaptcha component was set up
    ]
) ?>
```

v3
```php
<?= $form->field($model, 'reCaptcha')->widget(
    \m1roff\yii2\recaptcha\ReCaptcha3::class,
    [
        'siteKey' => 'your siteKey', // unnecessary is reCaptcha component was set up
        'action' => 'homepage',
    ]
) ?>
```

or

v2
```php
<?= \m1roff\yii2\recaptcha\ReCaptcha2::widget([
    'name' => 'reCaptcha',
    'siteKey' => 'your siteKey', // unnecessary is reCaptcha component was set up
    'widgetOptions' => ['class' => 'col-sm-offset-3'],
]) ?>
```

v3
```php
<?= \m1roff\yii2\recaptcha\ReCaptcha3::widget([
    'name' => 'reCaptcha',
    'siteKey' => 'your siteKey', // unnecessary is reCaptcha component was set up
    'action' => 'homepage',
    'widgetOptions' => ['class' => 'col-sm-offset-3'],
]) ?>
```

* NOTE: Please disable ajax validation for ReCaptcha field!

Resources
---------
* [Google reCAPTCHA v2](https://developers.google.com/recaptcha)
* [Google reCAPTCHA v3](https://developers.google.com/recaptcha/docs/v3)
