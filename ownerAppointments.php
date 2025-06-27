<?php
session_start();
require_once("dbconfig.inc.php");
require_once("Message.php");
$pdo = db_connect();
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'owner') {
    echo "<p>You must be logged in as an owner.</p>";
    exit;
}
$role = $_SESSION["role"];

$owner_id = $_SESSION['user_id'];

if (isset($_GET['accept']) && isset($_GET['slot'])) {
    $slot_id = $_GET['slot'];

    $stmt = $pdo->prepare("UPDATE appointments SET is_booked = 2 WHERE id = :slot");
    $stmt->execute([':slot' => $slot_id]);

}

$stmt = $pdo->prepare("
    SELECT a.id AS appointment_id, a.slot_date, a.slot_time, u.name AS customer_name, f.reference_number
    FROM appointments a
    JOIN flats f ON a.flat_id = f.flat_id
    JOIN customers c ON a.customer_id = c.customer_id
    JOIN users u ON c.customer_id = u.user_id
    WHERE f.owner_id = :owner AND a.is_booked = 1
    ORDER BY a.slot_date, a.slot_time
");
$stmt->execute([':owner' => $owner_id]);
$appointments = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Offer Flat</title>
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
    <h2>Offer a New Flat</h2>

    <form method="post" enctype="multipart/form-data" class="form-box">
        <fieldset>
            <legend>Basic Info</legend>
            <label>Location: <input type="text" name="location" required></label><br>
            <label>Address: <input type="text" name="address" required></label><br>
            <label>Monthly Rent: <input type="number" name="price" required></label><br>
            <label>Bedrooms: <input type="number" name="bedrooms" required></label><br>
            <label>Bathrooms: <input type="number" name="bathrooms" required></label><br>
            <label>Size (sqm): <input type="number" name="size" required></label><br>
            <label>Conditions: <textarea name="conditions" required></textarea></label>
        </fieldset>

        <fieldset>
            <legend>Amenities</legend>
            <label><input type="checkbox" name="heating"> Heating</label>
            <label><input type="checkbox" name="air_conditioning"> Air Conditioning</label>
            <label><input type="checkbox" name="access_control"> Access Control</label>
            <label><input type="checkbox" name="parking"> Parking</label>
            <label>Backyard:
                <select name="backyard">
                    <option value="none">None</option>
                    <option value="shared">Shared</option>
                    <option value="individual">Individual</option>
                </select>
            </label>
            <label><input type="checkbox" name="playground"> Playground</label>
            <label><input type="checkbox" name="storage"> Storage</label>
        </fieldset>

        <fieldset>
            <legend>Flat Photos (at least 3)</legend>
            <input type="file" name="photos[]" multiple required>
        </fieldset>

        <fieldset>
            <legend>Optional: Marketing Info</legend>
            <label>Title: <input type="text" name="marketing_title"></label><br>
            <label>Description: <textarea name="marketing_desc"></textarea></label><br>
            <label>Link (URL): <input type="url" name="marketing_url"></label>
        </fieldset>

        <fieldset>
            <legend>Available Viewing Times</legend>
            <p>Add up to 3 slots:</p>
            <?php for ($i = 0; $i < 3; $i++): ?>
                <label>Date: <input type="date" name="slot_date[]"></label>
                <label>Time: <input type="time" name="slot_time[]"></label><br>
            <?php endfor; ?>
        </fieldset>

        <button type="submit">Submit for Approval</button>
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
