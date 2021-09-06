<?php
include "./helpers/server_details.php";
include "./helpers/encryption.php";

$clientIdNum = $_REQUEST["clientIdNum"];
$accountType = $_REQUEST["accountType"];
$currentDate = $_REQUEST["currentDate"];

//Testing example
/*$clientIdNum = "0011447788552";
$accountType = "5";
$currentDate = "2021-05-11";*/

//Creating an account number and randomised balance - TEMPORARILY!
$randomPart = mt_rand(10000,99999); //Gets a random integer value between 10000 and 99999
$accountNumber = substr($clientIdNum,7).$randomPart;	//Adds last six digits of client ID number to random integer
$currentBalance = mt_rand(1,999999).".".mt_rand(10,99);

//encrypting data
$currentBalance = openssl_encrypt($currentBalance, $ciphering, $encryption_key, $options, $encryption_iv);
$clientIdNum = openssl_encrypt($clientIdNum, $ciphering, $encryption_key, $options, $encryption_iv);
$accountNumber = openssl_encrypt($accountNumber, $ciphering, $encryption_key, $options, $encryption_iv);

//Create new account by inserting a new entry into the ACCOUNT
$stmt1 = $conn->prepare("INSERT INTO ACCOUNT (accountNumber,accountTypeID,currentBalance,createdDate) VALUES (?,?,?,?)");
$stmt1->bind_param("siss",$accountNumber,$accountType,$currentBalance,$currentDate);
$stmt1->execute();

//Obtaining unique id from CLIENT table by querying with the client ID number
$sql = "SELECT clientID AS ID FROM CLIENT WHERE idNumber = '$clientIdNum'";
$idCheck = mysqli_query($conn, $sql);
$idResult = mysqli_fetch_array($idCheck);

//Update CLIENT-ACCOUNT table as well
$stmt2 = $conn->prepare("INSERT INTO `CLIENT-ACCOUNT` (clientID, accountNumber) VALUES (?,?)");
$stmt2->bind_param("is",$idResult['ID'],$accountNumber);
$stmt2->execute();

//Obtaining name of account type for log description
$sql1 = "SELECT accountType AS accName FROM `ACCOUNT TYPE` WHERE accountTypeID = '$accountType'";
$accCheck = mysqli_query($conn, $sql1);
$accResult = mysqli_fetch_array($accCheck);
$desc = "Created a ".$accResult['accName'];

//Update LOG table as well
$stmt3 = $conn->prepare("INSERT INTO LOG (description, clientID) VALUES (?,?)");
$stmt3->bind_param("si",$desc,$idResult['ID']);
$stmt3->execute();

echo json_encode(
	array(
		array("status" => TRUE)
	)
);

$conn->close();

?>
