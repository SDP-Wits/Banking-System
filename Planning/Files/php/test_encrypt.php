<?php
include "./helpers/server_details.php";
include "./helpers/encryption.php";

//get data
$testData = "Execution Empirer";
//encrypt data
$encryptedData = openssl_encrypt($testData, $ciphering, $encryption_key, $options, $encryption_iv);
echo $encryptedData;

//make sql request
$stmt = $conn->prepare("INSERT INTO TEST_ENCRYPTION (testData) VALUES (?)");
$stmt->bind_param("s", $encryptedData);
$stmt->execute();

//print if process is successful
echo json_encode(
    array(
        array("status" => TRUE, "details" => "Successful")
    )
);
	
$conn->close();

?>