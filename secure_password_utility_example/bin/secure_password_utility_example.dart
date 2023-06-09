import 'package:secure_password_utility/secure_password_utility.dart';

main() {
  // Call these methods separately in your Flutter application
  checkPasswordStrength('#sh0klmNZa',10);
  createPassword(14);
  createProductKey(20);
}

// Validate password strength Syntax: securePasswordUtility.WeakPasswordChecker('yourSamplePassword',lengthOfPasswordString);
// N.B. Ensure the length of the password you want to validate is at least 10-characters long.
//Check the strength of your password. It returns a boolean
Future<bool> checkPasswordStrength(String password, int passwordLength) async {
  var passcodeStrength = false;
  await SecurePasswordGateway().checkWeakPassword(password,passwordLength)
      .then((value) => {
    passcodeStrength = value
  });
  print('Strong password is $passcodeStrength');
  return passcodeStrength;
}

// Generate a strong password Syntax: securePasswordUtility.CreateStrongPassword(lengthOfPasswordString);
// N.B. The password length must be more than 12.
//Create a new password with a certain length
Future<dynamic> createPassword(int passwordLength) async {
  var createdPassword = '';
  await SecurePasswordGateway().generateStrongPassword(passwordLength)
      .then((value) => createdPassword = value);
  print('generated strong password is $createdPassword');
  return createdPassword;
}

// Generate a product key Syntax: SecurePasswordGateway.generateProductKey(25);
// N.B. The password length must be a multiple of 4 or 5 between 16 and 100 e.g. 16 or 25
String createProductKey(int productKeyLength) {
  var res = SecurePasswordGateway().generateProductKey(productKeyLength);
  print('PRODUCT KEY IS::::: $res');
  return res;
}