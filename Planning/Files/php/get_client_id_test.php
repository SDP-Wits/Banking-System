<?php
include "./helpers/server_details.php";
include "./helpers/encryption.php";

$accountNumber = $_REQUEST['accountNumber'];
$accountNumber = openssl_encrypt($accountNumber, $ciphering, $encryption_key, $options, $encryption_iv);

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
  		$row = openssl_decrypt($row, $ciphering, $decryption_key, $options, $decryption_iv);
        $output[]=$row;
}

echo json_encode($output);

$conn->close();
?>