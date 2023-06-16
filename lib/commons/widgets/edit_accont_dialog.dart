import 'package:secrete/core.dart';

import '../../features/dashboard/controller/account_controller.dart';

class UpdateAccountDialog extends ConsumerStatefulWidget {
  final Account account;
  const UpdateAccountDialog({required this.account, Key? key})
      : super(key: key);

  @override
  ConsumerState<UpdateAccountDialog> createState() => _AddAccountDialogState();
}

class _AddAccountDialogState extends ConsumerState<UpdateAccountDialog> {
  late TextEditingController nameController;
  late TextEditingController usernameController;
  late TextEditingController siteController;
  late TextEditingController passwordController;
  var favoritedValue = false;

  void clearFields() {
    nameController.clear();
    usernameController.clear();
    passwordController.clear();
    siteController.clear();
  }

  bool validateInputs(BuildContext ctx) {
    if (nameController.text.isEmpty ||
        usernameController.text.isEmpty ||
        passwordController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    nameController = TextEditingController(text: widget.account.name);
    passwordController = TextEditingController(text: widget.account.password);
    siteController = TextEditingController(text: widget.account.site);
    usernameController = TextEditingController(text: widget.account.username);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final accountControllerProvider =
        ref.watch(databseAccountControllerProvider);
    final size = MediaQuery.of(context).size;
    final ctx = Theme.of(context);

    return Dialog(
      backgroundColor: ctx.primaryColor,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: size.width - 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: ctx.primaryColor,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Chip(
                  avatar: Icon(
                    Icons.add,
                    color: ctx.iconTheme.color,
                  ),
                  label: Text(
                    "Edit ${widget.account.name}",
                    style: ctx.textTheme.bodyMedium,
                  )),
              hsizer(10),
              InputField(
                hint: 'Account Name',
                controller: nameController,
                style: ctx.textTheme.bodySmall!,
                textChanged: (_) {},
              ).addVPadding(10),
              InputField(
                      hint: 'Username',
                      style: ctx.textTheme.bodySmall!,
                      textChanged: (_) {},
                      controller: usernameController)
                  .addVPadding(5),
              InputField(
                      hint: 'SIte Link - Optional',
                      style: ctx.textTheme.bodySmall!,
                      textChanged: (_) {},
                      controller: siteController)
                  .addVPadding(5),
              InputField(
                      hint: 'Password',
                      style: ctx.textTheme.bodySmall!,
                      textChanged: (_) {},
                      controller: passwordController)
                  .addVPadding(5),
              hsizer(20),
              CheckboxListTile(
                checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                value: favoritedValue,
                selected: favoritedValue,
                onChanged: (v) {
                  setState(() {
                    favoritedValue = v!;
                  });
                },
                title: Text(
                  'Make Favorite',
                  style: ctx.textTheme.bodySmall,
                ),
                activeColor: Colors.orange,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  dialogButton(ctx, "Reset", Icons.cancel, () {
                    Navigator.pop(context);
                    clearFields();
                  }),
                  dialogButton(ctx, "Update Account", Icons.add, () {
                    final Account acc = Account(
                        isFavorite: widget.account.isFavorite,
                        isImported: widget.account.isImported)
                      ..id = widget.account.id
                      ..name = nameController.text
                      ..password = passwordController.text
                      ..username = usernameController.text
                      ..site = siteController.text
                      ..dateAdded = widget.account.dateAdded;
                    accountControllerProvider.editAccount(context, acc);
                    
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

TextButton dialogButton(
    ThemeData ctx, String lable, IconData icon, Function callBack) {
  return TextButton.icon(
      style: ctx.textButtonTheme.style,
      onPressed: () => callBack(),
      icon: Icon(icon),
      label: Text(
        lable,
        style: ctx.textTheme.bodySmall,
      ));
}
