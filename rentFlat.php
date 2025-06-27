<?php
session_start();
require_once("dbconfig.inc.php");
require_once("Flat.php");
$pdo = db_connect();
$username = $_SESSION['username'] ?? 'Guest';
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'customer') {
    $_SESSION['redirect_after_login'] = "rentFlat.php?ref=" . $_GET['ref'];
    header("Location: logIn.php");
    exit;
}
$role = $_SESSION["role"];

if (!isset($_GET['ref'])) {
    echo "Flat reference not provided.";
    exit;
}

$reference = $_GET['ref'];
$flat = Flat::getFlatByReference($pdo, $reference);

if (!$flat) {
    echo "no flat.";
    exit;
}

$owner_id = $flat['owner_id']; 

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

$start_date = new DateTime($_POST['start_date']);
$end_date = new DateTime($_POST['end_date']);

$interval = $start_date->diff($end_date);

$months = ($interval->y * 12) + $interval->m;
if ($interval->d > 0) {
    $months += 1;  
}

$total_rent = $months * $flat['rent'];

$stmtMsg = $pdo->prepare("INSERT INTO messages (sender_id, receiver_id, title, body, status, is_read, date_sent) 
VALUES (:sender, :receiver, :title, :body, 'pending', 0, NOW())");

$stmtMsg->execute([
    ':sender' => $_SESSION['user_id'],
    ':receiver' => $owner_id,
    ':title' => 'Rental Request',
    ':body' => "I would like to rent flat Ref: {$flat['reference_number']} from {$_POST['start_date']} to {$_POST['end_date']}."
]);

$_SESSION['rent_info'] = [
    'flat_id' => $flat['flat_id'],
    'reference' => $flat['reference_number'],
    'start_date' => $_POST['start_date'],
    'end_date' => $_POST['end_date'],
    'price' => $flat['rent'],
    'owner_id' => $owner_id,
    'months' => $months,
    'total_rent' => $total_rent
];

header("Location: confirmRent.php");
exit;

}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Rent Flat - <?= htmlspecialchars($reference) ?></title>
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
        <?php if ($role === "customer"): ?>
            <p><a href="searchFlat.php">Search Flats</a></p>
            <p><a href="rentedFlats.php">My Rentals</a></p>
            <p><a href="viewMessages.php">View Messages</a></p>
        <?php endif; ?>
    </section>
</nav>

<main>
    <h2>Rent Flat - Ref <?= htmlspecialchars($reference) ?></h2>

    <form method="post" action="">
        <fieldset>
            <legend>Flat Info</legend>
            <p><strong>Location:</strong> <?= htmlspecialchars($flat['location']) ?></p>
            <p><strong>Address:</strong> <?= htmlspecialchars($flat['address']) ?></p>
            <p><strong>Monthly Rent:</strong> $<?= htmlspecialchars($flat['rent']) ?></p>
            <p><strong>Owner:</strong> <?= htmlspecialchars($flat['owner_name']) ?></p>
        </fieldset>

        <fieldset>
            <legend>Rental Period</legend>
            <label for="start_date">Start Date:</label>
            <input type="date" name="start_date" id="start_date" required><br><br>
            <label for="end_date">End Date:</label>
            <input type="date" name="end_date" id="end_date" required>
        </fieldset>

        <button type="submit" class="continue-button">Continue to Payment</button>
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
