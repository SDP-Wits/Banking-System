<?php
include "./helpers/server_details.php";

$id = $_REQUEST['id'];

$sql = "SELECT * FROM CLIENT WHERE idNumber = '$id'";

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