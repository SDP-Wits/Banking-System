<?php
include "./helpers/server_details.php";
include "./helpers/encryption.php";

$idNum = $_REQUEST['idNum'];
$idNum = openssl_encrypt($idNum, $ciphering, $encryption_key, $options, $encryption_iv);

$sql = "SELECT CLIENT.firstName,CLIENT.middleName,CLIENT.lastName,`ACCOUNT TYPE`.accountType,`ACCOUNT TYPE`.accountTypeID,ACCOUNT.accountNumber,ACCOUNT.currentBalance
FROM ACCOUNT
INNER JOIN `CLIENT-ACCOUNT`ON ACCOUNT.accountNumber=`CLIENT-ACCOUNT`.accountNumber
INNER JOIN CLIENT ON CLIENT.clientID=`CLIENT-ACCOUNT`.clientID
INNER JOIN `ACCOUNT TYPE` ON `ACCOUNT TYPE`.accountTypeID=ACCOUNT.AccountTypeID
WHERE CLIENT.idNumber = '$idNum'";

$result = mysqli_query($conn,$sql);
$data = mysqli_fetch_array($result);



if (mysqli_num_rows($result) < 1) { 
  echo json_encode(
    array(
      array(
        "status" => FALSE, "error" => "Client Table is Empty"
      )
    )
  );
  return;
 }




while ($row=$result->fetch_assoc()){
  	$row['accountNumber'] = openssl_decrypt($row['accountNumber'], $ciphering, $decryption_key, $options, $decryption_iv);
    $row['currentBalance'] = openssl_decrypt($row['currentBalance'], $ciphering, $decryption_key, $options, $decryption_iv);
  	

    $output[]=$row;
}

echo json_encode($output);

$conn->close();
?>