<?php
include "./helpers/server_details.php";

$accNum = $_REQUEST['accNum'];

$sql = "SELECT * FROM ACCOUNT WHERE accountNumber = '$accNum'";

$result = $conn->query($sql);

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