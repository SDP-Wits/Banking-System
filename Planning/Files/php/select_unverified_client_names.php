<?php
include "./helpers/server_details.php";
include "./helpers/encryption.php";

$sql = "SELECT *
FROM CLIENT WHERE verificationStatus = 'Pending'";

$output = array();
if ($result = mysqli_query($conn,$sql)){
	while ($row=$result->fetch_assoc()){

		//decrypting the data
		$decryptedID = $row["idNumber"];
		$decryptResult = openssl_decrypt($decryptedID, $ciphering, $decryption_key, $options, $decryption_iv);
		$row["idNumber"] = $decryptResult;
		//

		//decrypting the email
		$decryptedEmail = $row["email"];
		$decryptedEmail = openssl_decrypt($decryptedEmail, $ciphering, $decryption_key, $options, $decryption_iv);
		$row["email"] = $decryptedEmail;
	
		//decrypting the phone number
		$decryptedPhone = $row["phoneNumber"];
		$decryptedPhone = openssl_decrypt($decryptedPhone, $ciphering, $decryption_key, $options, $decryption_iv);
		$row["phoneNumber"] = $decryptedPhone;

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
