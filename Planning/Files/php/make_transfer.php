<?php
include "./helpers/server_details.php";
include "./helpers/encryption.php";

function generateRandomString($length = 6) {
    $characters = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $charactersLength = strlen($characters);
    $randomString = '';
    for ($i = 0; $i < $length; $i++) {
        $randomString .= $characters[rand(0, $charactersLength - 1)];
    }
    return $randomString;
}

$accountFrom = $_REQUEST["accountFrom"];
$accountTo = $_REQUEST["accountTo"];
$amount = $_REQUEST["amount"];
$referenceName = $_REQUEST["referenceName"];
$referenceNumber = "TRAN";
$referenceNumber .= generateRandomString();

//encrypting data
$accountFrom = openssl_encrypt($accountFrom, $ciphering, $encryption_key, $options, $encryption_iv);
$accountTo = openssl_encrypt($accountTo, $ciphering, $encryption_key, $options, $encryption_iv);
$amount = openssl_encrypt($amount, $ciphering, $encryption_key, $options, $encryption_iv);
$referenceNumber = openssl_encrypt($referenceNumber, $ciphering, $encryption_key, $options, $encryption_iv);

$sql1 = "SELECT * FROM ACCOUNT WHERE accountNumber = '$accountFrom' ";
$sql2 = "SELECT * FROM ACCOUNT WHERE accountNumber = '$accountTo' ";

$check1 = mysqli_query($conn, $sql1);
$check2 = mysqli_query($conn, $sql2);

//check if accounts exist
if(mysqli_num_rows($check1) < 1) {
	echo json_encode(
		array(
			array( "status" => FALSE, "error" => "The account you want to transfer from does not exist" )
		)
	);
	return;
} elseif (mysqli_num_rows($check2) < 1) {
	echo json_encode(
		array(
			array( "status" => FALSE, "error" => "The account you want to transfer to does not exist" )
		)
	);
	return;
} else {
	$accFromRes = mysqli_fetch_array($check1);
	$accToRes = mysqli_fetch_array($check2);

	$sql3 = "SELECT clientID AS id FROM `CLIENT-ACCOUNT` WHERE accountNumber = '$accountFrom' ";
	$clientID = mysqli_query($conn, $sql3);
	$idResult = mysqli_fetch_array($clientID);

    $idNum = $idResult['id'];
	$sql4 = "SELECT firstName, lastName FROM CLIENT WHERE clientID = '$idNum' ";
    //$sql4 = "SELECT firstName, lastName FROM CLIENT WHERE clientID = 45 ";
	$clientName = mysqli_query($conn, $sql4);
	$nameResult = mysqli_fetch_array($clientName);
	$customerName = $nameResult['firstName'];
	$customerName .= " ";
	$customerName .= $nameResult['lastName'];

	//Adding transfer to TRANSACTION table
	$stmt1 = $conn->prepare("INSERT INTO TRANSACTION (customerName,amount,accountFrom,accountTo,referenceName,referenceNumber) VALUES (?,?,?,?,?,?)");
	$stmt1->bind_param("ssssss", $customerName, $amount, $accountFrom, $accountTo, $referenceName, $referenceNumber);
	$stmt1->execute();

	//updating each account's balance (have to decrypt first)
  	$amount = openssl_decrypt($amount, $ciphering, $encryption_key, $options, $encryption_iv);

	$oldBalance1 = $accFromRes['currentBalance'];
	$oldBalance1 = openssl_decrypt($oldBalance1, $ciphering, $encryption_key, $options, $encryption_iv);
	$newBalance1 = doubleval($oldBalance1) - doubleval($amount);
	$newBalance1 = openssl_encrypt($newBalance1, $ciphering, $encryption_key, $options, $encryption_iv);

	$stmt2 = $conn->prepare("UPDATE ACCOUNT SET currentBalance = ? WHERE accountNumber = ?");
	$stmt2->bind_param("ss", $newBalance1, $accountFrom);
	$stmt2->execute();

	$oldBalance2 = $accToRes['currentBalance'];
	$oldBalance2 = openssl_decrypt($oldBalance2, $ciphering, $encryption_key, $options, $encryption_iv);
	$newBalance2 = doubleval($oldBalance2) + doubleval($amount);
	$newBalance2 = openssl_encrypt($newBalance2, $ciphering, $encryption_key, $options, $encryption_iv);

	$stmt3 = $conn->prepare("UPDATE ACCOUNT SET currentBalance = ? WHERE accountNumber = ?");
	$stmt3->bind_param("ss", $newBalance2, $accountTo);
	$stmt3->execute();

	//logging transfer to LOG table
  		//decrypt account numbers first
  		$accToRes['accountNumber'] = openssl_decrypt($accToRes['accountNumber'], $ciphering, $encryption_key, $options, $encryption_iv);
  		$accFromRes['accountNumber'] = openssl_decrypt($accFromRes['accountNumber'], $ciphering, $encryption_key, $options, $encryption_iv);

	$stmt4 = $conn->prepare("INSERT INTO LOG (description, clientID) VALUES (?,?)");
	$desc1 = "Transfer to ";
	$desc1 .= $accToRes['accountNumber'];
	$desc1 .= " of ";
	$desc1 .= $amount;
	$stmt4->bind_param("si", $desc1, $idNum);
	$stmt4->execute();

	$stmt5 = $conn->prepare("INSERT INTO LOG (description, clientID)  VALUES (?,?)");
	$desc2 = "Transfer from ";
	$desc2 .= $accFromRes['accountNumber'];
	$desc2 .= " of ";
	$desc2 .= $amount;
	$stmt5->bind_param("si", $desc2, $idNum);
	$stmt5->execute();

	echo json_encode(
			array(
				array("status" => TRUE, "details" => "Successful transfer")
			)
		);

}

$conn->close();

?>