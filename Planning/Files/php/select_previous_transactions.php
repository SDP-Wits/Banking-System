<?php
include "./helpers/server_details.php";
include "./helpers/encryption.php";

$idNum = $_REQUEST['idNum'];
$idNum = openssl_encrypt($idNum, $ciphering, $encryption_key, $options, $encryption_iv);

$sql = "SELECT CLIENT.firstName,CLIENT.middleName,CLIENT.lastName,`ACCOUNT TYPE`.accountType,`ACCOUNT TYPE`.accountTypeID,ACCOUNT.accountNumber,ACCOUNT.currentBalance,
TRANSACTION.transactionID, TRANSACTION.timeStamp, TRANSACTION.amount, TRANSACTION.accountFrom, TRANSACTION.accountTo, TRANSACTION.referenceName, TRANSACTION.referenceNumber
FROM ACCOUNT
INNER JOIN `CLIENT-ACCOUNT`ON ACCOUNT.accountNumber=`CLIENT-ACCOUNT`.accountNumber
INNER JOIN CLIENT ON CLIENT.clientID=`CLIENT-ACCOUNT`.clientID
INNER JOIN `ACCOUNT TYPE` ON `ACCOUNT TYPE`.accountTypeID=ACCOUNT.AccountTypeID
INNER JOIN TRANSACTION ON TRANSACTION.accountFrom = ACCOUNT.accountNumber
WHERE TRANSACTION.timeStamp BETWEEN DATE_ADD(TRANSACTION.timeStamp, INTERVAL -6 MONTH) AND SYSDATE()
AND CLIENT.idNumber = '$idNum'
UNION
SELECT CLIENT.firstName,CLIENT.middleName,CLIENT.lastName,`ACCOUNT TYPE`.accountType,`ACCOUNT TYPE`.accountTypeID,ACCOUNT.accountNumber,ACCOUNT.currentBalance,
TRANSACTION.transactionID, TRANSACTION.timeStamp, TRANSACTION.amount, TRANSACTION.accountFrom, TRANSACTION.accountTo, TRANSACTION.referenceName, TRANSACTION.referenceNumber
FROM ACCOUNT
INNER JOIN `CLIENT-ACCOUNT`ON ACCOUNT.accountNumber=`CLIENT-ACCOUNT`.accountNumber
INNER JOIN CLIENT ON CLIENT.clientID=`CLIENT-ACCOUNT`.clientID
INNER JOIN `ACCOUNT TYPE` ON `ACCOUNT TYPE`.accountTypeID=ACCOUNT.AccountTypeID
INNER JOIN TRANSACTION ON TRANSACTION.accountTo = ACCOUNT.accountNumber
WHERE TRANSACTION.timeStamp BETWEEN DATE_ADD(TRANSACTION.timeStamp, INTERVAL -6 MONTH) AND SYSDATE()
AND CLIENT.idNumber = '$idNum'";

$result = mysqli_query($conn,$sql);

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

$output = array();

while ($row=$result->fetch_assoc()){

        //decrypting the data
        $row["amount"] = openssl_decrypt($row["amount"], $ciphering, $decryption_key, $options, $decryption_iv);
        $row["accountFrom"] = openssl_decrypt($row["accountFrom"], $ciphering, $decryption_key, $options, $decryption_iv);
        $row["accountTo"] = openssl_decrypt($row["accountTo"], $ciphering, $decryption_key, $options, $decryption_iv);
        $row["referenceNumber"] = openssl_decrypt($row["referenceNumber"], $ciphering, $decryption_key, $options, $decryption_iv);
  		$row["accountNumber"] = openssl_decrypt($row["accountNumber"], $ciphering, $decryption_key, $options, $decryption_iv);
  		$row["currentBalance"] = openssl_decrypt($row["currentBalance"], $ciphering, $decryption_key, $options, $decryption_iv);

        $output[]=$row;
}

echo json_encode($output);

$conn->close();
 ?>
