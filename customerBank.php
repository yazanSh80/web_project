<?php
session_start();
require_once("dbconfig.inc.php");
$pdo = db_connect();


if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $payment_card = $_POST['payment_card'];
    $cvv = $_POST['cvv'];
    $expiry_date = $_POST['expiry_date'];

    $user_id = $_SESSION['pending_user']['user_id']; 

    // insert customer data into the customers table
    try {
        $stmt = $pdo->prepare("
            INSERT INTO customers (customer_id, payment_card, cvv, expiry_date)
            VALUES (:user_id, :payment_card, :cvv, :expiry_date)
        ");
        $stmt->execute([
            'user_id' => $user_id, 
            'payment_card' => $payment_card,
            'cvv' => $cvv,
            'expiry_date' => $expiry_date
        ]);

        //store the customer data in a session variable
        $_SESSION['customer'] = [
            'user_id' => $user_id,
            'payment_card' => $payment_card,
            'cvv' => $cvv,
            'expiry_date' => $expiry_date
        ];

        //go to set password page
        header("Location: setPassword.php");
        exit;
    } catch (PDOException $e) {
        $error = "Database error: " . $e->getMessage();
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bank Info - Customer</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>


<header class="main-header">
    <img src="images/al sharif.png" alt="Logo" class="logo">

 

    <h1 class="system-title">Al Sharif Flat Rent</h1>


</header>


<main>
    <h2>Customer Bank Information</h2>

    <section class="form-box">
        <form method="POST">
            <label>Payment card:</label>
            <input type="text" name="payment_card" required maxlength="9">

            <label>CVV:</label>
            <input type="text" name="cvv" required maxlength="4">

            <label>Expiry Date:</label>
            <input type="date" name="expiry_date" required>

            <button type="submit">Next</button>
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

