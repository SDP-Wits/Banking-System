<?php
include "./helpers/server_details.php";

$accNum = $_REQUEST['accNum'];

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
        $output[]=$row;
}

echo json_encode($output);

$conn->close();
?>