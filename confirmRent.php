<?php
session_start();
require_once("dbconfig.inc.php");
require_once("Flat.php");
$pdo = db_connect();
if (!isset($_SESSION['rent_info'])) {
    echo "Flat reference not provided.";
    exit;
}
// return the rent information and  the referance to put it in the header . the role for the same cause
$rent_info = $_SESSION['rent_info'];
$reference = $rent_info['reference']; 
$role = $_SESSION["role"];
// the method to return the flat information from the data base
$flat = Flat::getFlatByReference($pdo, $reference);

if (!$flat) {
    echo "Flat not found.";
    exit;
}
// be sure that the role is customer . because there is no available for other role to go to this page
$username = $_SESSION['username'] ?? 'Guest'; 
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'customer') {
    $_SESSION['redirect_after_login'] = "confirmRent.php?ref=" . $reference;
    header("Location: logIn.php");
    exit;
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Confirm Rent - <?= htmlspecialchars($reference) ?></title>
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
        <p><a href="searchFlat.php">Search Flats</a></p>
        <p><a href="viewMessages.php">View Messages</a></p>
    </section>
</nav>


<main>
    <h2>Confirm Rent - Ref <?= htmlspecialchars($reference) ?></h2>

    <fieldset>
        <legend>Flat Info</legend>
        <p><strong>Location:</strong> <?= htmlspecialchars($flat['location']) ?></p>
        <p><strong>Address:</strong> <?= htmlspecialchars($flat['address']) ?></p>
        <p><strong>Rental Duration:</strong> <?= $_SESSION['rent_info']['months'] ?> months</p>
        <p><strong>Monthly Rent:</strong> $<?= $_SESSION['rent_info']['price'] ?></p>
        <p><strong>Total Rent:</strong> $<?= $_SESSION['rent_info']['total_rent'] ?></p>
        <p><strong>Owner:</strong> <?= htmlspecialchars($flat['owner_name']) ?></p>
    </fieldset>

    <fieldset>
        <legend>Rental Period</legend>
        <p><strong>Start Date:</strong> <?= htmlspecialchars($rent_info['start_date']) ?></p>
        <p><strong>End Date:</strong> <?= htmlspecialchars($rent_info['end_date']) ?></p>
    </fieldset>

    <form method="post" action="processPayment.php">
        <fieldset>
            <legend>Payment</legend>
            <p><strong>Total Price:</strong> $<?= htmlspecialchars($_SESSION['rent_info']['total_rent']) ?></p>
            <button type="submit">Confirm and Proceed to Payment</button>
        </fieldset>
    </form>
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
