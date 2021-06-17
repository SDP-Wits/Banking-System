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

$checkAccount = "SELECT * FROM ACCOUNT WHERE accountNumber = '$accTo'";
$check = mysqli_query($conn,$checkAccount);
$rowcount = mysqli_num_rows($check);
                 
echo json_encode($rowcount);

if($rowcount==0){
       echo json_encode(
            array(
              array(
                "status" => FALSE, "error" => "Account does not exist"
              )
            )
          );
          return; 
}else{
        $sql1 = "UPDATE ACCOUNT 
        SET currentBalance=currentBalance+$amount
        WHERE accountNumber = '$accTo'";
        
        $sql2 = "UPDATE ACCOUNT 
        SET currentBalance=currentBalance-$amount
        WHERE accountNumber = '$accFrom'";
        
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