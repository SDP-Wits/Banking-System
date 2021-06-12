<?php
include "./helpers/server_details.php";

$clientIdNum = $_REQUEST["clientIdNum"];
$adminIdNum = $_REQUEST["adminIdNum"];
$currentDate = $_REQUEST["currentDate"];
$verificationStatus = $_REQUEST["verificationStatus"];

if ($clientIdNum==1 and $adminIdNum==1) {
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