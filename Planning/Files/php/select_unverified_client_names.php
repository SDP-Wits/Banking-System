<?php
include "./helpers/server_details.php";

// Create connection
$conn = new mysqli($serverName, $username, $password, $dbName);

// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT firstName, middleName,lastName 
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
	echo "ERROR: Could not able to execute $sql. " . mysqli_error($conn);
}

$conn->close();

?>