<?php
include "./helpers/server_details.php";
include "./helpers/encryption.php";


$id = $_REQUEST['id'];
$id = openssl_encrypt($id, $ciphering, $encryption_key, $options, $encryption_iv);

$sql = "SELECT * FROM CLIENT WHERE idNumber = '$id'";

$result = $conn->query($sql);
$data = mysqli_fetch_array($result);

if (mysqli_num_rows($result) < 1) { 
  echo json_encode(
    array(
      array(
        "status" => FALSE, "error" => "Client Table is Empty"
      )
    )
  );
  return;
 }else

$output = array();
$data['idNumber'] = openssl_decrypt ($data['idNumber'], $ciphering, $decryption_key, $options, $decryption_iv);
$data['email'] = openssl_decrypt ($data['email'], $ciphering, $decryption_key, $options, $decryption_iv);
$data['phoneNumber'] = openssl_decrypt ($data['phoneNumber'], $ciphering, $decryption_key, $options, $decryption_iv);

output = $data;
echo json_encode($output);

$conn->close();
?>