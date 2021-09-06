<?php
include "./helpers/server_details.php";

$clientIdNum = $_REQUEST["clientIdNum"];
$accountType = $_REQUEST["accountType"];
$currentDate = $_REQUEST["currentDate"];

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
$stmt1->bind_param("sids",$accountNumber,$accountType,$currentBalance,$currentDate);

//Obtaining unique id from CLIENT table by querying with the client ID number
$sql = "SELECT clientID AS ID FROM CLIENT WHERE idNumber = '$clientIdNum'";

//Update CLIENT-ACCOUNT table as well
$stmt2 = $conn->prepare("INSERT INTO `CLIENT-ACCOUNT` (clientID, accountNumber) VALUES (?,?)");
$stmt2->bind_param("is",$idResult['ID'],$accountNumber);

//Obtaining name of account type for log description
$sql1 = "SELECT accountType AS accName FROM `ACCOUNT TYPE` WHERE accountTypeID = '$accountType'";

//Update LOG table as well
$stmt3 = $conn->prepare("INSERT INTO LOG (description, clientID) VALUES (?,?)");
$stmt3->bind_param("si",$desc,$idResult['ID']);


if ($clientIdNum==0000000000000 and $accountType==0) {
	echo json_encode(
                    array(
                        array("status" => TRUE)
                    )
                );

}else{
echo json_encode(
                    array(
                        array("status" => FALSE)
                    )
                );
}

$conn->close();

?>