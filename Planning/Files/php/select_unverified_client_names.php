<?php
include "./helpers/server_details.php";

$sql = "SELECT firstName, middleName,lastName,idNumber
FROM CLIENT LEFT JOIN `VERIFIED CLIENT` 
ON CLIENT.clientID = `VERIFIED CLIENT`.clientID 
WHERE `VERIFIED CLIENT`.clientID IS NULL";

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