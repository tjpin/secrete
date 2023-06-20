// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:secrete/core.dart';
import 'package:secrete/features/auth/controllers/auth_controller.dart';
import '../pin_reset.dart';

class ExistingLogin extends ConsumerWidget {
  final TextEditingController controller;
  final User user;
  const ExistingLogin({
    Key? key,
    required this.user,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctx = Theme.of(context);
    final _size = MediaQuery.of(context).size;
    final auth = ref.watch(authControllerProvider);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: (_size.height / 2) - 30,
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(children: [
                TextSpan(text: "Welcome back ", style: ctx.textTheme.bodyLarge),
                TextSpan(
                    text: user.username,
                    style: ctx.textTheme.bodyLarge!.copyWith(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
              ]),
            ),
          ),
          Text('Login',
              style: ctx.textTheme.bodySmall!.copyWith(
                  color: ctx.textTheme.bodySmall!.color!.withOpacity(0.5))),
          hsizer(10),
          InputField(style: ctx.textTheme.bodyMedium!, hint: 'Enter pincode', controller: controller, textChanged: (_) {},),
          hsizer(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () => auth.authenticate(
                  () => Navigator.of(context).pushReplacementNamed(Dashboard.routeName)
                ),
                icon: const Icon(
                  Icons.fingerprint,
                  color: Colors.teal,
                ),
                label: Text("Use Fingerprint", style: ctx.textTheme.bodySmall),
              ),
              TextButton.icon(
                onPressed: () {
                    
                  if (controller.text.isEmpty) {
                    errorToast('Please enter your pincode');
                    return;
                  } auth.authenticateCode(context, controller.text);
                },
                icon: const Icon(
                  Icons.login,
                  color: Colors.teal,
                ),
                label: Text("Login", style: ctx.textTheme.bodySmall),
              ),
            ],
          ),
          Row(children: [
            const Spacer(),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, PinResetScreen.routeName, arguments: user);
                },
                child: Text("Reset Pincode",
                    style:
                        ctx.textTheme.bodySmall!.copyWith(color: Colors.teal)))
          ]).addVPadding(10)
        ],
      ),
    ).addHPadding(20);
  }
}
