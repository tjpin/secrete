// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:secrete/commons/widgets/label.dart';
import 'package:secrete/core.dart';

/// New user
class NewSignup extends StatelessWidget {
  final TextEditingController controller;
  final TextEditingController nameController;
  const NewSignup({
    Key? key,
    required this.controller,
    required this.nameController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctx = Theme.of(context);
    final _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: (_size.height / 2) - 30,
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(children: [
                TextSpan(text: "Welcome to ", style: ctx.textTheme.bodyLarge),
                TextSpan(
                    text: " Secrete",
                    style: ctx.textTheme.bodyLarge!.copyWith(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
              ]),
            ),
          ),
          label(ctx, 'Set username and pincode to continue'),
          hsizer(20),
          InputField(
            key: const Key('usernameKey'),
            hint: 'username...',
            style: ctx.textTheme.bodyMedium!.copyWith(
                color: ctx.textTheme.bodySmall!.color!.withOpacity(0.5)),
            controller: nameController,
            hasBorder: true,
            textChanged: (_) {},
            maxLength: 10,
          ),
          hsizer(10),
          //   label(ctx, 'Set new pincode'),
          hsizer(10),
          InputField(
            key: const Key('pincodeKey'),
            hint: 'pincode...',
            style: ctx.textTheme.bodyMedium!.copyWith(
                color: ctx.textTheme.bodySmall!.color!.withOpacity(0.5)),
            controller: controller,
            hasBorder: true,
            textChanged: (_) {},
            maxLength: 12,
          ),
          hsizer(10),
          Row(
            children: [
              const Spacer(),
              SplashButton(
                key: const Key('continueBtn'),
                  ctx: ctx,
                  label: 'Continue',
                  color: Colors.teal,
                  callBack: () {
                    if (nameController.text.isEmpty) {
                      errorToast("username is required");
                      return;
                    }
                    if (controller.text.isEmpty || controller.text.length < 4) {
                      errorToast(
                          "Pincode must be more than 4 or more characters");
                      return;
                    } // Replacement
                    Navigator.of(context).pushNamed(
                        SecurityQuestionsScreen.routeName,
                        arguments: {
                          'username': nameController.text,
                          'pincode': controller.text
                        });
                  }),
            ],
          )
        ],
      ),
    ).addAllPadding(20);
  }
}
