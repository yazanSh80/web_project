<?php
session_start();
require_once("dbconfig.inc.php");
$pdo = db_connect();
if (!isset($_SESSION['user_id'])) {
    header("Location: logIn.php");
    exit;
}

$user_id = $_SESSION['user_id'];
$username = $_SESSION['username'];
$role = $_SESSION['role'];

$stmt = $pdo->prepare("SELECT * FROM users WHERE user_id = :user_id");
$stmt->execute([':user_id' => $user_id]);
$user = $stmt->fetch();

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile - <?= htmlspecialchars($user['name']) ?></title>
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
    <section class="user-card">
        <h2><?= htmlspecialchars($user['name']) ?></h2>
 
        <p><strong>Email:</strong> <?= htmlspecialchars($user['email']) ?></p>
        <p><strong>Mobile:</strong> <?= htmlspecialchars($user['mobile']) ?></p>
        <p><strong>Telephone:</strong> <?= htmlspecialchars($user['telephone']) ?></p>
        <p><strong>Address:</strong> <?= htmlspecialchars($user['address']) ?></p>

        <p><a href="editProfile.php" class="btn">Edit Profile</a></p>
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
