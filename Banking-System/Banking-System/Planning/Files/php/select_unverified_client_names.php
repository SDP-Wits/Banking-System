<?php
include "./helpers/server_details.php";
include "./helpers/encryption.php";

$sql = "SELECT firstName, middleName,lastName,idNumber 
FROM CLIENT WHERE verificationStatus = 'Pending'";

$output = array();
if ($result = mysqli_query($conn,$sql)){
	while ($row=$result->fetch_assoc()){

		//decrypting the data
		$decryptedID = $row["idNumber"];
		$decryptResult = openssl_decrypt($decryptedID, $ciphering, $decryption_key, $options, $decryption_iv);
		$row["idNumber"] = $decryptResult;
		//

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
