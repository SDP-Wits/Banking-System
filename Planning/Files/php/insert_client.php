<?php
include "./helpers/server_details.php";

$email = $_REQUEST['email'];
$phoneNumber = $_REQUEST['phoneNumber'];
$id = $_REQUEST['id'];
$password = $_REQUEST['password'];
$age = $_REQUEST['age'];
$firstName = $_REQUEST['firstName'];
$middleName = $_REQUEST['middleName'];
$lastName = $_REQUEST['lastName'];

// Create connection
$conn = new mysqli($serverName, $username, $password, $dbName);

// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "INSERT INTO CLIENT VALUES(18,'00115','someHashPass')";

if ($conn->query($sql)){
	echo "New record created successfully";
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?> 