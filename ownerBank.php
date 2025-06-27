<?php
session_start();
require_once("dbconfig.inc.php");
$pdo = db_connect();
if (!isset($_SESSION['pending_user']) || $_SESSION['pending_user']['role'] !== 'owner') {
    header("Location: signup.php");
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $bank_name = $_POST['bank_name'];
    $account_number = $_POST['account_number'];
    $bank_branch = $_POST['bank_branch'];

    $user_id = $_SESSION['pending_user']['user_id'];

    try {
        $stmt = $pdo->prepare("
            INSERT INTO owners (owner_id, bank_name, account_number, bank_branch)
            VALUES (:user_id, :bank_name, :account_number, :bank_branch)
        ");
        $stmt->execute([
            'user_id' => $user_id,
            'bank_name' => $bank_name,
            'account_number' => $account_number,
            'bank_branch' => $bank_branch
        ]);

        header("Location: setPassword.php");
        exit;
    } catch (PDOException $e) {
        $error = "Database error: " . $e->getMessage();
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bank Info - Owner</title>
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
    <p><a href="offerFlat.php" class="active">Offer Flat</a></p>
    <p><a href="viewMessages.php">View Messages</a></p>
  </section>
</nav>

<main>
    <h2>Owner Bank Information</h2>

    <form method="POST" class="form-box">
        <fieldset>
            <legend>Bank Information</legend>

            <label for="bank_name">Bank Name:</label>
            <input type="text" id="bank_name" name="bank_name" required>

            <label for="account_number">Account Number:</label>
            <input type="text" id="account_number" name="account_number" required>

            <label for="bank_branch">Bank Branch:</label>
            <input type="text" id="bank_branch" name="bank_branch" required>

            <button type="submit" class="login-button">Next</button>
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
