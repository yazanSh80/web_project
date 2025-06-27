<?php
session_start();
require_once("dbconfig.inc.php");
require_once("Flat.php");
$pdo = db_connect();
if ($_SESSION['role'] !== 'customer') {
    echo "You are not authorized to proceed.";
    exit;
}

if (!isset($_SESSION['rent_info'])) {
    echo "Rent info is missing.";
    exit;
}

$rent_info = $_SESSION['rent_info'];
$reference = $rent_info['reference']; 
$user_id = $_SESSION['user_id']; 

$flat = Flat::getFlatByReference($pdo, $reference);

if (!$flat) {
    echo "Flat not found.";
    exit;
}

$stmt = $pdo->prepare("SELECT * FROM customers WHERE customer_id = :customer_id");
$stmt->execute([':customer_id' => $user_id]);
$customer = $stmt->fetch();

if (!$customer) {
    echo "Customer not found in the database.";
    exit;
}

$stmtUser = $pdo->prepare("SELECT username, name FROM users WHERE user_id = :uid");
$stmtUser->execute([':uid' => $user_id]);
$userData = $stmtUser->fetch();
$customerName = $userData ? $userData['name'] : $userData['username'];

$owner_id = $flat['owner_id'];

$title = "New Rental Request";
$body  = "Customer '{$customerName}' (ID: {$user_id}) has rented your flat (Ref: {$reference}) from {$rent_info['start_date']} to {$rent_info['end_date']}. Please review the rental details.";

$stmtMsg = $pdo->prepare("
    INSERT INTO messages 
      (sender_id, receiver_id, title, body, status) 
    VALUES 
      (:sender_id, :receiver_id, :title, :body, 'pending')
");
$stmtMsg->execute([
    ':sender_id'   => $user_id,
    ':receiver_id' => $owner_id,
    ':title'       => $title,
    ':body'        => $body
]);

header("Location: paymentConfirmation.php");
exit;
?>
