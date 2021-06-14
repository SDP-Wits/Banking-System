//Takes in a card number and adds spaces to it
String seperateCardNumber(String cardNumber) {
  String ansString = "";

  int length = cardNumber.length;
  for (int i = 0; i < length; i++) {
    if (i % 4 == 0 && i != 0) {
      ansString += " ";
    }
    ansString += cardNumber[i];
  }

  return ansString;
}

//Takes in full name and makes initals for first and middles names
//eg. Arneev Mohan Joker Singh -> A.M.J. Singh
String getNameDisplay(String firstName, String middleNames, String lastName) {
  firstName = firstName.trim();
  middleNames = middleNames.trim();
  lastName = lastName.trim();

  String ansString = firstName[0].toUpperCase() + '.';

  if (middleNames != '') {
    for (String middle in middleNames.split(' ')) {
      ansString += middle[0].toUpperCase() + '.';
    }
  }

  ansString += ' ' + lastName;

  return ansString;
}
