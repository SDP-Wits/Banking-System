<?php
include "./helpers/server_details.php";

$accNum = $_REQUEST['accNum'];

$sql = "SELECT * 
FROM ACCOUNT
INNER JOIN `CLIENT-ACCOUNT`ON ACCOUNT.accountNumber=`CLIENT-ACCOUNT`.accountNumber
INNER JOIN `ACCOUNT TYPE` ON `ACCOUNT TYPE`.accountTypeID=ACCOUNT.AccountTypeID
INNER JOIN LOG ON LOG.clientID = `CLIENT-ACCOUNT`.clientID
INNER JOIN TRANSACTION ON TRANSACTION.accountFrom = ACCOUNT.accountNumber OR TRANSACTION.accountTo = ACCOUNT.accountNumber
WHERE ACCOUNT.accountNumber = '$accNum'";

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