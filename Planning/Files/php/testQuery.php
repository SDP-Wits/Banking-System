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

$sql = "SELECT * FROM tempClient";


$result = $conn->query($sql);

$output = array();

while ($row=$result->fetch_assoc()){
        $output[]=$row;
}

echo json_encode($output);

  $conn->close();
?>