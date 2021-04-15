<?php
include "./helpers/server_details.php";

$clientIdNum = $_REQUEST["clientIdNum"];
$adminIdNum = $_REQUEST["adminIdNum"];
$currentDate = $_REQUEST["currentDate"];

/*
$clientIdNum = '8';
$adminIdNum = '42';
$currentDate = '2021-04-14';
*/

$sql1 = "SELECT adminID AS ID FROM ADMIN WHERE idNumber = '$adminIdNum'";
$sql2 = "SELECT clientID AS ID FROM CLIENT WHERE idNumber = '$clientIdNum'";

$adminCheck = mysqli_query($conn, $sql1);
$clientCheck = mysqli_query($conn, $sql2);

if($adminCheck and $clientCheck) {
	$check_admin = mysqli_fetch_array($adminCheck);
	$check_client = mysqli_fetch_array($clientCheck);
	
	$stmt = $conn->prepare("INSERT INTO `VERIFIED CLIENT` (clientID,verifiedDate,verifiedBy) VALUES (?,?,?)");
	$stmt->bind_param("isi",$check_client['ID'],$currentDate,$check_admin['ID']);
	$stmt->execute();

} else {
	echo json_encode(
        array(
            array("error" => "Unsuccessful", "status" => FALSE, "debug" => "Could not execute $sql.")
        )
    );
}
		
$conn->close();

?>