<?php
// api/login_user.php

// ─── 1) CORS & preflight ────────────────────────────────────────────────
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

// ─── 2) JSON response header ────────────────────────────────────────────
header('Content-Type: application/json');

// ─── 3) Bootstrap DB & Service ──────────────────────────────────────────
require_once __DIR__ . '/db_config.php';
require_once __DIR__ . '/../src/services/UserService.php';

try {
    // ─── 4) Parse & validate JSON body ────────────────────────────────────
    $data = json_decode(file_get_contents('php://input'), true);
    if (
        !is_array($data)
        || !isset($data['email'], $data['password'])
    ) {
        http_response_code(400);
        echo json_encode(['error' => 'Missing email or password']);
        exit;
    }

    // ─── 5) Attempt login ─────────────────────────────────────────────────
    $svc  = new UserService($db);
    $user = $svc->login($data['email'], $data['password']);

    // ─── 6) Return user JSON ──────────────────────────────────────────────
    echo json_encode($user);

} catch (Exception $e) {
    http_response_code(401);
    echo json_encode(['error' => $e->getMessage()]);
}