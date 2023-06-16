import 'package:secrete/core.dart';

import '../../features/dashboard/controller/account_controller.dart';

class AddAccountDialog extends ConsumerStatefulWidget {
  final TextEditingController nameController;
  final TextEditingController usernameController;
  final TextEditingController siteController;
  final TextEditingController passwordController;

  const AddAccountDialog(
      {Key? key,
      required this.nameController,
      required this.usernameController,
      required this.siteController,
      required this.passwordController})
      : super(key: key);

  @override
  ConsumerState<AddAccountDialog> createState() => _AddAccountDialogState();
}

class _AddAccountDialogState extends ConsumerState<AddAccountDialog> {
  var favoritedValue = false;

  void clearFields() {
    widget.nameController.clear();
    widget.usernameController.clear();
    widget.passwordController.clear();
    widget.siteController.clear();
  }

  bool validateInputs(BuildContext ctx) {
    if (widget.nameController.text.isEmpty ||
        widget.usernameController.text.isEmpty ||
        widget.passwordController.text.isEmpty) {
      return false;
    }
    return true;
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
                    "Add New Account",
                    style: ctx.textTheme.bodyMedium,
                  )),
              hsizer(10),
              InputField(
                hint: 'Account Name',
                controller: widget.nameController,
                style: ctx.textTheme.bodySmall!,
                textChanged: (_) {},
              ).addVPadding(10),
              InputField(
                      hint: 'Username',
                      style: ctx.textTheme.bodySmall!,
                      textChanged: (_) {},
                      controller: widget.usernameController)
                  .addVPadding(5),
              InputField(
                      hint: 'SIte Link - Optional',
                      style: ctx.textTheme.bodySmall!,
                      textChanged: (_) {},
                      controller: widget.siteController)
                  .addVPadding(5),
              InputField(
                      hint: 'Password',
                      style: ctx.textTheme.bodySmall!,
                      textChanged: (_) {},
                      controller: widget.passwordController)
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
                  dialogButton(ctx, "Cancel", Icons.cancel,
                      () => Navigator.pop(context)),
                  dialogButton(
                      ctx,
                      "Add Account",
                      Icons.add,
                      () => accountControllerProvider.createAccount(
                          context,
                          favoritedValue,
                          widget.nameController,
                          widget.siteController,
                          widget.passwordController,
                          widget.usernameController,
                          () => clearFields())),
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
