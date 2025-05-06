<?php
// src/models/User.php

class User
{
    public int    $id;
    public string $first_name;
    public string $last_name;
    public string $username;
    public string $email;
    public string $created_at;

    /**
     * Construct from a database row (assoc array).
     */
    public function __construct(array $row)
    {
        $this->id         = (int)$row['id'];
        $this->first_name = $row['first_name'];
        $this->last_name  = $row['last_name'];
        $this->username   = $row['username'];
        $this->email      = $row['email'];
        $this->created_at = $row['created_at'];
    }

    /**
     * Convert to an associative array for JSON encoding.
     */
    public function toArray(): array
    {
        return [
            'id'         => $this->id,
            'first_name' => $this->first_name,
            'last_name'  => $this->last_name,
            'username'   => $this->username,
            'email'      => $this->email,
            'created_at' => $this->created_at,
        ];
    }
}