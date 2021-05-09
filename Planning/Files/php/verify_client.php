<?php
include "./helpers/server_details.php";

$clientIdNum = $_REQUEST["clientIdNum"];
$adminIdNum = $_REQUEST["adminIdNum"];
$currentDate = $_REQUEST["currentDate"];

//test example
/*$clientIdNum = '0070070070071';
$adminIdNum = '0000033999999';
$currentDate = '2021-04-14';*/

//get table IDs of client and admin by querying with actual ID numbers
$sql1 = "SELECT adminID AS ID FROM ADMIN WHERE idNumber = '$adminIdNum'";
$sql2 = "SELECT clientID AS ID FROM CLIENT WHERE idNumber = '$clientIdNum'";

$adminCheck = mysqli_query($conn, $sql1);
$clientCheck = mysqli_query($conn, $sql2);

if($adminCheck and $clientCheck) {
	$check_admin = mysqli_fetch_array($adminCheck);
	$check_client = mysqli_fetch_array($clientCheck);
	
        //insert entry into VERIFIED CLIENTS therefore updating client status to verified
	$stmt = $conn->prepare("INSERT INTO `VERIFIED CLIENT` (clientID,verifiedDate,verifiedBy) VALUES (?,?,?)");
	$stmt->bind_param("isi",$check_client['ID'],$currentDate,$check_admin['ID']);
	$stmt->execute();
        
        //I added this code here to return status true so we know it was successful
        echo json_encode(
            array(
                array("status" => TRUE)
            )
        );

} else {
	echo json_encode(
        array(
            array("error" => "Unsuccessful", "status" => FALSE, "debug" => "Could not execute $sql.")
        )
    );
}
		
$conn->close();

?>