<?php
include "./helpers/server_details.php";
include "./helpers/encryption.php";

$clientID = "7";

//make sql request
$sql = "SELECT testData FROM TEST_ENCRYPTION WHERE idNumber = '$clientID'";

$output = array();
if ($result = mysqli_query($conn,$sql)){
	while ($row=$result->fetch_assoc()){
      	//decrypting the data
      	$decryptedData = $row["testData"];
      	$decryptResult = openssl_decrypt($decryptedData, $ciphering, $decryption_key, $options, $decryption_iv);
      	$row["testData"] = $decryptResult;
      
		$output[] = $row;
	}
  	echo json_encode($output);
} else{
	echo json_encode(
        array(
            array("error" => "Unsuccessful", "status" => FALSE, "debug" => "Could not execute $sql.")
        )
    );
}
	
$conn->close();

?>