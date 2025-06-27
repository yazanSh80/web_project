<?php
session_start();
require_once("dbconfig.inc.php");
$pdo = db_connect();
$username = $_SESSION["username"];
$role = $_SESSION["role"];

if (!isset($_GET['customer_id'])) {
    echo "Customer not found.";
    exit;
}

$customer_id = $_GET['customer_id'];

$stmt = $pdo->prepare("SELECT * FROM users WHERE user_id = :customer_id");
$stmt->execute([':customer_id' => $customer_id]);
$user = $stmt->fetch();

if (!$user) {
    echo "Customer not found.";
    exit;
}

// Fetch customer payment info if manager
$customer = null;
if ($role === 'manager') {
    $stmt_customer = $pdo->prepare("SELECT * FROM customers WHERE customer_id = :customer_id");
    $stmt_customer->execute([':customer_id' => $customer_id]);
    $customer = $stmt_customer->fetch();
}

if (!$user) {
    echo "Customer not found.";
    exit;
}

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Details</title>
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

        <?php if ($role === "owner"): ?>
            <p><a href="offerFlat.php">Offer Flat</a></p>
            <p><a href="viewMessages.php">View Messages</a></p>

        <?php elseif ($role === "manager"): ?>
            <p><a href="managerApproval.php">Approve Flats</a></p>
            <p><a href="viewMessages.php">View Messages</a></p>
            <p><a href="managerInquire.php">View Flats</a></p>
        <?php endif; ?>
    </section>
</nav>


<main>
    <h2>Customer Information</h2>

    <section class="user-card">
        <h3><?= htmlspecialchars($user['name']) ?></h3>
        <p><strong>City:</strong> <?= htmlspecialchars($user['address']) ?></p>
        <p><strong>Phone:</strong> <?= htmlspecialchars($user['mobile']) ?></p>
        <p><strong>Email:</strong> <a href="mailto:<?= htmlspecialchars($user['email']) ?>"><?= htmlspecialchars($user['email']) ?></a></p>
        <?php if ($role === 'manager' && $customer): ?>
<fieldset>
    <legend>Payment Information</legend>
    <p><strong>Payment Card:</strong> <?= htmlspecialchars($customer['payment_card']) ?></p>
    <p><strong>CVV:</strong> <?= htmlspecialchars($customer['cvv']) ?></p>
    <p><strong>Expiry Date:</strong> <?= htmlspecialchars($customer['expiry_date']) ?></p>
</fieldset>
<?php endif; ?>

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
