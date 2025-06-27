<?php
session_start();
require_once("dbconfig.inc.php");
$pdo = db_connect();
if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit;
}

$user_id = $_SESSION['user_id'];
$role = $_SESSION['role'];

$stmt = $pdo->prepare("SELECT * FROM users WHERE user_id = ?");
$stmt->execute([$user_id]);
$user = $stmt->fetch();

$customer = null;
if ($role === 'customer') {
    $stmt2 = $pdo->prepare("SELECT * FROM customers WHERE customer_id = ?");
    $stmt2->execute([$user_id]);
    $customer = $stmt2->fetch();
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $stmt = $pdo->prepare("UPDATE users SET name=?, email=?, address=?, telephone=?, mobile=?, dob=?, username=? WHERE user_id=?");
    $stmt->execute([
        $_POST['name'],
        $_POST['email'],
        $_POST['address'],
        $_POST['telephone'],
        $_POST['mobile'],
        $_POST['dob'],
        $_POST['username'],
        $user_id
    ]);

    if ($role === 'customer') {
        $stmt2 = $pdo->prepare("UPDATE customers SET payment_card=?, cvv=?, expiry_date=? WHERE customer_id=?");
        $stmt2->execute([
            $_POST['payment_card'],
            $_POST['cvv'],
            $_POST['expiry_date'],
            $user_id
        ]);
    }

    $success = "Profile updated successfully!";
    // إعادة جلب البيانات بعد التحديث
    header("Location: userProfile.php");
    exit;
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Profile</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<header class="main-header">
    <img src="images/al sharif.png" alt="Logo" class="logo">
    <h1 class="system-title"><a href="main.php" class="title-link">Al Sharif Flat Rent</a></h1>
    <a href="aboutUs.php" class="nav-link">About Us</a>
    <a href="userProfile.php" class="nav-link">
        <img src="images/user.png" alt="User Icon" class="header-user-photo">
        <?= htmlspecialchars($_SESSION['username']) ?>
    </a>
    <a href="logout.php" class="logout-button">Logout</a>
</header>
<nav>
    <section>
        <p><strong>Navigation</strong></p>
        <p><a href="main.php">Home Page</a></p>
        <p><a href="aboutUs.php">About Us</a></p>

        <?php if ($role === "owner"): ?>
            <p><a href="offerFlat.php">Offer Flat</a></p>
            <p><a href="viewMessages.php">View Messages</a></p>

        <?php elseif ($role === "customer"): ?>
            <p><a href="searchFlat.php">Search Flats</a></p>
            <p><a href="rentedFlats.php">My Rentals</a></p>
            <p><a href="viewMessages.php">View Messages</a></p>
        <?php endif; ?>
    </section>
</nav>

<main>
    <h2>Edit Profile</h2>

    <?php if (!empty($error)) echo "<p class='error'>$error</p>"; ?>
    <?php if (!empty($success)) echo "<p style='color: green;'>$success</p>"; ?>

    <form method="POST">
        <label>Name:</label>
        <input type="text" name="name" required value="<?= htmlspecialchars($user['name']) ?>">

        <label>Email:</label>
        <input type="email" name="email" required value="<?= htmlspecialchars($user['email']) ?>">

        <label>Address:</label>
        <input type="text" name="address" required value="<?= htmlspecialchars($user['address']) ?>">

        <label>Telephone:</label>
        <input type="text" name="telephone" required value="<?= htmlspecialchars($user['telephone']) ?>">

        <label>Mobile:</label>
        <input type="text" name="mobile" required value="<?= htmlspecialchars($user['mobile']) ?>">

        <label>Date of Birth:</label>
        <input type="date" name="dob" required value="<?= htmlspecialchars($user['dob']) ?>">

        <label>Username:</label>
        <input type="text" name="username" required value="<?= htmlspecialchars($user['username']) ?>">

        <?php if ($role === 'customer' && $customer): ?>
            <fieldset>
                <legend>Payment Info</legend>

                <label>Payment Card:</label>
                <input type="text" name="payment_card" required value="<?= htmlspecialchars($customer['payment_card']) ?>">

                <label>CVV:</label>
                <input type="text" name="cvv" required value="<?= htmlspecialchars($customer['cvv']) ?>">

                <label>Expiry Date:</label>
                <input type="date" name="expiry_date" required value="<?= htmlspecialchars($customer['expiry_date']) ?>">
            </fieldset>
        <?php endif; ?>

        <button type="submit">Save Changes</button>
    </form>
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
