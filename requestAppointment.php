<?php
session_start();
require_once("dbconfig.inc.php");
require_once("Flat.php");
$pdo = db_connect();
$username = $_SESSION['username'] ?? 'Guest'; 
$user_id = $_SESSION['user_id'] ?? null; 
$role = $_SESSION["role"]?? 'Guest';

if (!$user_id) {
    echo "Please log in first.";
    exit;
}

if (!isset($_GET['ref'])) {
    echo "No flat reference provided.";
    exit;
}

$ref = $_GET['ref'];

if ($_SESSION['role'] !== 'customer') {
    $_SESSION['redirect_after_login'] = "requestAppointment.php?ref=$ref";
    header("Location: logIn.php");
    exit;
}

$flatId = Flat::getFlatIdByReference($pdo, $ref);
$flat = Flat::getFlatByReference($pdo, $ref);
if (!$flat) {
    echo "No flat found.";
    exit;
}
$owner_id = $flat['owner_id']; // هنا يتم تعيين owner_id بعد استرجاع الشقة

if (isset($_GET['book']) && isset($_GET['slot'])) {
    $slotId = $_GET['slot'];

    $stmt = $pdo->prepare("SELECT * FROM appointments WHERE appointment_id = :slot AND flat_id = :flat AND is_booked = 0 AND slot_date >= CURDATE()");
    $stmt->execute([':slot' => $slotId, ':flat' => $flatId]);
    $slot = $stmt->fetch();

    if ($slot) {
        $stmt2 = $pdo->prepare("UPDATE appointments SET is_booked = 1, customer_id = :cust WHERE appointment_id = :slot");
        $stmt2->execute([':cust' => $user_id, ':slot' => $slotId]);
        $stmtMsg = $pdo->prepare("INSERT INTO messages (sender_id, receiver_id, title, body, status, is_read, date_sent) 
        VALUES (:sender, :receiver, :title, :body, 'pending', 0, NOW())");
        
        $stmtMsg->execute([
            ':sender' => $_SESSION['user_id'],
            ':receiver' => $owner_id,
            ':title' => 'book appointment',
            ':body' => "I would like to book an appointment Ref: {$flat['reference_number']} from {$_POST['start_date']} to {$_POST['end_date']}."
        ]);
    } else {
        echo "<p>❌ Slot not available or already booked.</p>";
    }
}

$stmt = $pdo->prepare("SELECT * FROM appointments WHERE flat_id = :id AND slot_date >= CURDATE() ORDER BY slot_date, slot_time");
$stmt->execute([':id' => $flatId]);
$slots = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Request Appointment - Flat <?= htmlspecialchars($ref) ?></title>
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
    <h2>Available Appointments for Flat Ref <?= htmlspecialchars($ref) ?></h2>

    <table class="flats-table">
        <thead>
            <tr>
                <th>Date</th>
                <th>Day</th>
                <th>Time</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($slots as $slot):
                $dayName = date('l', strtotime($slot['slot_date']));
            ?>
            <tr class="<?= $slot['is_booked'] ? 'taken-slot' : 'available-slot' ?>">
                <td><?= htmlspecialchars($slot['slot_date']) ?></td>
                <td><?= $dayName ?></td>
                <td><?= htmlspecialchars($slot['slot_time']) ?></td>
                <td><?= $slot['is_booked'] ? 'Taken' : 'Available' ?></td>
                <td>
                    <?php if ($slot['is_booked']): ?>
                        <span class="btn disabled">Booked</span>
                    <?php else: ?>
                        <a href="requestAppointment.php?ref=<?= $ref ?>&slot=<?= $slot['appointment_id'] ?>&book=1" class="btn">Book</a>
                    <?php endif; ?>
                </td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>

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
