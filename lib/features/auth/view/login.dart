// ignore_for_file: public_member_api_docs, sort_constructors_first, no_leading_underscores_for_local_identifiers
import 'package:secrete/core.dart';
import 'user_views/existing_userview.dart';
import 'user_views/new_userview.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = "login/";
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final nameController = TextEditingController();
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: DatabaseHelper.getUserBox().listenable(),
          builder: (context, box, _) {
            if (box.isEmpty) {
              return NewSignup(
                controller: controller,
                nameController: nameController,
              );
            }
            else {
              final user = box.values.first;
              return ExistingLogin(controller: controller, user: user);
            }
          }),
    );
  }
}




