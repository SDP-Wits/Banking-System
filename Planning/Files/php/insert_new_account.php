<?php
include "./helpers/server_details.php";

$clientIdNum = $_REQUEST["clientIdNum"];
$accountType = $_REQUEST["accountType"];
$currentDate = $_REQUEST["currentDate"];

//Testing example
/*$clientIdNum = "2020200202000";
$accountType = "3";
$currentDate = "1999-03-05";*/

//Creating an account number and randomised balance - TEMPORARILY!
$randomPart = mt_rand(10000,99999); //Gets a random integer value between 10000 and 99999
$accountNumber = substr($clientIdNum,7).$randomPart;	//Adds last six digits of client ID number to random integer
$currentBalance = mt_rand(1,999999).".".mt_rand(10,99);

//Create new account by inserting a new entry into the ACCOUNT
$stmt1 = $conn->prepare("INSERT INTO ACCOUNT (accountNumber,accountTypeID,currentBalance,createdDate) VALUES (?,?,?,?)");
$stmt1->bind_param("sids",$accountNumber,$accountType,$currentBalance,$currentDate);
$stmt1->execute();

//Obtaining unique id from CLIENT table by querying with the client ID number
$sql = "SELECT clientID AS ID FROM CLIENT WHERE idNumber = '$clientIdNum'";
$idCheck = mysqli_query($conn, $sql);
$idResult = mysqli_fetch_array($idCheck);

//Update CLIENT-ACCOUNT table as well
$stmt2 = $conn->prepare("INSERT INTO `CLIENT-ACCOUNT` (clientID, accountNumber) VALUES (?,?)");
$stmt2->bind_param("is",$idResult['ID'],$accountNumber);
$stmt2->execute();

echo json_encode(
	array(
		array("status" => TRUE)
	)
);

$conn->close();

?>