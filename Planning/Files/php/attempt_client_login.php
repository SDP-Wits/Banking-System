<?php
include "./helpers/server_details.php";

$id = $_REQUEST['id'];
$password = $_REQUEST['password'];

//Sanitization
if (strlen($id) != 13 || !is_numeric($id)){
    echo json_encode(
        array(
            array("error" => "Invalid ID Number", "status" => FALSE)
        )
    );
    return;
}

$sql = "SELECT * FROM CLIENT INNER JOIN ADDRESS ON ADDRESS.idNumber = CLIENT.idNumber WHERE CLIENT.idNumber = '$id'";

$result = $conn->query($sql);

$output = array();

while ($row=$result->fetch_assoc()){
        $output[]=$row;
}

if (count($output) == 1){
    if ($password == $output[0]['password']){
        echo json_encode($output); //Successful login
        $conn->close();
        return;
    }else{
        echo json_encode(
            array(
                array("error" => "Invalid Password", "status" => FALSE)
            )
        );
        $conn->close();
        return;
    }
}

echo json_encode(
    array(
        array("error" => "This ID number is not registered", "status" => FALSE)
    )
);

$conn->close();
?>