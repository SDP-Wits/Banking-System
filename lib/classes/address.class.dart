class Address {
  int streetNumber;
  String streetName;
  String suburb;
  String province;
  String country;
  int? apartmentNumber;

  Address(
      {required this.streetNumber,
      required this.streetName,
      required this.suburb,
      required this.province,
      required this.country,
      this.apartmentNumber});
}
