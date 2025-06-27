<?php
session_start();
require_once("dbconfig.inc.php");
$pdo = db_connect();
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'manager') {
    echo "Unauthorized access.";
    exit;
}
$role = $_SESSION["role"];
$username = $_SESSION['username'];

if (isset($_GET['flat_id']) && is_numeric($_GET['flat_id'])) {
    $flat_id = $_GET['flat_id'];

    $stmt = $pdo->prepare("SELECT * FROM flats WHERE flat_id = :id");
    $stmt->execute([':id' => $flat_id]);
    $flat = $stmt->fetch();

    if (!$flat) {
        echo "Flat not found.";
        exit;
    }

    if (isset($_POST['approve'])) {
        $reference = str_pad(rand(100000, 999999), 6, '0', STR_PAD_LEFT);

        $stmt = $pdo->prepare("UPDATE flats SET approved = 1, reference_number = :ref WHERE flat_id = :id");
        $stmt->execute([':ref' => $reference, ':id' => $flat_id]);

        $stmtMsg = $pdo->prepare("INSERT INTO messages (sender_id, receiver_id, title, body, status, is_read, date_sent) 
        VALUES (:sender, :receiver, :title, :body, 'approved', 0, NOW())");

        $stmtMsg->execute([
            ':sender' => $_SESSION['user_id'], 
            ':receiver' => $flat['owner_id'],
            ':title' => 'Flat Approval',
            ':body' => "Your flat (ID: {$flat_id}) has been approved. Reference Number: {$reference}."
        ]);
    header("Location:managerApproval.php");
        exit;
    }

  if (isset($_POST['reject'])) {
    try {
        $pdo->beginTransaction();
        $stmt = $pdo->prepare("SELECT photo_id FROM flat_photos WHERE flat_id = :flat_id");
        $stmt->execute([':flat_id' => $flat_id]);

        $photos = $stmt->fetchAll(PDO::FETCH_ASSOC);

        foreach ($photos as $photo) {
            $photo_id = $photo['photo_id'];

            $stmtDelete = $pdo->prepare("DELETE FROM flat_photos WHERE photo_id = :photo_id");
            $stmtDelete->execute([':photo_id' => $photo_id]);
        }
    $stmtinfo = $pdo->prepare("DELETE FROM marketing_info WHERE flat_id = :id");
    $stmtinfo->execute([':id' => $flat_id]);
        $stmt = $pdo->prepare("DELETE FROM flats WHERE flat_id = :id");
        $stmt->execute([':id' => $flat_id]);

        $stmtMsg = $pdo->prepare("INSERT INTO messages (sender_id, receiver_id, title, body, status, is_read, date_sent) 
        VALUES (:sender, :receiver, :title, :body, 'rejected', 0, NOW())");

        $stmtMsg->execute([
            ':sender' => $_SESSION['user_id'],
            ':receiver' => $flat['owner_id'],
            ':title' => 'Flat Rejected',
            ':body' => "Your flat (ID: {$flat_id}) has been rejected by the manager."
        ]);

        $pdo->commit();
        header("Location:managerApproval.php");

        exit;

    } catch (Exception $e) {
        $pdo->rollBack();
        echo "Error: " . $e->getMessage();
    }
}

}

$stmt = $pdo->query("SELECT * FROM flats WHERE approved = 0");
$flats = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Approve Flats</title>
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
    <h2>Flats Waiting for Approval</h2>

    <?php if (empty($flats)): ?>
        <p>No flats pending approval.</p>
    <?php else: ?>
        <table class="flats-table">
            <thead>
                <tr>
                    <th>Flat ID</th>
                    <th>Location</th>
                    <th>Address</th>
                    <th>Price</th>
                    <th>Bedrooms</th>
                    <th>Bathrooms</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
            <?php foreach ($flats as $flat): ?>
                <tr>
                    <td><?= $flat['flat_id'] ?></td>
                    <td><?= htmlspecialchars($flat['location']) ?></td>
                    <td><?= htmlspecialchars($flat['address']) ?></td>
                    <td>$<?= $flat['price'] ?></td>
                    <td><?= $flat['bedrooms'] ?></td>
                    <td><?= $flat['bathrooms'] ?></td>
                    <td>
                        <form method="post" action="managerApproval.php?flat_id=<?= $flat['flat_id'] ?>">
                            <button type="submit" name="approve" class="btn-approve">Approve</button>
                            <button type="submit" name="reject" class="btn-reject">Reject</button>
                        </form>
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
