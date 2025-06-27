<?php
session_start();
require_once("dbconfig.inc.php");
$pdo = db_connect();
if (!isset($_SESSION['user_id'])) {
    echo "Unauthorized access.";
    exit;
}

$user_id = $_SESSION['user_id'];
$user_type = $_SESSION['role'];
$username = $_SESSION["username"];
$role = $_SESSION["role"];
if ($role === "manager") {
    $stmt = $pdo->prepare("SELECT * FROM messages ORDER BY date_sent DESC");
    $stmt->execute();
} else {
    $stmt = $pdo->prepare("SELECT * FROM messages WHERE receiver_id = :uid ORDER BY date_sent DESC");
    $stmt->execute([':uid' => $user_id]);
}

$messages = $stmt->fetchAll(PDO::FETCH_ASSOC);


?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Messages</title>
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
      
     <?php elseif($role === "Guest"):?>
     <p><a href="searchFlat.php">Search Flats</a></p>
     <p><a href="logIn.php">Log In</a></p> 
    <?php endif; ?>
  </section>
</nav>
<main>


  <section>
    <h2>Inbox</h2>

    <?php if (empty($messages)): ?>
      <p>No messages yet.</p>
    <?php else: ?>
      <table class="flats-table">
        <thead>
          <tr>
            <th>📨</th>
            <th>Title</th>
            <th>Date</th>
            <th>From</th>
            <th>Body</th>
            <th>Status</th>
            <?php if ($role === 'owner'): ?>
              <th>Action</th>
            <?php endif; ?>
          </tr>
        </thead>
        <tbody>
          <?php foreach ($messages as $msg):
            $stmtUser = $pdo->prepare("SELECT name FROM users WHERE user_id = :id");
            $stmtUser->execute([':id' => $msg['sender_id']]);
            $sender = $stmtUser->fetchColumn();

            $row_class = $msg['is_read'] == 0 ? "unread" : "read";
            $icon = $msg['is_read'] == 0 ? "🔔" : "";
          ?>
          <tr class="<?= $row_class ?>">
            <td><?= $icon ?></td>
            <td><?= htmlspecialchars($msg['title']) ?></td>
            <td><?= $msg['date_sent'] ?></td>
            <td><?= htmlspecialchars($sender) ?></td>
            <td><?= nl2br(htmlspecialchars($msg['body'])) ?></td>
            <td><?= htmlspecialchars($msg['status']) ?></td>
            <?php if ($role === 'owner'): ?>
              <td>
                <?php if ($msg['status'] === 'pending'): ?>
                  <a href="ownerApproval.php?message_id=<?= $msg['message_id'] ?>">Review</a>
                <?php else: ?>
                  <?= ucfirst($msg['status']) ?>
                <?php endif; ?>
              </td>
            <?php endif; ?>
          </tr>
          <?php endforeach; ?>
        </tbody>
      </table>
    <?php endif; ?>
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