<?php
include "./helpers/server_details.php";

$sql = "SELECT COUNT(*) AS NumAccountTypes FROM `ACCOUNT TYPE`";

$result = mysqli_query($conn,$sql);

if (mysqli_num_rows($result) < 1) { 
  echo json_encode(
    array(
      array(
        "status" => FALSE, "error" => "Account types table is Empty"
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