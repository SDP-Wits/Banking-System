import 'dart:convert'; // for the utf8.encode method

import 'package:crypto/crypto.dart';

String encode(String word){

  var bytes = utf8.encode(word); // data being hashed

  var digest = sha256.convert(bytes);

  //print("Digest as bytes: ${digest.bytes}");
  //print("Digest as hex string: $digest");
  return digest.toString();
}