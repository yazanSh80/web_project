<?php
session_start();
require_once("dbconfig.inc.php");
$pdo = db_connect();
$username = $_SESSION["username"];

if ($_SESSION['role'] !== 'owner') {
    echo "You are not authorized to approve or reject requests.";
    exit;
}
$role = $_SESSION["role"];

$message_id = $_GET['message_id'];
$stmt = $pdo->prepare("SELECT * FROM messages WHERE message_id = :message_id");
$stmt->execute([':message_id' => $message_id]);
$message = $stmt->fetch();

if (!$message) {
    echo "Message not found.";
    exit;
}

$flat_reference = null;
if (preg_match("/Ref:\s*(\d+)/", $message['body'], $matches)) {
    $flat_reference = $matches[1];
}

$stmtFlat = $pdo->prepare("SELECT * FROM flats WHERE reference_number = :ref");
$stmtFlat->execute([':ref' => $flat_reference]);
$flat = $stmtFlat->fetch();

if (!$flat) {
    echo "Flat not found.";
    exit;
}

$start_date = date("Y-m-d");
$end_date = date("Y-m-d", strtotime("+6 months"));

if (preg_match("/from\s+([0-9\-]+)\s+to\s+([0-9\-]+)/", $message['body'], $matches)) {
    $start_date = $matches[1];
    $end_date = $matches[2];
}

if (isset($_POST['approve'])) {

    $stmt = $pdo->prepare("UPDATE messages SET status = 'approved' WHERE message_id = :message_id");
    $stmt->execute([':message_id' => $message_id]);

    $stmt = $pdo->prepare("UPDATE flats SET is_rented = 1 WHERE reference_number = :ref");
    $stmt->execute([':ref' => $flat_reference]);

    $stmt = $pdo->prepare("INSERT INTO rentals (flat_id, customer_id, start_date, end_date, total_amount) 
        VALUES (:flat_id, :customer_id, :start_date, :end_date, :total_amount)");
    $stmt->execute([
        ':flat_id' => $flat['flat_id'],
        ':customer_id' => $message['sender_id'],
        ':start_date' => $start_date,
        ':end_date' => $end_date,
        ':total_amount' => $flat['price']
    ]);

    $customer_id = $message['sender_id'];

    $stmtMsg = $pdo->prepare("INSERT INTO messages (sender_id, receiver_id, title, body, status, is_read, date_sent) 
        VALUES (:sender, :receiver, :title, :body, 'approved', 0, NOW())");

    $message_text = "Your rental request for flat Ref: $flat_reference has been approved.";

    $stmtMsg->execute([
        ':sender' => $_SESSION['user_id'], 
        ':receiver' => $customer_id,
        ':title' => 'Rental Request Update',
        ':body' => $message_text
    ]);


} elseif (isset($_POST['reject'])) {

    $stmt = $pdo->prepare("UPDATE messages SET status = 'rejected' WHERE message_id = :message_id");
    $stmt->execute([':message_id' => $message_id]);

    $customer_id = $message['sender_id'];

    $stmtMsg = $pdo->prepare("INSERT INTO messages (sender_id, receiver_id, title, body, status, is_read, date_sent) 
        VALUES (:sender, :receiver, :title, :body, 'rejected', 0, NOW())");

    $message_text = "Your rental request for flat Ref: $flat_reference has been rejected.";

    $stmtMsg->execute([
        ':sender' => $_SESSION['user_id'], 
        ':receiver' => $customer_id,
        ':title' => 'Rental Request Update',
        ':body' => $message_text
    ]);
    header("Location: viewMessages.php");
    exit;
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Owner Approval</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

<header class="main-header">
    <img src="images/al sharif.png" alt="Logo" class="logo">

    <a href="main.php" class="nav-link">Home</a>
    <h1 class="system-title">Al Sharif Flat Rent</h1>
    <a href="aboutUs.php" class="nav-link">About Us</a>

    <?php if ($role === "owner" || $role === "customer"): ?>
        <a href="userProfile.php" class="nav-link">
            <img src="images/user.png" alt="User Icon" class="header-user-photo">
            <?= htmlspecialchars($username) ?>
        </a>
    <?php endif; ?>

    <?php if (isset($_SESSION['user_id'])): ?>
        <a href="logout.php" class="logout-button">Logout</a>
    <?php else: ?>
        <a href="signup.php" class="logout-button">Register</a>
    <?php endif; ?>
</header>

<nav>
  <section>
    <p><strong>Navigation</strong></p>
    <p><a href="main.php">Home Page</a></p>
    <p><a href="aboutUs.php">About Us</a></p>
    <p><a href="offerFlat.php" class="active">Offer Flat</a></p>
    <p><a href="viewMessages.php">View Messages</a></p>
  </section>
</nav>

<main>
    <h2>Owner Approval</h2>

    <section class="message-details">
        <p><strong>Message from Tenant:</strong> <?= htmlspecialchars($message['body']) ?></p>
        <p><strong>Status:</strong> <?= htmlspecialchars($message['status']) ?></p>
    </section>

    <section class="approval-actions form-box">
        <form method="post" action="">
            <button type="submit" name="approve" class="btn-approve">Approve</button>
            <button type="submit" name="reject" class="btn-reject">Reject</button>
        </form>
    </section>
</main>

<footer>
  <section>
    <img src="images/al sharif.png" alt="Logo" class="footer-logo">
  </section>
  <section class="footer-text">
    <p>&copy; Al Sharif Flat Rent. All rights reserved.</p>
    <address>
      <p><em>Email:</em> alshareefy99@gmail.com</p>
      <p><em>Address:</em> School Street, Kafr Aqab</p>
      <p><em>Phone:</em> 0532304296</p>
    </address>
  </section>
</footer>

</body>
</html>
