<?php
$serverName = "fdb27.biz.nf";
$serverUsername = "3796506_ee";
$serverPassword = "SUdhJxteFny2sAj";
$dbName = "3796506_ee";
$serverPort = "3306";

// Create connection
$conn = new mysqli($serverName, $serverUsername, $serverPassword, $dbName, $serverPort);

// Check connection
if ($conn->connect_error) {
    echo json_encode(
        array(
            array("error" => "Connection Failed", "status" => FALSE)
        )
    );
    return;
}
?>