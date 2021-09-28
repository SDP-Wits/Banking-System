<?php
include "./helpers/server_details.php";
include "./helpers/encryption.php";

//Import PHPMailer classes into the global namespace
//These must be at the top of your script, not inside a function
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

//Load Composer's autoloader
require 'vendor/autoload.php';

$email = $_REQUEST['email'];
$isAdmin = $_REQUEST['isAdmin'];

$cleanEmail = $email;
//encrypting data
$email = openssl_encrypt($email, $ciphering, $encryption_key, $options, $encryption_iv);

$sql = "";
if ($isAdmin) {
    $sql = "SELECT * FROM ADMIN WHERE ADMIN.email = '$email'";
} else {
    $sql = "SELECT * FROM CLIENT WHERE CLIENT.email = '$email'";
}

$result = $conn->query($sql);

$row = mysqli_fetch_array($result);

if ($row) {
    $token = md5($email) . rand(10, 9999);

    $expFormat = mktime(
        date("H"),
        date("i"),
        date("s"),
        date("m"),
        date("d") + 1,
        date("Y")
    );

    $expDate = date("Y-m-d H:i:s", $expFormat);

    if ($isAdmin) {
        $update = mysqli_query($conn, "UPDATE ADMIN SET password=" + $password + " WHERE email=" + $email);
    } else {
        $update = mysqli_query($conn, "UPDATE CLIENT SET password=" + $password + " WHERE email=" + $email);
    }

    $link = "<a href='www.execution-empire.co.za/php/reset-password.php?key=" . $email . "&token=" . $token . "'>Click To Reset password</a>";

    require_once('phpmail/PHPMailerAutoload.php');

    $mail = new PHPMailer();

    $mail->CharSet =  "utf-8";
    $mail->IsSMTP();
    // enable SMTP authentication
    $mail->SMTPAuth = true;
    // GMAIL username
    $mail->Username = "executio@execution-empire.co.za";
    // GMAIL password
    $mail->Password = "1KA0hJ:[xAl7j4";
    $mail->SMTPSecure = "ssl";
    // sets GMAIL as the SMTP server
    $mail->Host = "smtp.gmail.com";
    // set the SMTP port for the GMAIL server
    $mail->Port = "465";
    $mail->From = 'executio@execution-empire.co.za';
    $mail->FromName = 'Execution Empire';
    $mail->AddAddress($cleanEmail, $row['firstName'] +  ' ' + $row['lastName']);
    $mail->Subject  =  'Reset Password';
    $mail->IsHTML(true);
    $mail->Body    = 'Click On This Link to Reset Password ' . $link . '';
    if ($mail->Send()) {
        echo json_encode(
            array(
                array("details" => "If there is a registered email, a password reset will be sent out.", "status" => FALSE)
            )
        );
    } else {
        echo json_encode(
            array(
                array("error" => "Mail Error.", "status" => FALSE)
            )
        );
    }
} else {
    echo json_encode(
        array(
            array("error" => "No Mail Found.", "status" => FALSE)
        )
    );
}



$conn->close();
