<?php
include "./helpers/server_details.php";

$clientIdNum = $_REQUEST["clientIdNum"];
$accountType = $_REQUEST["accountType"];
$currentDate = $_REQUEST["currentDate"];


if ($clientIdNum==0000000000000 and $accountType==0) {
	echo json_encode(
                    array(
                        array("status" => TRUE)
                    )
                );

}else{
echo json_encode(
                    array(
                        array("status" => FALSE)
                    )
                );
}

$conn->close();

?>