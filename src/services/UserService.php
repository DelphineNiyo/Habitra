<?php
// src/services/UserService.php

require_once __DIR__ . '/../models/User.php';

class UserService
{
    private PDO $db;

    /**
     * @param PDO $db  A PDO instance connected to the Habitra database.
     */
    public function __construct(PDO $db)
    {
        $this->db = $db;
    }

    /**
     * Register a new user.
     *
     * @throws Exception on validation or insertion failure.
     */
    public function register(
        string $firstName,
        string $lastName,
        string $username,
        string $email,
        string $password
    ): array {
        // 1) Check for existing email or username
        $check = $this->db->prepare(
            'SELECT id FROM users
             WHERE email = :email OR username = :username'
        );
        $check->execute([
            'email'    => $email,
            'username' => $username,
        ]);
        if ($check->fetch(PDO::FETCH_ASSOC)) {
            throw new Exception('Email or username already in use');
        }

        // 2) Hash the password
        $hash = password_hash($password, PASSWORD_DEFAULT);

        // 3) Insert the new user
        $ins = $this->db->prepare(
            'INSERT INTO users
               (first_name, last_name, username, email, password)
             VALUES
               (:fn, :ln, :u, :e, :p)'
        );
        $success = $ins->execute([
            'fn' => $firstName,
            'ln' => $lastName,
            'u'  => $username,
            'e'  => $email,
            'p'  => $hash,
        ]);
        if (! $success) {
            throw new Exception('Failed to create user');
        }

        // 4) Retrieve and return the created user
        $id = (int)$this->db->lastInsertId();
        $sel = $this->db->prepare(
            'SELECT id, first_name, last_name, username, email, created_at
             FROM users
             WHERE id = :id'
        );
        $sel->execute(['id' => $id]);
        $row = $sel->fetch(PDO::FETCH_ASSOC);
        if (! $row) {
            throw new Exception('User created but not found');
        }

        return (new User($row))->toArray();
    }

    /**
     * Verify credentials and return user data (without password).
     *
     * @throws Exception on invalid credentials.
     */
    public function login(string $email, string $password): array
    {
        // 1) Look up the user by email
        $stmt = $this->db->prepare(
            'SELECT id, first_name, last_name, username, email, password, created_at
             FROM users
             WHERE email = :email'
        );
        $stmt->execute(['email' => $email]);
        $row = $stmt->fetch(PDO::FETCH_ASSOC);

        if (! $row) {
            throw new Exception('Invalid credentials');
        }

        // 2) Verify the submitted password against the stored hash
        if (! password_verify($password, $row['password'])) {
            throw new Exception('Invalid credentials');
        }

        // 3) Remove the password field and return user data
        unset($row['password']);
        return $row;
    }
}