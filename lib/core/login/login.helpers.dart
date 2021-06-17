// coverage:ignore-start
//Check if password filed has errors
bool hasInputErrorsPassword(String password) {
  if (password.length < 8 || password.length > 20) {
    //check if password length is correct
    return true;
  }
  if (password.length >= 8 && password.length <= 20) {
    //check if password contains uppercase, lowercase letters, number, special characters
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return !regExp.hasMatch(password);
  }
  return false;
}

//Check to see if ID Number has errors
bool hasInputErrorID(String idNum) {
  if (idNum.length != 13) {
    //checks if id num is of length 13
    return true;
  }
  bool hasLetters =
      double.tryParse(idNum) != null; //checks if id number contains any letters
  return !hasLetters;
}

/// coverage:ignore-end
