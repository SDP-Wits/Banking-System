<?php
header("Access-Control-Allow-Origin: *");

$serverName = "localhost";
$serverUsername = "executio";
$serverPassword = "1KA0hJ:[xAl7j4";
$dbName = "executio_main";

// Create connection
$conn = new mysqli($serverName, $serverUsername, $serverPassword, $dbName);

// Check connection
if ($conn->connect_error) {
    echo json_encode(
        array(
            array("error" => "Connection Failed", "status" => FALSE, "connect-error" => $conn->connect_error)
        )
    );
    return;
}
?>