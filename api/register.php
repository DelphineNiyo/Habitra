<?php
// api/register.php

// ─── 1) CORS & preflight ────────────────────────────────────────────────
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

// If this is a preflight request, just return 200 and stop
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
        !is_array($data) ||
        !isset(
            $data['firstName'],
            $data['lastName'],
            $data['username'],
            $data['email'],
            $data['password']
        )
    ) {
        http_response_code(400);
        echo json_encode(['error' => 'Missing required fields']);
        exit;
    }

    // ─── 5) Register the user ─────────────────────────────────────────────
    $svc  = new UserService($db);
    $user = $svc->register(
        $data['firstName'],
        $data['lastName'],
        $data['username'],
        $data['email'],
        $data['password']
    );

    // ─── 6) Respond with 201 + user JSON ─────────────────────────────────
    http_response_code(201);
    echo json_encode($user);

} catch (Exception $e) {
    http_response_code(400);
    echo json_encode(['error' => $e->getMessage()]);
}