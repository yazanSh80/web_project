<?php
session_start();
require_once("dbconfig.inc.php");
require_once("Flat.php");
$pdo = db_connect();

$username = $_SESSION['username'] ?? 'Guest';
$role = $_SESSION['role'] ?? 'Guest';

if (!isset($_GET['ref'])) {
    echo "No flat reference provided.";
    exit;
}

$reference = $_GET['ref'];
$flat = Flat::getFlatByReference($pdo, $reference);

if (!$flat) {
    echo "Flat not found.";
    exit;
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Flat Details - <?= htmlspecialchars($reference) ?></title>
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

        <?php elseif ($role === "Guest"): ?>
            <p><a href="searchFlat.php">Search Flats</a></p>
            <p><a href="logIn.php">Log In</a></p>
        <?php endif; ?>
    </section>
</nav>


<main class="flatcard">
    <h2>Flat Details - Ref <?= htmlspecialchars($reference) ?></h2>

    <section class="photos">
        <?php $photoNumber = 1; ?>
        <?php foreach ($flat['photos'] as $photo): ?>
            <figure>
                <img src="images/<?= htmlspecialchars($photo) ?>" alt="Flat Photo <?= $photoNumber ?>" class="flat-photo">
                <figcaption>Photo <?= $photoNumber ?></figcaption>
            </figure>
            <?php $photoNumber++; ?>
        <?php endforeach; ?>
    </section>


    <section class="description">
        <p><strong>Address:</strong> <?= htmlspecialchars($flat['address']) ?></p>
        <p><strong>Price:</strong> $<?= isset($flat['rent']) ? htmlspecialchars($flat['rent']) : 'N/A' ?></p>
        <p><strong>Conditions:</strong> <?= htmlspecialchars($flat['conditions']) ?></p>
        <p><strong>Bedrooms:</strong> <?= htmlspecialchars($flat['bedrooms']) ?></p>
        <p><strong>Bathrooms:</strong> <?= htmlspecialchars($flat['bathrooms']) ?></p>
        <p><strong>Size:</strong> <?= htmlspecialchars($flat['size_sqm']) ?> m²</p>
        <p><strong>Heating:</strong> <?= $flat['heating'] ? "Yes" : "No" ?></p>
        <p><strong>Air Conditioning:</strong> <?= $flat['air_conditioning'] ? "Yes" : "No" ?></p>
        <p><strong>Access Control:</strong> <?= $flat['access_control'] ? "Yes" : "No" ?></p>
        <p><strong>Status:</strong> <?= $flat['is_rented'] ? 'Rented' : 'Available' ?></p> 

        <p><strong>Extras:</strong>
            <?php
            $extras = [];
            if ($flat['parking']) $extras[] = "Parking";
            if ($flat['backyard']) $extras[] = "Backyard";
            if ($flat['playground']) $extras[] = "Playground";
            if ($flat['storage']) $extras[] = "Storage";
            echo implode(", ", $extras);
            ?>
        </p>

        <?php if (!$flat['is_rented']): ?> 
            <p><a href="requestAppointment.php?ref=<?= $reference ?>" class="btn">Request Preview Appointment</a></p>
            <p><a href="rentFlat.php?ref=<?= $reference ?>" class="btn">Rent This Flat</a></p>

        <?php endif; ?>
    </section>

    <aside class="marketing">
        <h3>Nearby Places</h3>
        <ul>
            <?php foreach ($flat['marketing'] as $item): ?>
                <li>
                    <strong><?= htmlspecialchars($item['title']) ?>:</strong>
                    <?= htmlspecialchars($item['desc']) ?>
                    <?php if ($item['url']): ?>
                        - <a href="<?= htmlspecialchars($item['url']) ?>" target="_blank">Link</a>
                    <?php endif; ?>
                </li>
            <?php endforeach; ?>
        </ul>
    </aside>
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
