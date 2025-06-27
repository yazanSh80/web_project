<?php
session_start();
require_once("dbconfig.inc.php");
$pdo = db_connect();
$username = $_SESSION['username'] ?? 'Guest';
$role = $_SESSION['role'] ?? 'Guest';

$success_message = '';
$error_message = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = htmlspecialchars($_POST['name']);
    $subject_input = htmlspecialchars($_POST['subject']);
    $message_input = htmlspecialchars($_POST['message']);

    $from_email = "1220906@student.birzeit.edu";
    $to_email = "alshareefy99@gmail.com";
    $subject = "Contact Us - $subject_input";

    $message_body = "You have received a new message from Contact Us form:\n\n";
    $message_body .= "Name: {$name}\n";
    $message_body .= "Subject: {$subject_input}\n\n";
    $message_body .= "Message:\n{$message_input}\n";

    $headers = "From: $from_email\r\n";
    $headers .= "Reply-To: $from_email\r\n";

    if (mail($to_email, $subject, $message_body, $headers)) {
        $success_message = "Your message has been sent successfully!";
    } else {
        $error_message = "Failed to send the message. Please try again later.";
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>About Us - Al Sharif Flat Rent</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<header class="main-header">
    <img src="images/al sharif.png" alt="Logo" class="logo">

    <a href="main.php" class="nav-link">Home</a>
    <h1 class="system-title">Al Sharif Flat Rent</h1>
    <a href="aboutUs.php" class="nav-link active">About Us</a>

    <?php if ($role === "owner" || $role === "customer"): ?>
        <a href="userProfile.php" class="nav-link">
            <img src="images/user.png" alt="User Icon" class="header-user-photo">
            <?= htmlspecialchars($username) ?>
        </a>
    <?php else: ?>  
        <a href="logIn.php" class="nav-link">Login</a>
        <a href="signup.php" class="nav-link">Sign Up</a>  
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
        <p><a href="aboutUs.php" class="active">About Us</a></p>

        <?php if ($role === "owner"): ?>
            <p><a href="offerFlat.php">Offer Flat</a></p>
            <p><a href="viewMessages.php">View Messages</a></p>

        <?php elseif ($role === "manager"): ?>
            <p><a href="managerApproval.php">Approve Flats</a></p>
            <p><a href="viewMessages.php">View Messages</a></p>
            <p><a href="managerInquire.php">View Flats</a></p>

        <?php elseif ($role === "customer"): ?>
            <p><a href="searchFlat.php">Search Flats</a></p>
            <p><a href="rentedFlats.php">My Rentals</a></p>
            <p><a href="viewMessages.php">View Messages</a></p>
        <?php endif; ?>
    </section>
</nav>

<main>
    <h2>About Us</h2>
    <p>Welcome to Al Sharif Flat Rent! We provide the best flats for rent in the area with trusted owners and customers. Our goal is to make the renting process easy and transparent for everyone.</p>
    <p>We value trust, quality, and customer satisfaction.</p><br>
    <p>For inquiries, please contact us at: alshareefy99@gmail.com</p>
    <br><p>Phone: 0532304296</p>
    
</main>

<footer>
    <section>
        <img src="images/al sharif.png" alt="Logo" class="footer-logo">
    </section>
    <section class="footer-text">
        <p>&copy; 2025 Al Sharif Flat Rent. All rights reserved.</p>
        <address>
            <p><em>Email:</em> alshareefy99@gmail.com</p>
            <p><em>Address:</em> School Street, Kafr Aqab</p>
            <p><em>Phone:</em> 0532304296</p>
        </address>
    </section>
</footer>

</body>
</html>
