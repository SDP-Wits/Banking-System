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
$secretKey = $_REQUEST["secretKey"];
$currentDate = $_REQUEST["currentDate"];

/*$firstName = "Karen";
$middleName = "The";
$lastName = "Second";
$age = "28";
$phoneNum = "0001112234";
$email = "talk2themanager2@karenz.com";
$idNum = "1234567890982";
$password = "managerz1";
$secretKey = "Testing1234";
$currentDate = "2018-06-13";*/

$streetName = $_REQUEST["streetName"];
$streetNum = $_REQUEST["streetNum"];
$suburb = $_REQUEST["suburb"];
$province = $_REQUEST["province"];
$country = $_REQUEST["country"];
$apartmentNum = $_REQUEST["apartmentNum"];

/*$streetName = "Texas";
$streetNum = "23";
$suburb = "Philli";
$province = "Status";
$country = "usa";
$apartmentNum = "21";*/

//encrypting data
$secretKey = openssl_encrypt($secretKey, $ciphering, $encryption_key, $options, $encryption_iv);
$idNum  = openssl_encrypt($idNum, $ciphering, $encryption_key, $options, $encryption_iv);
$email = openssl_encrypt($email, $ciphering, $encryption_key, $options, $encryption_iv);
$phoneNum = openssl_encrypt($phoneNum, $ciphering, $encryption_key, $options, $encryption_iv);

$sql1 = "SELECT COUNT(*) AS RESULT FROM ADMIN WHERE idNumber = '$idNum'";
$sql2 = "SELECT COUNT(*) AS RESULT FROM `SECRET KEY` WHERE secretKey = '$secretKey'";

$check1 = mysqli_query($conn, $sql1);
$check2 = mysqli_query($conn, $sql2);
if($check1 and $check2) {
	$check_admin = mysqli_fetch_array($check1);
	$check_secret_key = mysqli_fetch_array($check2);
    if($check_admin['RESULT'] != '0'){
		echo json_encode(
			array(
				array("status" => FALSE, "error" => "User with ID number already exists")
			)
		);
    } elseif ($check_secret_key['RESULT'] == '0') {
		echo json_encode(
			array(
				array("status" => FALSE, "error" => "Invalid Secret Key")
			)
		);
	} else	{
		$stmt = $conn->prepare("INSERT INTO ADMIN (email,phoneNumber,idNumber,password,age,firstName,middleName,lastName) VALUES (?,?,?,?,?,?,?,?)");
		$stmt->bind_param("ssssisss", $email, $phoneNum, $idNum, $password, $age, $firstName, $middleName, $lastName);
		$stmt->execute();
		
		$stmt1 = $conn->prepare("INSERT INTO ADDRESS (idNumber, streetName, streetNumber, suburb, province, country, apartmentNumber) VALUES (?,?,?,?,?,?,?)");
		$stmt1->bind_param("ssisssi", $idNum, $streetName, $streetNum, $suburb, $province, $country, $apartmentNum);
		$stmt1->execute();
		
		$sql3 = "SELECT adminID AS RESULT FROM ADMIN ORDER BY adminID DESC LIMIT 1";
		$idCheck = mysqli_query($conn, $sql3);
		$idResult = mysqli_fetch_array($idCheck);
                
        $stmt2 = $conn->prepare("INSERT INTO `VERIFIED ADMIN` (adminID,verifiedDate,secretKeyUsed) VALUES (?,?,?)");
		$stmt2->bind_param("iss",$idResult['RESULT'], $currentDate, $secretKey);
		$stmt2->execute();
		
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
