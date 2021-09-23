<?php
include "./helpers/server_details.php";
include "./helpers/encryption.php";

$accNum = $_REQUEST['accNum'];
$accNum = openssl_encrypt($accNum, $ciphering, $encryption_key, $options, $encryption_iv);

$sql = "SELECT TRANSACTION.transactionID, TRANSACTION.timeStamp, TRANSACTION.amount, TRANSACTION.accountFrom, TRANSACTION.accountTo, TRANSACTION.referenceName, TRANSACTION.referenceNumber
FROM TRANSACTION
WHERE TRANSACTION.accountTo = '$accNum' 
AND TRANSACTION.timeStamp BETWEEN DATE_ADD(TRANSACTION.timeStamp, INTERVAL -6 MONTH) AND SYSDATE()
OR TRANSACTION.accountFrom = '$accNum'
AND TRANSACTION.timeStamp BETWEEN DATE_ADD(TRANSACTION.timeStamp, INTERVAL -6 MONTH) And SYSDATE()";

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
        $decryptedTranID = $row["transactionID"];
        $decryptedTimeStamp = $row["timeStamp"];
        $decryptedAmount = $row["amount"];
        $decryptedAccountFrom = $row["accountFrom"];
        $decryptedAccountTo = $row["accountTo"];
        $decryptedReferenceName = $row["referenceName"];
        $decryptedReferenceNumber = $row["referenceNumber"];

        $decryptedTranID = openssl_decrypt($decryptedTranID, $ciphering, $decryption_key, $options, $decryption_iv);
        $decryptedTimeStamp = openssl_decrypt($decryptedTimeStamp, $ciphering, $decryption_key, $options, $decryption_iv);
        $decryptedAmount = openssl_decrypt($decryptedAmount, $ciphering, $decryption_key, $options, $decryption_iv);
        $decryptedAccountFrom = openssl_decrypt($decryptedAccountFrom, $ciphering, $decryption_key, $options, $decryption_iv);
        $decryptedAccountTo = openssl_decrypt($decryptedAccountTo, $ciphering, $decryption_key, $options, $decryption_iv);
        $decryptedReferenceName = openssl_decrypt($decryptedTimeStamp, $ciphering, $decryption_key, $options, $decryption_iv);
        $decryptedReferenceNumber = openssl_decrypt($decryptedTimeStamp, $ciphering, $decryption_key, $options, $decryption_iv);

        $output[]=$row;
}

echo json_encode($output);

$conn->close();
 ?>
