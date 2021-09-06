<?php
include "./helpers/server_details.php";
include "./helpers/encryption.php";

$accNum = $_REQUEST['accNum'];

//encrypting data
$accNum = openssl_encrypt($accNum, $ciphering, $encryption_key, $options, $encryption_iv);

$sql = "SELECT ACCOUNT.accountNumber,ACCOUNT.accountTypeID, ACCOUNT.currentBalance, `ACCOUNT TYPE`.accountType,`ACCOUNT TYPE`.accountDescription,TRANSACTION.*
FROM ACCOUNT
INNER JOIN `ACCOUNT TYPE` ON `ACCOUNT TYPE`.accountTypeID=ACCOUNT.AccountTypeID
INNER JOIN TRANSACTION ON TRANSACTION.accountFrom = ACCOUNT.accountNumber OR TRANSACTION.accountTo = ACCOUNT.accountNumber
WHERE ACCOUNT.accountNumber = '$accNum'
GROUP BY TRANSACTION.transactionID";

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
        $decryptedAccNum = $row["accountNumber"];
        $decryptedCurrBalance = $row["currentBalance"];

        $decryptedAccNum = openssl_decrypt($decryptedAccNum, $ciphering, $decryption_key, $options, $decryption_iv);
        $decryptedCurrBalance = openssl_decrypt($decryptedCurrBalance, $ciphering, $decryption_key, $options, $decryption_iv);

        $row["accountNumber"] = $decryptedAccNum;
        $row["currentBalance"] = $decryptedCurrBalance;

  		$row["amount"] = openssl_decrypt($row["amount"], $ciphering, $decryption_key, $options, $decryption_iv);
  		$row["accountFrom"] = openssl_decrypt($row["accountFrom"], $ciphering, $decryption_key, $options, $decryption_iv);
  		$row["accountTo"] = openssl_decrypt($row["accountTo"], $ciphering, $decryption_key, $options, $decryption_iv);
  		$row["referenceNumber"] = openssl_decrypt($row["referenceNumber"], $ciphering, $decryption_key, $options, $decryption_iv);

        //

        $output[]=$row;
}

echo json_encode($output);

$conn->close();
?>