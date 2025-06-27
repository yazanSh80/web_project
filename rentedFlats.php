<?php
session_start();
require_once("dbconfig.inc.php");
$pdo = db_connect();
if (!isset($_SESSION["user_id"]) || $_SESSION["role"] !== "customer") {
    echo "Unauthorized access.";
    exit;
}
$role = $_SESSION["role"];

$customer_id = $_SESSION["user_id"];
$username = $_SESSION["username"];

// Fetch all rented flats by this customer, including owner info
$stmt = $pdo->prepare("
    SELECT r.*, 
           f.reference_number, f.location, f.address, f.price, f.bedrooms, f.bathrooms,
           u.name AS owner_name, u.email AS owner_email, u.mobile AS owner_mobile, u.user_id AS owner_user_id
    FROM rentals r
    JOIN flats f ON r.flat_id = f.flat_id
    JOIN owners o ON f.owner_id = o.owner_id
    JOIN users u ON o.owner_id = u.user_id
    WHERE r.customer_id = :cust
    ORDER BY r.start_date DESC
");
$stmt->execute([':cust' => $customer_id]);
$rentedFlats = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Rentals</title>
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
    <h2>My Rented Flats</h2>

    <?php if (empty($rentedFlats)): ?>
        <p>You have not rented any flats yet.</p>
    <?php else: ?>
        <table class="flats-table">
            <thead>
                <tr>
                    <th>Reference</th>
                    <th>Location</th>
                    <th>Address</th>
                    <th>Rent</th>
                    <th>Bedrooms</th>
                    <th>Bathrooms</th>
                    <th>From</th>
                    <th>To</th>
                    <th>Total</th>
                    <th>Owner</th>
                    <th>Owner Contact</th>
                </tr>
            </thead>
            <tbody>
            <?php foreach ($rentedFlats as $r): ?>
                <tr>
                    <td><a href="flatDetails.php?ref=<?= htmlspecialchars($r['reference_number']) ?>"><?= htmlspecialchars($r['reference_number']) ?></a></td>
                    <td><?= htmlspecialchars($r['location']) ?></td>
                    <td><?= htmlspecialchars($r['address']) ?></td>
                    <td>$<?= htmlspecialchars($r['price']) ?></td>
                    <td><?= htmlspecialchars($r['bedrooms']) ?></td>
                    <td><?= htmlspecialchars($r['bathrooms']) ?></td>
                    <td><?= htmlspecialchars($r['start_date']) ?></td>
                    <td><?= htmlspecialchars($r['end_date']) ?></td>
                    <td>$<?= htmlspecialchars($r['total_amount']) ?></td>
                    <td><a href="ownerDetails.php?owner_id=<?= htmlspecialchars($r['owner_user_id']) ?>"><?= htmlspecialchars($r['owner_name']) ?></a></td>
                    <td>
                        <?= htmlspecialchars($r['owner_mobile']) ?><br>
                        <?= htmlspecialchars($r['owner_email']) ?>
                    </td>
                </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
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
