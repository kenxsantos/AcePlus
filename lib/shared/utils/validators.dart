String? validateEmail(String email) {
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  if (!emailRegex.hasMatch(email)) {
    return 'Not a valid email format';
  }
  return null;
}

String? validatePassword(String password) {
  final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{8,}$');
  if (!passwordRegex.hasMatch(password)) {
    return 'Password must be at least 8 characters long, include 1 uppercase, 1 lowercase, 1 number, and 1 special character';
  }
  return null;
}