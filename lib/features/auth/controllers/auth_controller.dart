// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:secrete/core.dart';
import 'package:local_auth/local_auth.dart';

final authControllerProvider = Provider((ref) {
  return AuthController();
});

class AuthController {
  final LocalAuthentication auth = LocalAuthentication();

  User getSavedUser() {
    return DatabaseHelper.getUserBox().values.first;
  }

  void createUser(User user) {
    // deleteUser();
    DatabaseHelper.getUserBox().put(user.id, user);
  }

  void updateUser(User user) {
    // deleteUser();
    DatabaseHelper.getUserBox().put(user.id, user);
  }

  void deleteUser() {
    DatabaseHelper.getUserBox().clear();
  }

  Map<String, String> getQuestions() {
    return getSavedUser().questions ?? {};
  }

  void authenticateCode(BuildContext context, String code) async {
    final pincode = getSavedUser().pincode;
    switch (code == pincode) {
      case true:
        Navigator.of(context).pushReplacementNamed(Dashboard.routeName);
        break;
      default:
        errorToast("Wrong pincode, Try again");
        return;
    }
  }

  // Local Authentication

  Future<bool> canAuthenticate() async {
    final bool canAuthenticate =
        await auth.canCheckBiometrics || await auth.isDeviceSupported();
    return canAuthenticate;
  }

  Future<void> authenticate(Function action) async {
    final bool canAuth = await canAuthenticate();
    if (canAuth) {
      try {
        final didAuthenticate = await auth.authenticate(
            localizedReason: "Please Authenticate to access your account");
        if (didAuthenticate) {
          action();
          return;
        }
      } on PlatformException {
        errorToast("Device not supported");
        return;
      }
    }

    errorToast("Access Denied");
  }
}
