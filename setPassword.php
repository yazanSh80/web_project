<?php
session_start();
require_once("dbconfig.inc.php");
$pdo = db_connect();
if (!isset($_SESSION['pending_user'])) {
    header("Location: signup.php");
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $password = $_POST['password'];
    $confirm = $_POST['confirm'];

    if (strlen($password) < 6 || strlen($password) > 15) {
        $error = "Password must be between 6 and 15 characters.";
    } elseif (!preg_match("/^[A-Z].*[0-9]/", $password)) {
        $error = "Password must start with a capital letter and contain at least one number.";
    } elseif ($password !== $confirm) {
        $error = "Passwords do not match.";
    } else {
        try {
            $pdo->beginTransaction();

            $user = $_SESSION['pending_user'];
            $plainPassword = $password; 

            $stmt = $pdo->prepare("SELECT * FROM users WHERE national_id = :national_id");
            $stmt->execute(['national_id' => $user['national_id']]);
            
            if ($stmt->rowCount() > 0) {
                $stmt = $pdo->prepare("UPDATE users SET password = :password WHERE national_id = :national_id");
                $stmt->execute([
                    'password' => $plainPassword,
                    'national_id' => $user['national_id']
                ]);
            } else {
                $stmt = $pdo->prepare("INSERT INTO users (national_id, name, address, dob, email, mobile, telephone, role, username, password)
                                       VALUES (:national_id, :name, :address, :dob, :email, :mobile, :telephone, :role, :username, :password)");
                $stmt->execute([
                    'national_id' => $user['national_id'],
                    'name' => $user['name'],
                    'address' => $user['address'],
                    'dob' => $user['dob'],
                    'email' => $user['email'],
                    'mobile' => $user['mobile'],
                    'telephone' => $user['telephone'],
                    'role' => $user['role'],
                    'username' => $user['username'],
                    'password' => $plainPassword 
                ]);
            }

            $pdo->commit();
            unset($_SESSION['pending_user']);
            header("Location: logIn.php");
            exit;
        } catch (Exception $e) {
            $pdo->rollBack();
            $error = "Registration failed: " . $e->getMessage();
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Set Password</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<header class="main-header">
    <img src="images/al sharif.png" alt="Logo" class="logo">
    <h1 class="system-title">Al Sharif Flat Rent</h1>
    <a href="logout.php" class="logout-button">Logout</a>
</header>

<main>
    <h2>Create Password</h2>

    <?php if (!empty($error)) echo "<p class='error'>$error</p>"; ?>

    <form method="POST" class="login-box">
        <label for="password">Password:</label>
        <input type="password" name="password" id="password" class="input-main" required>

        <label for="confirm">Confirm Password:</label>
        <input type="password" name="confirm" id="confirm" class="input-main" required>

        <button type="submit" class="btn">Complete Registration</button>
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
