<?php

require "vendor/autoload.php";

$app = new \Slim\App;

Predis\Autoloader::register();
$redis = new Predis\Client([
    'host'  => getenv('REDIS_HOST')
]);

$app->get('/count', function($request, $response) use ($redis) {
    $redis->incr('counter');
    $counter = $redis->get('counter');
    $response->getBody()->write($counter);
    return $response;
});

$app->get('/', function($request, $response) {
    $response->getBody()->write("Hello");
    return $response;
});

$app->group('/api', function() use ($app) {
    $app->get('/users', function() {
        return "3";
    });
});


$app->run();