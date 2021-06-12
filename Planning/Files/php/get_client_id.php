<?php
include "./helpers/server_details.php";

$accountNumber = $_REQUEST['accountNumber'];

$sql = "SELECT clientID FROM `CLIENT-ACCOUNT` WHERE accountNumber = '$accountNumber'";

$result = $conn->query($sql);

if (mysqli_num_rows($result) < 1) { 
  echo json_encode(
    array(
      array(
        "status" => FALSE, "error" => "Account does not exist"
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