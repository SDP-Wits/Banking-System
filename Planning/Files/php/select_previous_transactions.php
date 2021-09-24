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
        $row["amount"] = openssl_decrypt($row["amount"], $ciphering, $decryption_key, $options, $decryption_iv);
        $row["accountFrom"] = openssl_decrypt($row["accountFrom"], $ciphering, $decryption_key, $options, $decryption_iv);
        $row["accountTo"] = openssl_decrypt($row["accountTo"], $ciphering, $decryption_key, $options, $decryption_iv);
        $row["referenceNumber"] = openssl_decrypt($row["referenceNumber"], $ciphering, $decryption_key, $options, $decryption_iv);

        $output[]=$row;
}

echo json_encode($output);

$conn->close();
 ?>
