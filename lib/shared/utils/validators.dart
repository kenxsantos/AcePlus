String? validateMobileNumber(String mobileNumber) {
  final mobileNumberRegex = RegExp(r'^\d{11}$');
  if (!mobileNumberRegex.hasMatch(mobileNumber)) {
    return 'Not a valid mobile number format. It must be exactly 11 digits.';
  }
  return null;
}

String? validatePassword(String password) {
  final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{8,}$');
  if (!passwordRegex.hasMatch(password)) {
    return 'Password must be at least 8 characters with uppercase, lowercase, number & special char.';
  }
  return null;
}