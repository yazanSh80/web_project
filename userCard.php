<?php
session_start();
require_once("dbconfig.inc.php");
$pdo = db_connect();
if (!isset($_GET['email'])) {
    echo "No user specified.";
    exit;
}

if (!isset($_SESSION['role'])) {
    echo "Unauthorized access.";
    exit;
}

$role = $_SESSION["role"];
$email = $_GET['email'];

$stmt = $pdo->prepare("SELECT name, address, telephone, email FROM users WHERE email = :email");
$stmt->execute([':email' => $email]);
$user = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$user) {
    echo "User not found.";
    exit;
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Card - <?= htmlspecialchars($user['name']) ?></title>
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


<main>
  <nav>
    <section>
      <p><strong>Navigation</strong></p>

      <?php if ($role === "owner"): ?>
        <p><a href="offerFlat.php">Offer Flat</a></p>
        <p><a href="viewMessages.php">View Messages</a></p>
        <p><a href="managerInquire.php">View flats</a></p>

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

  <section class="user-card">
    <h2><?= htmlspecialchars($user['name']) ?></h2>
    <p><strong>City:</strong> <?= htmlspecialchars($user['address']) ?></p>
    <p><span class="icon">📞</span> <?= htmlspecialchars($user['telephone']) ?></p>
    <p><span class="icon">✉️</span> <a href="mailto:<?= htmlspecialchars($user['email']) ?>" class="mail-link"><?= htmlspecialchars($user['email']) ?></a></p>
  </section>
</main>

<footer>
  <section>
    <img src="images/al sharif.png" alt="Logo" class="footer-logo">
  </section>
  <section class="footer-text">
    <p>&copy; 2025 Al Sharif Flat Rent. All Rights Reserved.</p>
    <address>
      <p><em>Email:</em> alshareefy99@gmail.com</p>
      <p><em>Address:</em> School Street, Kafr Aqab</p>
      <p><em>Phone:</em> 0532304296</p>
    </address>
  </section>
</footer>

</body>
</html>

