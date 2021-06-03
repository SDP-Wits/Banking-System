<?php

include "./helpers/server_details.php";

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

	$sql3 = "SELECT clientID AS id FROM CLIENT-ACCOUNT WHERE accountNumber = '$accountFrom' ";
	$clientID = mysqli_query($conn, $sql3);
	$idResult = mysqli_fetch_array($clientID);

	$sql4 = "SELECT firstName, lastName FROM CLIENT WHERE clientID = '$idResult['id']' ";
	$clientName = mysqli_query($conn, $sql4);
	$nameResult = mysqli_fetch_array($clientName);
	$customerName = $clientName['firstName'];
	$customerName .= " ";
	$customerName .= clientname['lastName'];

	//Adding transfer to TRANSACTION table
	$stmt1 = $conn->prepare("INSERT INTO TRANSACTION (customerName,timeStamp,amount,accountFrom,accountTo,referenceName,referenceNumber) VALUES (?,?,?,?,?,?,?)");
	$stmt1->bind_param("ssdssss", $customerName, NOW(), $amount, $accountFrom, $accountTo, $referenceName, $referenceNumber);
	$stmt1->execute();

	//updating each account's balance
	$newBalance1 = $accFromRes['currentBalance'] - $amount;
	$stmt2 = $conn->prepare("UPDATE ACCOUNT SET currentBalance = ? WHERE accountNumber = ?) ";
	$stmt2->bind_param("ds", $newBalance1, $accountFrom);
	$stmt2->execute();

	$newBalance2 = $accToRes['currentBalance'] + $amount;
	$stmt3 = $conn->prepare("UPDATE ACCOUNT SET currentBalance = ? WHERE accountNumber = ?) ";
	$stmt3->bind_param("ds", $newBalance2, $accountTo);
	$stmt3->execute();

	//logging transfer to LOG table
	$stmt4 = $conn->prepare("INSERT INTO LOG (timeStamp, description, clientID)");
	$desc1 = "Transfer to ";
	$desc1 .= $accToRes['accountNumber'];
	$desc1 .= " of ";
	$desc1 .= $amount;
	$stmt4->bind_param("ssi", NOW(), $desc1, $idResult['id']);
	$stmt4->execute();

	$stmt5 = $conn->prepare("INSERT INTO LOG (timeStamp, description, clientID)");
	$desc2 = "Transfer from ";
	$desc2 .= $accFromRes['accountNumber'];
	$desc2 .= " of ";
	$desc2 .= $amount;
	$stmt5->bind_param("ssi", NOW(), $desc2, $idResult['id']);
	$stmt5->execute();

	echo json_encode(
			array(
				array("status" => TRUE, "details" => "Successful transfer")
			)
		);
	
}

$conn->close();

?>