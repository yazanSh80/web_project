<?php
// dbconfig.in.php

// Database connection details
$db_host = 'localhost';
$db_name = 'web1220906_birzeit_flat_1220906';
$db_user = 'web1220906_dbuser';
$db_pass = 'Yy@102030';

function db_connect(){
    global $db_host,$db_name,$db_user,$db_pass;
    
    try {
        // Create a new PDO instance
        $pdo = new PDO("mysql:host=$db_host;dbname=$db_name", $db_user, $db_pass);
        // Set the PDO error mode to exception
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        return $pdo;
    } catch (PDOException $e) {
        // Handle connection error
        echo 'Connection failed: ' . $e->getMessage();
        exit;
    }
}

?>