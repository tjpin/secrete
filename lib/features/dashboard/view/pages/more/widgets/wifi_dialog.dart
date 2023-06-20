import 'package:secrete/core.dart';
import 'package:secrete/models/wifi_account.dart';

/// This widget is responsible for creating and updating wifi.
/// When isForUpdate is true, wifi attribute must be specified and this widget will act as update widget.

class WifiDialog extends ConsumerStatefulWidget {
  final WifiAccount? wifi;
  final bool isForUpdate;
  const WifiDialog({super.key, this.wifi, this.isForUpdate = false});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpdateWifiDialogState();
}

class _UpdateWifiDialogState extends ConsumerState<WifiDialog> {
  final wifiNameController = TextEditingController();
  final wifipasswordController = TextEditingController();
  final wifiAdminUsernameController = TextEditingController();
  final wifiAdminPasswordController = TextEditingController();
  final wifiLocationController = TextEditingController();
  final wifiPinController = TextEditingController();

  void clearFields() {
    wifiNameController.clear();
    wifipasswordController.clear();
    wifiLocationController.clear();
    wifiPinController.clear();
    wifiAdminUsernameController.clear();
    wifiAdminPasswordController.clear();
  }

  @override
  dispose() {
    wifiNameController.dispose();
    wifipasswordController.dispose();
    wifiLocationController.dispose();
    wifiPinController.dispose();
    wifiAdminUsernameController.dispose();
    wifiAdminPasswordController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (widget.isForUpdate == true) {
      wifiNameController.text = widget.wifi!.name;
      wifipasswordController.text = widget.wifi!.password;
      wifiLocationController.text = widget.wifi!.location ?? "";
      wifiAdminUsernameController.text = widget.wifi!.adminUsername ?? "";
      wifiAdminPasswordController.text = widget.wifi!.adminPassword ?? "";
      wifiPinController.text = widget.wifi!.pin ?? "";
    } else {
      //
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ctx = Theme.of(context);
    const uid = Uuid();
    return Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Chip(
                  avatar: Icon(
                    Icons.wifi,
                    color: ctx.iconTheme.color,
                  ),
                  label: Text(
                    widget.isForUpdate ? "Update Wifi" : "Add Wifi",
                    style: ctx.textTheme.bodySmall,
                  )),
              hsizer(10),
              InputField(
                style: ctx.textTheme.bodyMedium!,
                controller: wifiNameController,
                textChanged: (_) {},
                hint: "Wifi Name",
              ),
              hsizer(10),
              InputField(
                style: ctx.textTheme.bodyMedium!,
                controller: wifipasswordController,
                hint: "Password",
                textChanged: (_) {},
              ),
              hsizer(10),
              InputField(
                style: ctx.textTheme.bodyMedium!,
                controller: wifiLocationController,
                hint: "Location - [Optional]",
                textChanged: (_) {},
              ),
              hsizer(10),
              hsizer(10),
              InputField(
                style: ctx.textTheme.bodyMedium!,
                controller: wifiPinController,
                hint: "Pin - [Optional]",
                textChanged: (_) {},
              ),
              hsizer(10),
              InputField(
                style: ctx.textTheme.bodyMedium!,
                controller: wifiAdminUsernameController,
                hint: "Admin username - [Optional]",
                textChanged: (_) {},
              ),
              hsizer(10),
              InputField(
                style: ctx.textTheme.bodyMedium!,
                controller: wifiAdminPasswordController,
                hint: "Admin Password - [Optional]",
                textChanged: (_) {},
              ),
              hsizer(20),
              Row(
                children: [
                  SplashButton(
                      ctx: ctx,
                      label: 'Cancel',
                      color: Colors.red,
                      callBack: () {
                        clearFields();
                        Navigator.pop(context);
                      }),
                  const Spacer(),
                  SplashButton(
                      ctx: ctx,
                      label: widget.isForUpdate ? "Update" : "Save",
                      color: Colors.green,
                      callBack: widget.isForUpdate
                          ? () {
                              WifiAccount wifiAccount = WifiAccount(
                                  id: widget.wifi!.id,
                                  name: wifiNameController.text,
                                  password: wifipasswordController.text)
                                ..location = wifiLocationController.text
                                ..pin = wifiPinController.text
                                ..adminUsername =
                                    wifiAdminUsernameController.text
                                ..adminPassword =
                                    wifiAdminPasswordController.text;
                              DatabaseHelper().updateWifi(wifiAccount);
                              successToast(
                                  "${wifiAccount.name} updated successifully");
                              Navigator.pop(context);
                            }
                          : () {
                              WifiAccount wifiAccount = WifiAccount(
                                  id: uid.v4(),
                                  name: wifiNameController.text,
                                  password: wifipasswordController.text)
                                ..location = wifiLocationController.text
                                ..pin = wifiPinController.text
                                ..adminUsername =
                                    wifiAdminUsernameController.text
                                ..adminPassword =
                                    wifiAdminPasswordController.text;
                              DatabaseHelper().addWifi(wifiAccount);
                              successToast(
                                  "${wifiAccount.name} Added successifully");
                              Navigator.pop(context);
                            })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
