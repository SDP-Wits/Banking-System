<?php
include "./helpers/server_details.php";

$clientID = $_REQUEST["clientID"];

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