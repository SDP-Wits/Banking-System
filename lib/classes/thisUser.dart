

class thisUser {
final int userID;
final String firstName;
final String? middleName;
final String lastName;
final int age;
final String phoneNumber;
final String email;
final String idNumber;
final String address;

thisUser({
  required this.userID,
  required this.firstName,
  this.middleName,
  required this.lastName,
  required this.age,
  required this.phoneNumber,
  required this.email,
  required this.idNumber,
  required this.address,
});
}