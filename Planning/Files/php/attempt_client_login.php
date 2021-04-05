<?php
include "./helpers/server_details.php";

$id = $_REQUEST['id'];
$password = $_REQUEST['password'];

if (strlen($id) != 13 || !is_numeric($id)){
    echo json_decode([["error" => "Invalid ID Number"]]);
    return;
}

// Create connection
$conn = new mysqli($serverName, $username, $password, $dbName);

// Check connection
if ($conn->connect_error) {
    echo json_decode([["error" => "Connection Failed"]]);
  die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT password FROM CLIENT WHERE id = $id";

$result = $conn->query($sql);

$output = array();

while ($row=$result->fetch_assoc()){
        $output[]=$row;
}

if (count($output) == 1){
    if ($password == $output['password']){
        echo json_encode([["status" => TRUE]]); //Successful login
        $conn->close();
        return;
    }
}

echo json_encode([["error" => "This ID number is not registered"]]);

$conn->close();
?>