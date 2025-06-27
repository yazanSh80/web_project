<?php
session_start();
require_once("dbconfig.inc.php");
$pdo = db_connect();
if (!isset($_SESSION["role"]) || $_SESSION["role"] !== "manager") {
    echo "Unauthorized access.";
    exit;
}
$role = $_SESSION["role"];
$username = $_SESSION["username"];

// Get filters
$from = $_GET['from'] ?? '';
$to = $_GET['to'] ?? '';
$location = $_GET['location'] ?? '';
$available_on = $_GET['available_on'] ?? '';
$owner_name = $_GET['owner_name'] ?? '';
$customer_name = $_GET['customer_name'] ?? '';

// Base query
$sql = "
    SELECT r.*, f.reference_number, f.price, f.location, f.owner_id, 
           u1.name AS owner_name, u2.name AS customer_name, 
           r.start_date, r.end_date, u1.user_id AS owner_uid, u2.user_id AS customer_uid
    FROM rentals r
    JOIN flats f ON r.flat_id = f.flat_id
    JOIN users u1 ON f.owner_id = u1.user_id
    JOIN users u2 ON r.customer_id = u2.user_id
    WHERE 1=1
";

$params = [];

if (!empty($from)) {
    $sql .= " AND r.start_date >= :from";
    $params[':from'] = $from;
}
if (!empty($to)) {
    $sql .= " AND r.end_date <= :to";
    $params[':to'] = $to;
}
if (!empty($location)) {
    $sql .= " AND f.location LIKE :location";
    $params[':location'] = "%$location%";
}
if (!empty($available_on)) {
    $sql .= " AND NOT EXISTS (
        SELECT 1 FROM rentals r2
        WHERE r2.flat_id = f.flat_id
        AND :available_on BETWEEN r2.start_date AND r2.end_date
    )";
    $params[':available_on'] = $available_on;
}

if (!empty($owner_name)) {
    $sql .= " AND u1.name LIKE :owner_name";
    $params[':owner_name'] = "%$owner_name%";
}
if (!empty($customer_name)) {
    $sql .= " AND u2.name LIKE :customer_name";
    $params[':customer_name'] = "%$customer_name%";
}

$sql .= " ORDER BY r.start_date DESC";
$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$results = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Flats Inquire</title>
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
        <p><a href="managerApproval.php" class="active">Approve Flats</a></p>
        <p><a href="viewMessages.php">View Messages</a></p>
        <p><a href="managerInquire.php">View Flats</a></p>
    </section>
</nav>

<main>
  <h2>Flats Inquire</h2>

  <form method="get" class="search-form">
    <label>From: <input type="date" name="from" value="<?= htmlspecialchars($from) ?>"></label>
    <label>To: <input type="date" name="to" value="<?= htmlspecialchars($to) ?>"></label>
    <label>Location: <input type="text" name="location" value="<?= htmlspecialchars($location) ?>"></label>
    <label>Available On: <input type="date" name="available_on" value="<?= htmlspecialchars($available_on) ?>"></label>
    <label>Owner Name: <input type="text" name="owner_name" value="<?= htmlspecialchars($owner_name) ?>"></label>
    <label>Customer Name: <input type="text" name="customer_name" value="<?= htmlspecialchars($customer_name) ?>"></label>
    <button type="submit" class="search-button">Search</button>
  </form>

  <?php if (!empty($results)): ?>
    <table class="flats-table">
      <thead>
        <tr>
          <th>Flat Ref#</th>
          <th>Monthly Rent</th>
          <th>Start</th>
          <th>End</th>
          <th>Location</th>
          <th>Owner</th>
          <th>Customer</th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($results as $row): ?>
          <tr>
            <td><a href="flatDetails.php?ref=<?= $row['reference_number'] ?>"><?= $row['reference_number'] ?></a></td>
            <td>$<?= $row['price'] ?></td>
            <td><?= $row['start_date'] ?></td>
            <td><?= $row['end_date'] ?></td>
            <td><?= htmlspecialchars($row['location']) ?></td>
            <td><a href="ownerDetails.php?owner_id=<?= $row['owner_uid'] ?>">👤 <?= $row['owner_name'] ?></a></td>
            <td><a href="customerDetail.php?customer_id=<?= $row['customer_uid'] ?>">👤 <?= $row['customer_name'] ?></a></td>
          </tr>
        <?php endforeach; ?>
      </tbody>
    </table>
  <?php else: ?>
    <p>No results found.</p>
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
