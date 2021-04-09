<?php
include "./helpers/server_details.php";

$firstName = $_REQUEST["firstName"];
$middleName = $_REQUEST["middleName"];
$lastName = $_REQUEST["lastName"];
$age = $_REQUEST["age"];
$phoneNum = $_REQUEST["phoneNum"];
$email = $_REQUEST["email"];
$idNum = $_REQUEST["idNum"];
$password = $_REQUEST["password"];

/*$streetName = $_REQUEST["streetName"];
$streetNum = $_REQUEST["streetNum"];
$suburb = $_REQUEST["suburb"];
$province = $_REQUEST["province"];
$country = $_REQUEST["country"];
$apartmentNum = $_REQUEST["apartmentNum"];*/

$sql1 = "SELECT COUNT(*) AS RESULT FROM CLIENT WHERE idNumber = '$idNum'";

if($check = mysqli_query($conn, $sql1)) {
	$check_count = mysqli_fetch_array($check);
    if($check_count['RESULT'] != '0'){
		echo json_encode(
			array(
				array("status" => TRUE, "details" => "USER_EXISTS")
			)
		);
    } else {
		$stmt = $conn->prepare("INSERT INTO CLIENT (email,phoneNumber,idNumber,password,age,firstName,middleName,lastName) VALUES (?,?,?,?,?,?,?,?)");
		$stmt->bind_param("ssssisss", $email, $phoneNum, $idNum, $password, $age, $firstName, $middleName, $lastName);
		$stmt->execute();
		
		/*$stmt1 = $conn->prepare("INSERT INTO ADDRESS (idNumber, streetName, streetNumber, suburb, province, country, apartmentNumber) VALUES (?,?,?,?,?,?,?)");
		$stmt1->bind_param("ssisssi", $idNum, $streetName, $streetNum, $suburb, $province, $country, $apartmentNum);
		$stmt1->execute();*/
		
		echo json_encode(
			array(
				array("status" => TRUE, "details" => "Successful")
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
