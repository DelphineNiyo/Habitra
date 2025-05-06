<?php 
namespace Habitra\Config; 
use PDO; 
class Database { 
public static function connect() : PDO { 
$dotenv = \Dotenv\Dotenv::createImmutable(__DIR__ . '/../../'); 
$dotenv->load(); 
$dsn = 
"mysql:host={$_ENV['DB_HOST']};dbname={$_ENV['DB_NAME']};charset=utf8mb4"; 
return new PDO($dsn, $_ENV['DB_USER'], $_ENV['DB_PASS'], [ 
PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION 
]); 
} 
}
?>