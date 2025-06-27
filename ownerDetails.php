<?php
session_start();
require_once("dbconfig.inc.php");
$pdo = db_connect();
$username = $_SESSION["username"] ?? 'Guest';

if (!isset($_GET['owner_id'])) {
    echo "Owner not found.";
    exit;
}

$owner_id = $_GET['owner_id'];
$role = $_SESSION["role"]?? 'Guest';

$stmt = $pdo->prepare("SELECT * FROM owners WHERE owner_id = :owner_id");
$stmt->execute([':owner_id' => $owner_id]);
$owner = $stmt->fetch();

if (!$owner) {
    echo "Owner not found.";
    exit;
}

$stmt_user = $pdo->prepare("SELECT * FROM users WHERE user_id = :user_id");
$stmt_user->execute([':user_id' => $owner['owner_id']]);
$user = $stmt_user->fetch();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Owner Details</title>
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
    <?php if($role !="Guest"):?>
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
    <?php else : ?>
        <p><a href="main_guest.php">Home Page</a></p>
        <p><a href="aboutUs.php">About Us</a></p>
        <p><a href="logIn.php">Log In</a></p>

    <?php endif; ?>  
  </section>
</nav>

<main>
    <h2>Owner Information</h2>

    <section class="user-card">
        <h3><?= htmlspecialchars($user['name']) ?></h3>
        <p><strong>City:</strong> <?= htmlspecialchars($user['address']) ?></p>
        <p><strong>Phone:</strong> <?= htmlspecialchars($user['mobile']) ?></p>
        <p><strong>Email:</strong> <a href="mailto:<?= htmlspecialchars($user['email']) ?>"><?= htmlspecialchars($user['email']) ?></a></p>
    </section>

    <?php if ($role === "manager"): ?>
    <fieldset>
        <legend>Payment Information</legend>
        <p><strong>Bank name:</strong> <?= htmlspecialchars($owner['bank_name'] ?? '') ?></p>

        <p><strong>Bank branch:</strong> <?= htmlspecialchars($owner['bank_branch'] ??'') ?></p>
        <p><strong>Account number:</strong> <?= htmlspecialchars($owner['account_number']) ??'' ?></p>
    </fieldset>
    <?php endif; ?>
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
