<?php
session_start();
require_once("dbconfig.inc.php");
require_once("Flat.php");

$pdo = db_connect();

if (!isset($_SESSION['rent_info']) || !isset($_SESSION['user_id'])) {
    echo "Session data is missing.";
    exit;
}

$role = $_SESSION["role"];
$rent_info = $_SESSION['rent_info'];
$reference = $rent_info['reference'];

$flat = Flat::getFlatByReference($pdo, $reference);

if (!$flat) {
    echo "Flat not found.";
    exit;
}

$stmtOwner = $pdo->prepare("
    SELECT name 
    FROM users 
    WHERE user_id = :owner_id
");
$stmtOwner->execute([':owner_id' => $flat['owner_id']]);
$ownerData = $stmtOwner->fetch();
$ownerName = $ownerData ? $ownerData['name'] : "Unknown Owner";

$username = $_SESSION['username'] ?? 'Guest';
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payment Confirmation - <?= htmlspecialchars($reference) ?></title>
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

        <?php elseif ($role === "customer"): ?>
            <p><a href="searchFlat.php">Search Flats</a></p>
            <p><a href="rentedFlats.php">My Rentals</a></p>
            <p><a href="viewMessages.php">View Messages</a></p>
        <?php endif; ?>
    </section>
</nav>

<main>
    <h2>Payment Confirmation</h2>

    <section class="confirmation-info">
        <section class="flat-info">
            <h3>Flat Info</h3>
            <p><strong>Location:</strong> <?= htmlspecialchars($flat['location']) ?></p>
            <p><strong>Address:</strong> <?= htmlspecialchars($flat['address']) ?></p>
            <p><strong>Monthly Rent:</strong> $<?= htmlspecialchars($flat['rent']) ?></p>
        </section>

        <section class="owner-info">
            <h3>Owner Info</h3>
                <p><strong>Owner:</strong> <a href="ownerDetails.php?owner_id=<?= urlencode($flat['owner_id']) ?>"><?= htmlspecialchars($ownerName) ?></a></p>
        </section>

        <section class="rental-period">
            <h3>Rental Period</h3>
            <p><strong>Start Date:</strong> <?= htmlspecialchars($rent_info['start_date']) ?></p>
            <p><strong>End Date:</strong> <?= htmlspecialchars($rent_info['end_date']) ?></p>
        </section>

        <section class="payment-info">
            <h3>Payment Details</h3>
            <p><strong>Rental Duration:</strong> <?= htmlspecialchars($rent_info['months']) ?> months</p>
            <p><strong>Total Price:</strong> $<?= htmlspecialchars($rent_info['total_rent']) ?></p>
        </section>
    </section>

    <p><strong>Payment Status:</strong> Payment confirmed. Thank you for your payment!</p>
    <p><a href="main.php" class="btn">Go to Home</a></p>
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
