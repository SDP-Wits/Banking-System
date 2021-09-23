<?php
include "./helpers/server_details.php";
include "./helpers/encryption.php";

$clientID = $_REQUEST["clientID"];
$clientID = openssl_encrypt($clientID, $ciphering, $encryption_key, $options, $encryption_iv);



$sql = "SELECT * FROM LOG WHERE clientID = '$clientID'";

$output = array();
if ($result = mysqli_query($conn,$sql)){
	while ($row=$result->fetch_assoc()){
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