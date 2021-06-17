<?php
include "./helpers/server_details.php";

$idNum = $_REQUEST['idNum'];

$sql = "SELECT CLIENT.firstName,CLIENT.middleName,CLIENT.lastName,`ACCOUNT TYPE`.accountType,`ACCOUNT TYPE`.accountTypeID,ACCOUNT.accountNumber,ACCOUNT.currentBalance
FROM ACCOUNT
INNER JOIN `CLIENT-ACCOUNT`ON ACCOUNT.accountNumber=`CLIENT-ACCOUNT`.accountNumber
INNER JOIN CLIENT ON CLIENT.clientID=`CLIENT-ACCOUNT`.clientID
INNER JOIN `ACCOUNT TYPE` ON `ACCOUNT TYPE`.accountTypeID=ACCOUNT.AccountTypeID
WHERE CLIENT.idNumber = '$idNum'";

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