<?php
session_start();
require_once("dbconfig.inc.php");
$pdo=db_connect();
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $national_id = $_POST["national_id"];
    $name = $_POST["name"];
    $address = $_POST["address"];
    $dob = $_POST["dob"];
    $email = $_POST["email"];
    $mobile = $_POST["mobile"];
    $telephone = $_POST["telephone"];
    $username = $_POST["username"];
    $role = $_POST["role"];

    if (!in_array($role, ['customer', 'owner'])) {
        $error = "Invalid role selected.";
    } else {
        try {
            $stmt = $pdo->prepare("SELECT * FROM users WHERE email = :email OR username = :username");
            $stmt->execute(['email' => $email, 'username' => $username]);
            if ($stmt->rowCount() > 0) {
                $error = "Email or username already exists.";
            } else {
                $stmt = $pdo->prepare("INSERT INTO users (national_id, name, address, dob, email, mobile, telephone, role, username)
                                       VALUES (:national_id, :name, :address, :dob, :email, :mobile, :telephone, :role, :username)");
                $stmt->execute([
                    'national_id' => $national_id,
                    'name' => $name,
                    'address' => $address,
                    'dob' => $dob,
                    'email' => $email,
                    'mobile' => $mobile,
                    'telephone' => $telephone,
                    'role' => $role,
                    'username' => $username
                ]);

                $_SESSION['pending_user'] = [
                    'national_id' => $national_id,
                    'name' => $name,
                    'address' => $address,
                    'dob' => $dob,
                    'email' => $email,
                    'mobile' => $mobile,
                    'telephone' => $telephone,
                    'username' => $username,
                    'role' => $role,
                    'user_id' => $pdo->lastInsertId()
                ];

                if ($role === 'owner') {
                    header("Location: ownerBank.php");
                } else {
                    header("Location: customerBank.php");
                }
                exit;
            }
        } catch (PDOException $e) {
            $error = "Database error: " . $e->getMessage();
        }
    }
}
?>



<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Sign Up - Birzeit Flat Rent</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>

<header class="main-header">
  <img src="images/al sharif.png" alt="Logo" class="logo">
  <h1 class="system-title">Al Sharif Flat Rent</h1>
  <a href="logout.php" class="logout-button">Logout</a>
</header>
<nav>
  <section class="next-side">
    <article class="next-article">
      <section>
        <p><a href="logIn.php">Log In</a></p>
        <p><a href="signup.php">Sign Up</a></p>
        <p><a href="main_guest.php">Log in as guest</a></p>
      </section>
    </article>
  </section>
</nav>
<main class="signup-main">


  <section class="signup-side">
    <section class="login-box">
      <h2>Create Account</h2>
      <?php if (!empty($error)) echo "<p class='error'>$error</p>"; ?>
      <form method="POST" action="signup.php">
        <label>National ID:</label><br>
        <input type="text" name="national_id" class="input-main" required maxlength="9"><br><br>

        <label>Name:</label><br>
        <input type="text" name="name" class="input-main" required><br><br>

        <label>Address:</label><br>
        <input type="text" name="address" class="input-main" required><br><br>

        <label>Date of Birth:</label><br>
        <input type="date" name="dob" class="input-main" required><br><br>

        <label>Email:</label><br>
        <input type="email" name="email" class="input-main" required><br><br>

        <label>Mobile:</label><br>
        <input type="text" name="mobile" class="input-main" required><br><br>

        <label>Telephone:</label><br>
        <input type="text" name="telephone" class="input-main" required><br><br>

        <label>Username:</label><br>
        <input type="text" name="username" class="input-main" required><br><br>

        <label>Role:</label><br>
        <select name="role" class="input-main" required>
          <option value="customer">Customer</option>
          <option value="owner">Owner</option>
        </select><br><br>

        <input type="submit" value="Next" class="login-button">
      </form>
    </section>
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
