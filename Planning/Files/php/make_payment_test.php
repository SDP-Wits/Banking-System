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

$referenceNumber = "TRAN";
$referenceNumber .= generateRandomString();

$accFrom = $_REQUEST['accFrom'];
$clientID = $_REQUEST['clientID'];
$clientName = $_REQUEST['clientName'];
$amount = $_REQUEST['amt'];
$accTo = $_REQUEST['accTo'];
$refname = $_REQUEST['refname'];
$refno = "PAY";
$refno .= generateRandomString();

//encrypting data
$accTo = openssl_encrypt($accTo, $ciphering, $encryption_key, $options, $encryption_iv);
$accFrom = openssl_encrypt($accFrom, $ciphering, $encryption_key, $options, $encryption_iv);
$amount = openssl_encrypt($amount, $ciphering, $encryption_key, $options, $encryption_iv);
$refno = openssl_encrypt($refno, $ciphering, $encryption_key, $options, $encryption_iv);

$sql1 = "SELECT * FROM ACCOUNT WHERE accountNumber = '$accFrom'";
$sql2 = "SELECT * FROM ACCOUNT WHERE accountNumber = '$accTo' ";

$check1 = mysqli_query($conn,$sql1);
$check2 = mysqli_query($conn,$sql2);

$rowcount = mysqli_num_rows($check);
                 
if(mysqli_num_rows($check2) < 1){
       echo json_encode(
            array(
              array(
                "status" => FALSE, "error" => "Account you want to transfer to does not exist"
              )
            )
          );
          return; 
}else{
  		// Doing calculation for accFrom
  		$accFromRes = mysqli_fetch_array($check1);
  		$oldBalance = openssl_decrypt ($accFromRes['currentBalance'], $ciphering, $decryption_key, $options, $decryption_iv);
  		$newBalance = $oldBalance - amount;
 		$newBalance = openssl_encrypt($newBalance, $ciphering, $encryption_key, $options, $encryption_iv);
  
  		// Updating accounts
        $sql1 = "UPDATE ACCOUNT 
        SET currentBalance=$newBalance
        WHERE accountNumber = '$accFrom'";
        
  		// Doing calculation for accTo
  		$accToRes = mysqli_fetch_array($check2);
    	$oldBalance = openssl_decrypt ($accToRes['currentBalance'], $ciphering, $decryption_key, $options, $decryption_iv);
  		$newBalance = $oldBalance + amount;
 		$newBalance = openssl_encrypt($newBalance, $ciphering, $encryption_key, $options, $encryption_iv);

        $sql2 = "UPDATE ACCOUNT 
        SET currentBalance=$newBalance	 
        WHERE accountNumber = '$accTo'";
        
        mysqli_query($conn,$sql1);
        mysqli_query($conn,$sql2);
        
        // INSERTING INTO TRANSACTION TABLE
	$stmt1 = $conn->prepare("INSERT INTO TRANSACTION (customerName,amount,accountFrom,accountTo,referenceName,referenceNumber) VALUES (?,?,?,?,?,?)");
	$stmt1->bind_param("ssdsss", $clientName, $amount, $accFrom, $accTo, $refname, $refno);
	$stmt1->execute();
        
        // LOGGING TRANSFER TO LOG TABLE
	$stmt4 = $conn->prepare("INSERT INTO LOG (description, clientID) VALUES (?,?)");
	$desc1 = "Payment to ";
	$desc1 .= $accTo;
	$desc1 .= " of ";
	$desc1 .= $amount;
	$stmt4->bind_param("si", $desc1, $clientID);
	$stmt4->execute();

	$stmt5 = $conn->prepare("INSERT INTO LOG (description, clientID)  VALUES (?,?)");
	$desc2 = "Payment from ";
	$desc2 .= $accFrom;
	$desc2 .= " of ";
	$desc2 .= $amount;
	$stmt5->bind_param("si", $desc2, $clientID);
	$stmt5->execute();

     
}
        


$conn->close();
?>