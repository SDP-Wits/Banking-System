<?php
include "./helpers/server_details.php";
include "./helpers/encryption.php";

//FOR BACK-END USE ONLY!!!

/*All secret keys:
notSecretKey
69420tristan
thisKeyIsASecret
*/

//create new key here - it gets encrypted
$date = "2021-09-05"; //test date - make current date
$newKey = "";
$newKey = openssl_encrypt($newKey, $ciphering, $encryption_key, $options, $encryption_iv);

//insert into online db
$stmt = $conn->prepare("INSERT INTO `SECRET KEY` (secretKey,creationDate) VALUES (?,?)");
$stmt->bind_param("ss", $newKey, $date);
$stmt->execute();

//decrypt check
$decrypt = openssl_decrypt($newKey, $ciphering, $decryption_key, $options, $decryption_iv);
echo $decrypt;
	

$conn->close();

?>