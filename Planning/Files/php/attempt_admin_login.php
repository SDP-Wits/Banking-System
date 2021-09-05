<?php
include "./helpers/server_details.php";
include "./helpers/encryption.php";

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

//encrypting data
$id = openssl_encrypt($id, $ciphering, $encryption_key, $options, $encryption_iv);

$sql = "SELECT * FROM ADMIN INNER JOIN ADDRESS ON ADDRESS.idNumber = ADMIN.idNumber WHERE ADMIN.idNumber = '$id'";

$result = $conn->query($sql);

$output = array();

while ($row=$result->fetch_assoc()){
        //decrypting the ID
      	$decryptedID = $row["idNumber"];
      	$decryptedID = openssl_decrypt($decryptedID, $ciphering, $decryption_key, $options, $decryption_iv);
      	$row["idNumber"] = $decryptedID;

        //decrypting the email
      	$decryptedEmail = $row["email"];
      	$decryptedEmail = openssl_decrypt($decryptedEmail, $ciphering, $decryption_key, $options, $decryption_iv);
      	$row["email"] = $decryptedEmail;

        //decrypting the phone number
      	$decryptedPhone = $row["phoneNumber"];
      	$decryptedPhone = openssl_decrypt($decryptedPhone, $ciphering, $decryption_key, $options, $decryption_iv);
      	$row["phoneNumber"] = $decryptedPhone;

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