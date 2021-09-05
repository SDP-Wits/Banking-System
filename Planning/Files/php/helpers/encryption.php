<?php
//Encryption initial setup 

//encryption data
$ciphering = "AES-128-CTR";
$iv_length = openssl_cipher_iv_length($ciphering);
$options = 0;
$encryption_iv = '1234567891011121';
$encryption_key = "TestEncryptKey";

//How to encrypt
    // $encryption = openssl_encrypt($data, $ciphering, $encryption_key, $options, $encryption_iv);

//decryption data
$decryption_iv = '1234567891011121';
$decryption_key = "TestEncryptKey";

//How to decrypt
    // $decryption=openssl_decrypt ($data, $ciphering, $decryption_key, $options, $decryption_iv);

?>