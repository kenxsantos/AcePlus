String? validateMobileNumber(String mobileNumber) {
  final mobileNumberRegex = RegExp(r'^\d{11}$');
  if (!mobileNumberRegex.hasMatch(mobileNumber)) {
    return 'Phone Number must be 11 digits';
  }
  return null;
}

String? validatePassword(String password) {
  final passwordRegex = RegExp(r'^.{6,}$');
  if (!passwordRegex.hasMatch(password)) {
    return 'Password must be at least 6 characters';
  }
  return null;
}