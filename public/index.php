<?php
// ──────────────────────────────────────────────────────────────────────────────
// 1) CORS & JSON headers
// ──────────────────────────────────────────────────────────────────────────────
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

// ──────────────────────────────────────────────────────────────────────────────
// 2) Load your controllers
// ──────────────────────────────────────────────────────────────────────────────
require_once __DIR__ . '/../src/controllers/UserController.php';
require_once __DIR__ . '/../src/controllers/HabitController.php';

// ──────────────────────────────────────────────────────────────────────────────
// 3) Figure out your “route” dynamically
// ──────────────────────────────────────────────────────────────────────────────
$uri        = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$scriptName = $_SERVER['SCRIPT_NAME'];               // e.g. "/habitra_api/public/index.php"
$base       = rtrim(dirname($scriptName), '/\\');    // e.g. "/habitra_api/public"
$route      = substr($uri, strlen($base));           // may be "/register" or "/index.php/register"

// ──────────────────────────────────────────────────────────────────────────────
// Strip out an "/index.php" prefix if present
// ──────────────────────────────────────────────────────────────────────────────
if (strpos($route, '/index.php') === 0) {
    $route = substr($route, strlen('/index.php'));
}

// Normalize to e.g. "/register" or "/" 
$route  = '/' . trim($route, '/');
$method = $_SERVER['REQUEST_METHOD'];

// ──────────────────────────────────────────────────────────────────────────────
// DEBUG: uncomment to log what’s being matched
// error_log("URI={$uri} | BASE={$base} | ROUTE={$route} | METHOD={$method}");
// ──────────────────────────────────────────────────────────────────────────────

// ──────────────────────────────────────────────────────────────────────────────
// 4) Dispatch
// ──────────────────────────────────────────────────────────────────────────────
switch (true) {
    case $route === '/register' && $method === 'POST':
        (new UserController())->register();
        break;

    case $route === '/login' && $method === 'POST':
        (new UserController())->login();
        break;

    case $route === '/habits' && $method === 'GET':
        (new HabitController())->index();
        break;

    case $route === '/habits' && $method === 'POST':
        (new HabitController())->create();
        break;

    case preg_match('#^/habits/(\d+)$#', $route, $m) && $method === 'PUT':
        (new HabitController())->update((int)$m[1]);
        break;

    case preg_match('#^/habits/(\d+)$#', $route, $m) && $method === 'DELETE':
        (new HabitController())->delete((int)$m[1]);
        break;

    default:
        // If the path exists but the verb is wrong, send 405
        $allowed = [
            '/register' => ['POST'],
            '/login'    => ['POST'],
            '/habits'   => ['GET','POST'],
        ];
        if (isset($allowed[$route]) && !in_array($method, $allowed[$route])) {
            http_response_code(405);
            echo json_encode(['error' => 'Method not allowed']);
        } else {
            http_response_code(404);
            echo json_encode(['error' => 'Route not found']);
        }
        break;
}