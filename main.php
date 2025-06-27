<?php
session_start();
require_once("dbconfig.inc.php");
$pdo = db_connect();

if (!isset($_SESSION["username"])) {
    header("Location: login.php");
    exit;
}

$stmt = $pdo->prepare("
    SELECT f.flat_id, f.reference_number,f.owner_id, u.name AS owner_name, 
           (SELECT image_path FROM flat_photos WHERE flat_id = f.flat_id LIMIT 1) AS photo
    FROM flats f
    JOIN users u ON f.owner_id = u.user_id
    WHERE f.approved = 1 
    ORDER BY f.flat_id DESC

    LIMIT 4
");
$stmt->execute();
$featured_flats = $stmt->fetchAll(PDO::FETCH_ASSOC);

$username = $_SESSION["username"] ?? 'Guest';
$role = $_SESSION["role"] ?? 'Guest';
?>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Main - Birzeit Flat Rent</title>
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

<main>
<section class="photos">
    <h3>Featured Flats</h3>
        <?php foreach ($featured_flats as $flat): ?>
            <?php if (!empty($flat['photo'])): ?>
                <figure>
                    <a href="flatDetails.php?ref=<?= urlencode($flat['reference_number']) ?>">
                        <img src="images/<?= htmlspecialchars($flat['photo']) ?>" alt="Flat Photo" class="flat-photo">
                    </a>
                    <figcaption>
                        <a href="ownerDetails.php?owner_id=<?= $flat['owner_id'] ?>">
                            <?= htmlspecialchars($flat['owner_name']) ?>
                        </a>
                    </figcaption>
                </figure>
            <?php endif; ?>
        <?php endforeach; ?>

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
