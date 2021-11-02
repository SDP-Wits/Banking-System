<?php
include "./helpers/server_details.php";
include "./helpers/encryption.php";

$accountNumber = $_REQUEST['accountNumber'];
$accountNumber = openssl_encrypt($accountNumber, $ciphering, $encryption_key, $options, $encryption_iv);

$sql = "SELECT accountType FROM `ACCOUNT TYPE` INNER JOIN `ACCOUNT` ON `ACCOUNT`.accountNumber = '$accountNumber' AND `ACCOUNT`.accountTypeID = `ACCOUNT TYPE`.accountTypeID";

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

while ($row = $result->fetch_assoc()) {
  $output[] = $row;
}

echo json_encode($output);

$conn->close();
