<?php
include "./helpers/server_details.php";
include "./helpers/encryption.php";

$firstName = $_REQUEST["firstName"];
$middleName = $_REQUEST["middleName"];
$lastName = $_REQUEST["lastName"];
$age = $_REQUEST["age"];
$phoneNum = $_REQUEST["phoneNum"];
$email = $_REQUEST["email"];
$idNum = $_REQUEST["idNum"];
$password = $_REQUEST["password"];

$streetName = $_REQUEST["streetName"];
$streetNum = $_REQUEST["streetNum"];
$suburb = $_REQUEST["suburb"];
$province = $_REQUEST["province"];
$country = $_REQUEST["country"];
$apartmentNum = $_REQUEST["apartmentNum"];

/*$firstName = "Sam";
$middleName = "Falcon";
$lastName = "Wilson";
$age = "34";
$phoneNum = "1113335557";
$email = "falcon@avengers.com";
$idNum = "2222233334444";
$password = "Fly@1234";

$streetName = "street";
$streetNum = "12";
$suburb = "sub urb";
$province = "state";
$country = "USA";
$apartmentNum = "";*/

//encrypting data
$idNum  = openssl_encrypt($idNum, $ciphering, $encryption_key, $options, $encryption_iv);
$email = openssl_encrypt($email, $ciphering, $encryption_key, $options, $encryption_iv);
$phoneNum = openssl_encrypt($phoneNum, $ciphering, $encryption_key, $options, $encryption_iv);

$sql1 = "SELECT COUNT(*) AS RESULT FROM CLIENT WHERE idNumber = '$idNum'";

if($check = mysqli_query($conn, $sql1)) {
	$check_count = mysqli_fetch_array($check);
    if($check_count['RESULT'] != '0'){
		echo json_encode(
			array(
				array("status" => FALSE, "details" => "User with ID number already exists")
			)
		);
    } else {
		$stmt = $conn->prepare("INSERT INTO CLIENT (email,phoneNumber,idNumber,password,age,firstName,middleName,lastName) VALUES (?,?,?,?,?,?,?,?)");
		$stmt->bind_param("ssssisss", $email, $phoneNum, $idNum, $password, $age, $firstName, $middleName, $lastName);
		$stmt->execute();
		
		$stmt1 = $conn->prepare("INSERT INTO ADDRESS (idNumber, streetName, streetNumber, suburb, province, country, apartmentNumber) VALUES (?,?,?,?,?,?,?)");
		$stmt1->bind_param("ssisssi", $idNum, $streetName, $streetNum, $suburb, $province, $country, $apartmentNum);
		$stmt1->execute();
		
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
