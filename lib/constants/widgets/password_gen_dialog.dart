import 'package:secrete/core.dart';
import 'package:secrete/utils/helper_functions/password_generator.dart';

class PasswordGenerator extends StatefulWidget {
  const PasswordGenerator({super.key});

  @override
  State<PasswordGenerator> createState() => _PasswordGeneratorState();
}

class _PasswordGeneratorState extends State<PasswordGenerator> {
  final _countController = TextEditingController();
  String generatedPassword = "";

  @override
  void dispose() {
    _countController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ctx = Theme.of(context);
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InputField(
                  keyboardType: TextInputType.number,
                  style: ctx.textTheme.bodyMedium!,
                  hint: "Password Length",
                  textChanged: (_){},
                  controller: _countController)
              .addHPadding(20),
          TextButton.icon(
            icon: const Icon(
              Icons.copy,
              color: Colors.blue,
              size: 20,
            ),
            onPressed: () {
              if (generatedPassword.isNotEmpty) {
                Clipboard.setData(ClipboardData(text: generatedPassword));
                successToast("Password copied to clipboard");
                return;
              }
              return;
            },
            label: Text(
              generatedPassword,
              style: ctx.textTheme.bodySmall,
            ),
          ),
          hsizer(10),
          TextButton.icon(
              onPressed: () {
                if (_countController.text.isEmpty) {
                  errorToast("Length cannot be empty");
                  return;
                } else if (int.parse(_countController.text) > 30) {
                  errorToast("Length should not exceed 30");
                  return;
                }
                setState(() {
                  generatedPassword =
                      generateRandomPassword(int.parse(_countController.text));
                });
              },
              icon: Icon(
                Icons.generating_tokens_rounded,
                color: ctx.iconTheme.color,
              ),
              label: Text(
                "Generate Password",
                style: ctx.textTheme.bodyMedium,
              ))
        ],
      ),
    );
  }
}
