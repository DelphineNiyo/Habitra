<?php
require_once __DIR__ . '/../services/UserService.php';

class UserController {
    private $svc;

    public function __construct() {
        $this->svc = new UserService();
    }

    public function register() {
        $data = json_decode(file_get_contents('php://input'), true);

        if (
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
            return;
        }

        try {
            $user = $this->svc->register($data);
            http_response_code(201);
            echo json_encode([
                'id'          => $user['id'],
                'first_name'  => $user['first_name'],
                'last_name'   => $user['last_name'],
                'username'    => $user['username'],
                'email'       => $user['email'],
                'created_at'  => $user['created_at'],
            ]);
        } catch (Exception $e) {
            http_response_code(400);
            echo json_encode(['error' => $e->getMessage()]);
        }
    }

    public function login() {
        $data = json_decode(file_get_contents('php://input'), true);

        if (!isset($data['email'], $data['password'])) {
            http_response_code(400);
            echo json_encode(['error' => 'Missing email or password']);
            return;
        }

        try {
            $user = $this->svc->login($data);
            echo json_encode($user);
        } catch (Exception $e) {
            http_response_code(401);
            echo json_encode(['error' => $e->getMessage()]);
        }
    }
}