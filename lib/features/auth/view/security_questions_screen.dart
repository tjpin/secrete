// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: unused_field

import 'package:secrete/commons/widgets/label.dart';
import 'package:secrete/core.dart';

import '../../../security/questions.dart';
import '../controllers/auth_controller.dart';

class SecurityQuestionsScreen extends ConsumerStatefulWidget {
  static const routeName = "securityScreen/";
  const SecurityQuestionsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SecurityQuestionsScreenState();
}

class _SecurityQuestionsScreenState
    extends ConsumerState<SecurityQuestionsScreen> {
  final TextEditingController _q1Controller = TextEditingController();
  final TextEditingController _q2Controller = TextEditingController();
  final TextEditingController _q3Controller = TextEditingController();
  static const uid = Uuid();

  List<DropdownMenuItem<String>>? items;
  String initialQuestion = securityQuestions.keys.first;
  String initialQuestion2 = securityQuestions.keys.toList()[1];
  String initialQuestion3 = securityQuestions.keys.last;

  void clearFields() {
    _q1Controller.clear();
    _q2Controller.clear();
    _q3Controller.clear();
  }

  bool validateInputs() {
    return _q1Controller.text.isNotEmpty &&
        _q2Controller.text.isNotEmpty &&
        _q3Controller.text.isNotEmpty;
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
    final routeData =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Set security questions"),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label(ctx, "Username: ${routeData['username'].toString()}"),
              hsizer(10),
              label(ctx, "Passcode: ${routeData['pincode'].toString()}"),
              hsizer(10),
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
                        if (validateInputs()) {
                          User u = User(
                              id: uid.v4(),
                              pincode: routeData['pincode'].toString())
                            ..username = routeData['username'].toString()
                            ..questions = {
                              initialQuestion: _q1Controller.text,
                              initialQuestion2: _q2Controller.text,
                              initialQuestion3: _q3Controller.text
                            };
                          authController.createUser(u);
                          successToast("Registration successiful");
                          Navigator.of(context)
                              .pushReplacementNamed(LoginScreen.routeName);
                        } else {
                          errorToast("You must answer 3 questions");
                        }
                      },
                      color: Colors.green)
                ],
              )
            ],
          ),
        ).addAllPadding(20));
  }
}
