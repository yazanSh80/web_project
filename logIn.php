<?php
session_start();
require_once("dbconfig.inc.php");

$pdo = db_connect(); // <== أضف هذا السطر

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $email = $_POST["email"];
    $password = $_POST["password"];

    try {
        $query = "SELECT * FROM users WHERE email = :email";
        $stmt = $pdo->prepare($query);
        $stmt->bindParam(':email', $email);
        $stmt->execute();

        $user = $stmt->fetch();

        if ($user && $user["password"] === $password) {
            $_SESSION["user_id"] = $user["user_id"];
            $_SESSION["username"] = $user["username"];
            $_SESSION["role"] = $user["role"];

            header("Location: main.php");
            exit;
        } else {
            $error = "Incorrect email or password.";
        }
    } catch (PDOException $e) {
        $error = "Database error: " . $e->getMessage();
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Al Sharif Flat Rent - Log In</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<header class="main-header">
    <img src="images/al sharif.png" alt="Logo" class="logo">
    <h1 class="system-title">Al Sharif Flat Rent</h1>
    <a href="logout.php" class="logout-button">Logout</a>
</header>

<nav>
    <section>
        <p><strong>Navigation</strong></p>
        <p><a href="main.php">Home Page</a></p>
        <p><a href="aboutUs.php">About Us</a></p>
        <p><a href="logIn.php" class="active">Log In</a></p>
        <p><a href="signup.php">Sign Up</a></p>
        <p><a href="main_guest.php">Log in as guest</a></p>
    </section>
</nav>


<main>
    <section class="login-box">
        <h2>Log In</h2>
        <?php if (!empty($error)) echo "<p class='error'>$error</p>"; ?>

        <form method="POST" action="logIn.php">
            <label for="email">Email:</label>
            <input type="email" name="email" id="email" class="input-main" required>

            <label for="password">Password:</label>
            <input type="password" name="password" id="password" class="input-main" required>

            <input type="submit" value="Login" class="login-button">
        </form>

        <form class="signup-form" action="signup.php" method="get">
            <button type="submit" class="signup-button">Sign Up</button>
        </form>
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
