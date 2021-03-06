<?php
include "./helpers/server_details.php";
include "./helpers/encryption.php";

$clientIdNum = $_REQUEST["clientIdNum"];
$adminIdNum = $_REQUEST["adminIdNum"];
$currentDate = $_REQUEST["currentDate"];
$verificationStatus = $_REQUEST["verificationStatus"]; // if 0 - reject, if 1 - accept

//encrypting data
$clientIdNum = openssl_encrypt($clientIdNum, $ciphering, $encryption_key, $options, $encryption_iv);
$adminIdNum = openssl_encrypt($adminIdNum, $ciphering, $encryption_key, $options, $encryption_iv);

//get table IDs of client and admin by querying with actual ID numbers
$sql1 = "SELECT adminID AS ID FROM ADMIN WHERE idNumber = '$adminIdNum'";
$sql2 = "SELECT clientID AS ID FROM CLIENT WHERE idNumber = '$clientIdNum'";

$adminCheck = mysqli_query($conn, $sql1);
$clientCheck = mysqli_query($conn, $sql2);

if($adminCheck and $clientCheck) {
	$check_admin = mysqli_fetch_array($adminCheck);
	$check_client = mysqli_fetch_array($clientCheck);
	
        if ($verificationStatus == '1') {
                //update status of client to "verified" in CLIENT table
                $sql3 = "UPDATE CLIENT SET verificationStatus = 'Verified' WHERE idNumber = '$clientIdNum'";
                $acceptClient = mysqli_query($conn, $sql3);
                
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
                //update status of client to "rejected" in CLIENT table
                $sql4 = "UPDATE CLIENT SET verificationStatus = 'Rejected' WHERE idNumber = '$clientIdNum'";
                $rejectClient = mysqli_query($conn, $sql4);
                
                echo json_encode(
                    array(
                        array("status" => TRUE)
                    )
                );
        }

} else {
	echo json_encode(
        array(
            array("error" => "Unsuccessful", "status" => FALSE, "debug" => "Could not execute $sql.")
        )
    );
}
		
$conn->close();

?>