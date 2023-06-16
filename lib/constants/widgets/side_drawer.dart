// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:secrete/core.dart';
import 'package:secrete/features/dashboard/core.dart';
import 'package:secrete/features/settings/settings.dart';
import 'package:secrete/models/themeset.dart';

import 'password_gen_dialog.dart';

class SideDrawer extends ConsumerWidget {
  final bool savedTheme;
  const SideDrawer({
    super.key,
    required this.savedTheme,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctx = Theme.of(context);
    final ctl = ref.watch(databseAccountControllerProvider);
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hsizer(40),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  'assets/logo/logo.png',
                  fit: BoxFit.contain,
                  height: 60,
                ),
              ),
              wsizer(20),
              Text(
                "Secrete",
                style: ctx.textTheme.bodyLarge!.copyWith(color: Colors.teal, fontWeight: FontWeight.bold),
              )
            ],
          ).addVPadding(20).addHPadding(10),
          Divider(
            color: ctx.iconTheme.color!.withOpacity(0.3),
            height: 8,
          ),
          SwitchListTile(
            value: savedTheme,
            onChanged: (value) {
              final currentTheme =
                  DatabaseHelper.getCurrentTheme().values.first;
              DatabaseHelper.getCurrentTheme().put(
                  currentTheme.id,
                  ThemeSet(
                      id: currentTheme.id,
                      isLightTheme: !currentTheme.isLightTheme));
            },
            activeColor: ctx.colorScheme.error,
            inactiveTrackColor: ctx.iconTheme.color!.withOpacity(0.5),
            title: Text(
              savedTheme ? "Dark Theme" : "Light Theme",
              style: ctx.textTheme.bodySmall,
            ),
          ),
          Divider(
            color: ctx.iconTheme.color!.withOpacity(0.3),
            height: 8,
          ),
          buildDrawerTile(ctx, 'Settings', Icons.settings,
              () => Navigator.of(context).pushNamed(SettingsPage.routeName)),
          buildDrawerTile(ctx, 'Import Accounts', Icons.import_export, () {
            ctl.importAccounts(ctl);
            Navigator.pop(context);
          }),
          buildDrawerTile(
              ctx,
              'Delete all Accounts',
              Icons.delete_forever,
              () => confirmDelete(
                  context, () => ctl.dbProvider.deleteAllAccount())),
          buildDrawerTile(
              ctx,
              'Delete all Cards',
              Icons.delete_sweep,
              () =>
                  confirmDelete(context, () => ctl.dbProvider.deleteAllCard())),
          buildDrawerTile(
              ctx, 'Password Generator', Icons.generating_tokens_rounded, () {
            showDialog(
                context: context,
                builder: (context) => const Dialog(child: PasswordGenerator()));
          }),
          const Spacer(),
          buildDrawerTile(
              ctx,
              'Signout',
              Icons.logout,
              () => Navigator.of(context).pushReplacementNamed(
                  LoginScreen.routeName)), //SystemNavigator.pop()
        ],
      ),
    );
  }
}

Widget buildDrawerTile(
    ThemeData ctx, String label, IconData icon, VoidCallback tapFunction) {
  return ListTile(
    onTap: tapFunction,
    leading: Icon(
      icon,
      color: ctx.iconTheme.color,
    ),
    title: Text(
      label,
      style: ctx.textTheme.bodySmall,
    ),
  );
}
