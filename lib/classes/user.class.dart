// coverage:ignore-start
import 'address.class.dart';

class User {
  late int userID;
  late String firstName;
  late String? middleName;
  late String lastName;
  late int age;
  late String phoneNumber;
  late String email;
  late String idNumber;
  late String hashPassword;
  late Address address;
  late bool isAdmin;

  User(
    int userID,
    String firstName,
    String? middleName,
    String lastName,
    int age,
    String phoneNumber,
    String email,
    String idNumber,
    String hashPassword,
    bool isAdmin,
    int streetNumber,
    String streetName,
    String suburb,
    String province,
    String country,
    int? apartmentNumber,
  ) {
    this.userID = userID;
    this.firstName = firstName;
    this.middleName = middleName;
    this.lastName = lastName;
    this.age = age;
    this.phoneNumber = phoneNumber;
    this.email = email;
    this.idNumber = idNumber;
    this.hashPassword = hashPassword;
    this.isAdmin = isAdmin;

    this.address = Address(
        streetNumber: streetNumber,
        streetName: streetName,
        suburb: suburb,
        province: province,
        country: country);
  }
}

// coverage:ignore-end
