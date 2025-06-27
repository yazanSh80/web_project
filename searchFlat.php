<?php
session_start();
require_once("dbconfig.inc.php");
require_once("Flat.php");
$pdo = db_connect();
$price = $_GET['price'] ?? '';
$location = $_GET['location'] ?? '';
$bedrooms = $_GET['bedrooms'] ?? '';
$bathrooms = $_GET['bathrooms'] ?? '';
$furnished = $_GET['furnished'] ?? '';

$flats = Flat::searchFlats($pdo, $price, $location, $bedrooms, $bathrooms, $furnished);
$username = $_SESSION['username'] ?? 'Guest';
$role = $_SESSION["role"]?? 'Guest';

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Search Flats</title>
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
            <p><a href="managerInquire.php">View Flats</a></p>

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
    <h2>Search Flats</h2>

    <form method="get" action="searchFlat.php" class="search-form">
        <label>Price (max): <input type="number" name="price" value="<?= htmlspecialchars($price) ?>"></label>
        <label>Location: <input type="text" name="location" value="<?= htmlspecialchars($location) ?>"></label>
        <label>Bedrooms: <input type="number" name="bedrooms" value="<?= htmlspecialchars($bedrooms) ?>"></label>
        <label>Bathrooms: <input type="number" name="bathrooms" value="<?= htmlspecialchars($bathrooms) ?>"></label>
       
        <button type="submit" class="btn">Search</button>
    </form>

    <section class="search-results">
        <?php if (!empty($flats)): ?>
            <table class="flats-table">
                <thead>
                    <tr>
                        <th>Ref #</th>
                        <th>Monthly Rent</th>
                        <th>Location</th>
                        <th>Bedrooms</th>
                        <th>Photo</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($flats as $flat): ?>
                      <?php if (!empty($flat['reference_number'])): ?> 
                        <tr>
                            <td><?= htmlspecialchars($flat['reference_number']) ?></td>
                            <td>$<?= htmlspecialchars($flat['price']) ?></td>
         
                            <td><?= htmlspecialchars($flat['location']) ?></td>
                            <td><?= htmlspecialchars($flat['bedrooms']) ?></td>
                            <td>
                                <?php
                                $stmtPhoto = $pdo->prepare("SELECT image_path FROM flat_photos WHERE flat_id = :flat_id LIMIT 1");
                                $stmtPhoto->execute([':flat_id' => $flat['flat_id']]);
                                $photoPath = $stmtPhoto->fetchColumn();

                                if ($photoPath):
                                ?>
                                    <a href="flatDetails.php?ref=<?= htmlspecialchars($flat['reference_number']) ?>" target="_self">
                                        <img src="images/<?= htmlspecialchars($photoPath) ?>" alt="Flat Photo" class="flat-photo">
                                    </a>
                                <?php else: ?>
                                    <span>No photo</span>
                                <?php endif; ?>
                            </td>

                        </tr>
                        <?php endif; ?>
                    <?php endforeach; ?>
                </tbody>
            </table>
        <?php else: ?>
            <p>No flats found matching your criteria.</p>
        <?php endif; ?>
    </section>

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
