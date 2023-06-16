// ignore_for_file: prefer_final_fields

import 'package:secrete/commons/widgets/label.dart';
import 'package:secrete/core.dart';
import 'package:secrete/features/auth/controllers/auth_controller.dart';
import 'package:secrete/security/questions.dart';

class SettingsPage extends ConsumerStatefulWidget {
  static const routeName = "settingsPage/";
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  TextEditingController _usernameController = TextEditingController();
  final _oldPincodeController = TextEditingController();
  final _newPincodeController = TextEditingController();
  final _q1Controller = TextEditingController();
  final _q2Controller = TextEditingController();
  final _q3Controller = TextEditingController();

  List<DropdownMenuItem<String>>? items;
  String initialQuestion = securityQuestions.keys.first;
  String initialQuestion2 = securityQuestions.keys.toList()[1];
  String initialQuestion3 = securityQuestions.keys.last;

  void clearFields() {
    _q1Controller.clear();
    _q2Controller.clear();
    _q3Controller.clear();
  }

  @override
  void didChangeDependencies() {
    items = securityQuestions.entries
        .map((e) => DropdownMenuItem<String>(
              value: e.key,
              child: Text(
                e.key,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ))
        .toList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ctx = Theme.of(context);
    final authController = ref.watch(authControllerProvider);
    setState(() {
      _usernameController.text = authController.getSavedUser().username!;
    });
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: ctx.textTheme.bodySmall!.color!.withOpacity(0.5),
            )),
        title: const Text("Settings"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            label(ctx, 'Update username'),
            hsizer(10),
            Row(
              children: [
                Expanded(
                  child: InputField(
                      textChanged: (_) {},
                      style: ctx.textTheme.bodySmall!,
                      hint: "username",
                      controller: _usernameController),
                ),
                SplashButton(
                  ctx: ctx,
                  color: Colors.green,
                  callBack: () {
                    final user = authController.getSavedUser();
                    if (_usernameController.text.isEmpty) {
                      errorToast('username is required');
                      return;
                    }
                    authController.updateUser(User(
                      id: user.id,
                      username: _usernameController.text,
                      quetions: user.quetions,
                      pincode: user.pincode,
                    ));
                    successToast('username updated successifuly');
                  },
                  label: "Save",
                )
              ],
            ),
            hsizer(10),
            label(ctx, 'Update pincode'),
            hsizer(10),
            InputField(
                textChanged: (_) {},
                style: ctx.textTheme.bodySmall!,
                keyboardType: TextInputType.number,
                hint: 'Enter old pincode',
                controller: _oldPincodeController),
            hsizer(10),
            InputField(
                textChanged: (_) {},
                keyboardType: TextInputType.number,
                style: ctx.textTheme.bodySmall!,
                hint: 'Enter new pincode',
                controller: _newPincodeController),
            hsizer(10),
            Row(
              children: [
                const Spacer(),
                SplashButton(
                    ctx: ctx,
                    label: "Save",
                    color: Colors.green,
                    callBack: () {
                      if (_oldPincodeController.text.isEmpty &&
                          _newPincodeController.text.isEmpty) {
                        errorToast("Both fields are required");
                        return;
                      } else {
                        final user = authController.getSavedUser();
                        if (_oldPincodeController.text.trim() != user.pincode) {
                          errorToast("Old pincode did't match");
                          return;
                        } else {
                          authController.updateUser(User(
                              id: user.id,
                              pincode: _newPincodeController.text.trim(),
                              username: user.username,
                              quetions: user.quetions));
                          successToast('pincode updated successifuly');
                          return;
                        }
                      }
                    })
              ],
            ),
            // hsizer(10),
            Divider(
              height: 10,
              color: ctx.iconTheme.color!.withOpacity(0.3),
            ),
            hsizer(10),
            label(ctx, 'Update Security questions'),
            DropdownButton(
                value: initialQuestion,
                items: items,
                onChanged: (question) {
                  setState(() {
                    initialQuestion = question!;
                  });
                }).addVPadding(5),
            InputField(
              textChanged: (_) {},
              style: ctx.textTheme.bodyMedium!,
              controller: _q1Controller,
              hint: "Answer...",
            ),
            DropdownButton(
                value: initialQuestion2,
                items: items,
                onChanged: (question) {
                  setState(() {
                    initialQuestion2 = question!;
                  });
                }).addVPadding(5),
            InputField(
              textChanged: (_) {},
              style: ctx.textTheme.bodyMedium!,
              controller: _q2Controller,
              hint: "Answer...",
            ),
            DropdownButton(
                value: initialQuestion3,
                items: items,
                onChanged: (question) {
                  setState(() {
                    initialQuestion3 = question!;
                  });
                }).addVPadding(5),
            InputField(
              textChanged: (_) {},
              style: ctx.textTheme.bodyMedium!,
              controller: _q3Controller,
              hint: "Answer...",
            ),
            hsizer(40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SplashButton(
                  ctx: ctx,
                  label: "Cancel",
                  callBack: () => Navigator.pop(context),
                  color: ctx.colorScheme.error,
                ),
                SplashButton(
                    ctx: ctx,
                    label: "Save",
                    callBack: () {
                      if (_q1Controller.text.isNotEmpty &&
                          _q2Controller.text.isNotEmpty &&
                          _q3Controller.text.isNotEmpty) {
                        final user = authController.getSavedUser();
                        authController.updateUser(User(
                            id: user.id,
                            pincode: user.pincode,
                            username: user.username,
                            quetions: {
                              initialQuestion: _q1Controller.text,
                              initialQuestion2: _q2Controller.text,
                              initialQuestion3: _q3Controller.text,
                            }));
                        successToast("Questions saved");
                        Navigator.pop(context);
                      } else {
                        errorToast("You must answer 3 questions");
                      }
                    },
                    color: Colors.green)
              ],
            )
          ],
        ).addAllPadding(10),
      ),
    );
  }
}
