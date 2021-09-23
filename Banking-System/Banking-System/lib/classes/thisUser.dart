// coverage:ignore-start
// class to store a users information - most fields are required to prevent any incomplete data from displayed
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
  final String status;

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
    required this.status,
  });
}
// coverage:ignore-end
