String? validateEmail(String email) {
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  if (!emailRegex.hasMatch(email)) {
    return 'Not a valid email format';
  }
  return null;
}

String? validatePassword(String password) {
  final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$');
  if (!passwordRegex.hasMatch(password)) {
    return 'Password must be at least 8 characters long, include 1 uppercase, 1 lowercase, and 1 number';
  }
  return null;
}