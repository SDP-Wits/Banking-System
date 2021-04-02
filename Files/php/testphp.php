<?php
$servername = "fdb27.biz.nf";
$username = "3796506_ee";
$password = "SUdhJxteFny2sAj";



// Create connection
$conn = new mysqli($servername, $username, $password);

// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}
echo "Connected successfully";
?> 