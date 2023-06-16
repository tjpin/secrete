import 'dart:math';

String generateRandomPassword(int length) {
  final random = Random();
  const String chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()_+~`|}{[]:;?><,./-=';

  String password = '';
  for (int i = 0; i < length; i++) {
    final index = random.nextInt(chars.length);
    password += chars[index];
  }
  return password;
}
