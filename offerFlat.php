<?php
session_start();
require_once("dbconfig.inc.php");
$pdo = db_connect();
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'owner') {
    echo "Unauthorized access.";
    exit;
}
$role = $_SESSION["role"];

$username = $_SESSION['username'];
$owner_id = $_SESSION['user_id'];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $stmt = $pdo->prepare("INSERT INTO flats (owner_id, location, address, price, bedrooms, bathrooms, size_sqm, conditions, heating, air_conditioning, access_control, parking, backyard, playground, storage , is_rented) VALUES (:owner, :loc, :addr, :price, :bed, :bath, :size, :cond, :heat, :ac, :access, :park, :yard, :play, :store ,0)");
    $stmt->execute([
        ':owner' => $owner_id,
        ':loc' => $_POST['location'],
        ':addr' => $_POST['address'],
        ':price' => $_POST['price'],
        ':bed' => $_POST['bedrooms'],
        ':bath' => $_POST['bathrooms'],
        ':size' => $_POST['size'],
        ':cond' => $_POST['conditions'],
        ':heat' => isset($_POST['heating']) ? 1 : 0,
        ':ac' => isset($_POST['air_conditioning']) ? 1 : 0,
        ':access' => isset($_POST['access_control']) ? 1 : 0,
        ':park' => isset($_POST['parking']) ? 1 : 0,
        ':yard' => $_POST['backyard'],
        ':play' => isset($_POST['playground']) ? 1 : 0,
        ':store' => isset($_POST['storage']) ? 1 : 0
    ]);

    $flat_id = $pdo->lastInsertId();

    $uploadDir = "images/";
    if (!is_dir($uploadDir)) {
        mkdir($uploadDir, 0755, true);
    }

    foreach ($_FILES['photos']['tmp_name'] as $i => $tmp_path) {
        if (is_uploaded_file($tmp_path)) {

            // Get image type
            $image_info = getimagesize($tmp_path);
            $image_type = $image_info[2]; // IMAGETYPE_XXX

            // Create image resource
            switch ($image_type) {
                case IMAGETYPE_JPEG:
                    $src_image = imagecreatefromjpeg($tmp_path);
                    break;
                case IMAGETYPE_PNG:
                    $src_image = imagecreatefrompng($tmp_path);
                    break;
                case IMAGETYPE_GIF:
                    $src_image = imagecreatefromgif($tmp_path);
                    break;
                default:
                    // Skip unsupported image type
                    continue 2;
            }

            // Generate unique filename with PNG extension
            $filename = uniqid() . ".png";
            $destination = $uploadDir . $filename;

            // Save as PNG
            imagepng($src_image, $destination);

            // Clean up memory
            imagedestroy($src_image);

            // Save in database
            $stmt2 = $pdo->prepare("INSERT INTO flat_photos (flat_id, image_path) VALUES (:fid, :img)");
            $stmt2->execute([':fid' => $flat_id, ':img' => $filename]);
        }

    }

    if (!empty($_POST['marketing_title'])) {
        $stmt = $pdo->prepare("INSERT INTO marketing_info (flat_id, title, description, url) VALUES (:fid, :title, :desc, :url)");
        $stmt->execute([
            ':fid' => $flat_id,
            ':title' => $_POST['marketing_title'],
            ':desc' => $_POST['marketing_desc'],
            ':url' => $_POST['marketing_url']
        ]);
    }

    foreach ($_POST['slot_date'] as $i => $date) {
        $time = $_POST['slot_time'][$i];
        if (!empty($date) && !empty($time)) {
            $stmt = $pdo->prepare("INSERT INTO appointments (flat_id, slot_date, slot_time) VALUES (:fid, :date, :time)");
            $stmt->execute([
                ':fid' => $flat_id,
                ':date' => $date,
                ':time' => $time
            ]);
        }
    }
    header("Location: main.php");
    exit;
}
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
            <p><a href="offerFlat.php" class="active">Offer Flat</a></p>
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
            <input type="file" name="photos[]" accept="image/*" multiple required>
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
