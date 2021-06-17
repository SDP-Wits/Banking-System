<?php
include "./helpers/server_details.php";

$clientID = $_REQUEST["clientID"];

$sql = "SELECT accountTypeID FROM `CLIENT-ACCOUNT` LEFT JOIN ACCOUNT
 ON `CLIENT-ACCOUNT`.accountNumber = ACCOUNT.accountNumber
 WHERE `CLIENT-ACCOUNT`.clientID = '$clientID' ";

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