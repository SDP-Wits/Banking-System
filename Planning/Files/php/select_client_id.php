<?php
include "./helpers/server_details.php";
include "./helpers/encryption.php";

$id = $_REQUEST['id'];
$id = openssl_encrypt($id, $ciphering, $encryption_key, $options, $encryption_iv);

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
    //decrypting the ID
    $decryptedID = $row["idNumber"];
    $decryptedID = openssl_decrypt($decryptedID, $ciphering, $decryption_key, $options, $decryption_iv);
    $row["idNumber"] = $decryptedID;

    //decrypting the email
    $decryptedEmail = $row["email"];
    $decryptedEmail = openssl_decrypt($decryptedEmail, $ciphering, $decryption_key, $options, $decryption_iv);
    $row["mail"] = $decryptedEmail;

    //decrypting the phone number
    $decryptedPhone = $row["phoneNumber"];
    $decryptedPhone = openssl_decrypt($decryptedPhone, $ciphering, $decryption_key, $options, $decryption_iv);
    $row["phoneNumber"] = $decryptedPhone;

    $output[]=$row;
}

echo json_encode($output);

$conn->close();
?>