import 'package:secrete/commons/widgets/label.dart';
import 'package:secrete/core.dart';
import 'package:secrete/features/dashboard/core.dart';
import 'package:secrete/features/dashboard/view/pages/more/widgets/wifi_dialog.dart';
import 'package:secrete/models/wifi_account.dart';


class WifiPage extends StatefulWidget {
  const WifiPage({super.key});

  @override
  State<WifiPage> createState() => _WifiPageState();
}

class _WifiPageState extends State<WifiPage> {
  @override
  Widget build(BuildContext context) {
    final ctx = Theme.of(context);
    return ValueListenableBuilder<Box<WifiAccount>>(
        valueListenable: DatabaseHelper.getCurrentWifiBox().listenable(),
        builder: (context, box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text("Add wifi accounts"),
            );
          } else {
            List<WifiAccount> wifiList = box.values.toList();
            return ListView.builder(
                itemCount: wifiList.length,
                itemBuilder: (context, i) {
                  WifiAccount wifi = wifiList[i];
                  return Slidable(
                      startActionPane: ActionPane(
                          openThreshold: 0.2,
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (_) => showDialog(
                                  context: context,
                                  builder: (_) => WifiDialog(
                                        wifi: wifi,
                                        isForUpdate: true,
                                      )),
                              icon: Icons.edit,
                              backgroundColor: ctx.primaryColor,
                              foregroundColor: ctx.iconTheme.color,
                            ),
                            SlidableAction(
                              onPressed: (_) {
                                DatabaseHelper().deleteWifi(wifi);
                                successToast(
                                    "${wifi.name} Deleted Successifuly");
                              },
                              icon: Icons.delete,
                              backgroundColor: ctx.primaryColor,
                              foregroundColor: Colors.red,
                            ),
                          ]),
                      key: UniqueKey(),
                      child: ListTile(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (_) {
                                return SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        buildActionRow(wifi, ctx),
                                        hsizer(10),
                                        label(ctx, 'SSID'),
                                        wifiCardItem(ctx, wifi.name, () {}),
                                        label(ctx, 'password'),
                                        wifiCardItem(ctx, wifi.password, () {}),
                                        label(ctx, 'location'),
                                        wifiCardItem(
                                            ctx, wifi.location ?? "", () {}),
                                        label(ctx, 'pin'),
                                        wifiCardItem(
                                            ctx, wifi.pin ?? "", () {}),
                                        label(ctx, 'admin login username'),
                                        wifiCardItem(ctx,
                                            wifi.adminUsername ?? "", () {}),
                                        label(ctx, 'admin login password'),
                                        wifiCardItem(ctx,
                                            wifi.adminUsername ?? "", () {}),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        leading: Icon(
                          Icons.wifi,
                          color: ctx.iconTheme.color,
                        ),
                        title: Text(
                          wifi.name,
                          style: ctx.textTheme.bodyMedium,
                        ),
                      ));
                });
          }
        });
  }
}

Widget wifiCardItem(ThemeData ctx, String text, VoidCallback callBack) {
  return TextField(
    controller: TextEditingController(text: text),
    readOnly: true,
    decoration: InputDecoration(
        constraints: const BoxConstraints(maxHeight: 30),
        suffix: IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: text));
              successToast("$text copied to clipboard");
            },
            icon: Icon(
              Icons.copy,
              color: ctx.iconTheme.color,
              size: 16,
            ))),
  ).addVPadding(5);
}

Widget buildActionRow(WifiAccount wifi, ThemeData ctx) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Chip(
          avatar: Icon(
            Icons.wifi,
            color: ctx.iconTheme.color,
          ),
          label: Text(
            wifi.name,
            style: ctx.textTheme.bodySmall,
          )),
      //   TextButton.icon(
      //       icon: const Icon(
      //         Icons.wifi_off,
      //         color: Colors.green,
      //       ),
      //       onPressed: () => connectToWifi(wifi),
      //       label: Text(
      //         "Connect",
      //         style: ctx.textTheme.bodySmall!.copyWith(color: Colors.green),
      //       )),
    ],
  );
}
