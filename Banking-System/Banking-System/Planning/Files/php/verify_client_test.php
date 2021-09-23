<?php
include "./helpers/server_details.php";
include "./helpers/encryption.php";

$clientIdNum = $_REQUEST["clientIdNum"];
$adminIdNum = $_REQUEST["adminIdNum"];
$currentDate = $_REQUEST["currentDate"];
$verificationStatus = $_REQUEST["verificationStatus"];

//encrypting data
$clientIdNum = openssl_encrypt($clientIdNum, $ciphering, $encryption_key, $options, $encryption_iv);
$adminIdNum = openssl_encrypt($adminIdNum, $ciphering, $encryption_key, $options, $encryption_iv);

$sql1 = "SELECT adminID AS ID FROM ADMIN WHERE idNumber = '$adminIdNum'";
$sql2 = "SELECT clientID AS ID FROM CLIENT WHERE idNumber = '$clientIdNum'";

$adminCheck = mysqli_query($conn, $sql1);
$clientCheck = mysqli_query($conn, $sql2);

if ($clientIdNum==1 and $adminIdNum==1) {

        $check_admin = mysqli_fetch_array($adminCheck);
	$check_client = mysqli_fetch_array($clientCheck);
        
        $sql3 = "UPDATE CLIENT SET verificationStatus = 'Verified' WHERE idNumber = '$clientIdNum'";
                
        //insert entry into VERIFIED CLIENTS therefore updating client status to verified
        $stmt = $conn->prepare("INSERT INTO `VERIFIED CLIENT` (clientID,verifiedDate,verifiedBy) VALUES (?,?,?)");
        $stmt->bind_param("isi",$check_client['ID'],$currentDate,$check_admin['ID']);
        
	echo json_encode(
                    array(
                        array("status" => TRUE)
                    )
                );

} else {
	echo json_encode(
        array(
            array("error" => "Unsuccessful", "status" => FALSE, "debug" => "Could not execute")
        )
    );
}
		
$conn->close();

?>