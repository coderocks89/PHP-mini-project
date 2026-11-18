<?php
// Database Connection Configuration
$host = "localhost";
$user = "root";
$pass = "";
$dbname = "online_voting_db";

$conn = new mysqli($host, $user, $pass, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
?>
