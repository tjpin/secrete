// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: unused_field

import 'package:secrete/core.dart';
import '../../../security/questions.dart';
import '../controllers/auth_controller.dart';

class PinResetScreen extends ConsumerStatefulWidget {
  static const routeName = "pinresetScreen/";
  const PinResetScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PinResetScreenState();
}

class _PinResetScreenState extends ConsumerState<PinResetScreen> {
  final TextEditingController _q1Controller = TextEditingController();
  final TextEditingController _q2Controller = TextEditingController();
  final TextEditingController _q3Controller = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  bool validated = false;
  static const uid = Uuid();

  List<DropdownMenuItem<String>>? items;
  String initialQuestion1 = securityQuestions.keys.first;
  String initialQuestion2 = securityQuestions.keys.toList()[1];
  String initialQuestion3 = securityQuestions.keys.last;

  void clearFields() {
    _q1Controller.clear();
    _q2Controller.clear();
    _q3Controller.clear();
    _pinController.clear();
  }

  @override
  void dispose() {
    _q1Controller.dispose();
    _q2Controller.dispose();
    _q3Controller.dispose();
    _pinController.dispose();
    super.dispose();
  }

  bool validateFields() {
    return _q1Controller.text.isNotEmpty ||
        _q2Controller.text.isNotEmpty ||
        _q3Controller.text.isNotEmpty;
  }

  bool validateQuestions(User user) {
    /// List of user saved questions and answers.
    final qsMap = user.questions!;

    /// List of user saved questions.
    final qs = user.questions!.keys.toList();

    if (validateFields()) {
      if (qs.contains(initialQuestion1.trim()) &&
          qsMap[initialQuestion1]!.trim() == _q1Controller.text.trim() &&
          qs.contains(initialQuestion2.trim()) &&
          qsMap[initialQuestion2]!.trim() == _q2Controller.text.trim() &&
          qs.contains(initialQuestion3.trim()) &&
          qsMap[initialQuestion3]!.trim() == _q3Controller.text.trim()) {
        setState(() {
          validated = true;
        });
        return true;
      }
      errorToast("Invalid questions and answers");
      return false;
    }
    errorToast("All questions must be answed");
    return false;
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
    final user = ModalRoute.of(context)!.settings.arguments as User;
    final auth = ref.watch(authControllerProvider);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Answer 3 questions to continue",
            style: ctx.textTheme.bodyMedium!.copyWith(color: Colors.teal),
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(LoginScreen.routeName),
            icon: Icon(
              Icons.arrow_back_ios,
              color: ctx.textTheme.bodySmall!.color,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButton(
                  value: initialQuestion1,
                  items: items,
                  onChanged: (question) {
                    setState(() {
                      initialQuestion1 = question!;
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
                    label: "Clear",
                    callBack: () => clearFields(),
                    color: ctx.colorScheme.error,
                  ),
                  hsizer(10),
                  SplashButton(
                      ctx: ctx,
                      label: "Validate",
                      callBack: () => validateQuestions(user),
                      color: Colors.green)
                ],
              ),
              hsizer(20),
              Visibility(
                visible: validated,
                replacement: const Text(''),
                child: Column(
                  children: [
                    InputField(
                      style: ctx.textTheme.bodyMedium!,
                      controller: _pinController,
                      textChanged: (_) {},
                      hint: 'New Pin',
                    ),
                    hsizer(10),
                    Row(
                      children: [
                        const Spacer(),
                        SplashButton(
                            ctx: ctx,
                            label: 'Set new Pincode',
                            color: Colors.teal,
                            callBack: () {
                              if (_pinController.text.isEmpty) {
                                errorToast("Pincode cannot be null");
                                return;
                              }
                              {
                                User updateduser = User(
                                    id: user.id, pincode: _pinController.text)
                                  ..questions = user.questions
                                  ..username = user.username;
                                auth.updateUser(updateduser);
                                clearFields();
                                successToast("Pincode changed successifuly");
                                Navigator.of(context).pushNamed(
                                    LoginScreen.routeName,
                                    arguments: _pinController.text);
                              }
                            }),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ).addAllPadding(20));
  }
}
