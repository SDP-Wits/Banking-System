<?php
$servername = "fdb27.biz.nf";
$username = "3796506_ee";
$password = "SUdhJxteFny2sAj";
$dbname = "3796506_ee";


// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "INSERT INTO tempClient VALUES(18,'00115','someHashPass')";

if ($conn->query($sql)){
	echo "New record created successfully";
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?> 