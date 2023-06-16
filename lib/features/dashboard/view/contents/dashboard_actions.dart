import 'package:secrete/core.dart';
import 'package:secrete/features/settings/settings.dart';
import 'package:secrete/features/dashboard/core.dart';

List<Widget> dashboardActions(
    ThemeData ctx, AccountController ctl, BuildContext bcx, int i) {
  return [
    i != 1
        ? IconButton(
            onPressed: () =>
                Navigator.of(bcx).pushNamed(SettingsPage.routeName),
            icon: Icon(Icons.settings, color: ctx.iconTheme.color))
        : IconButton(
            onPressed: () =>
                Navigator.of(bcx).pushNamed(AccountSearchPage.routeName),
            icon: Icon(Icons.search, color: ctx.iconTheme.color)),
    PopupMenuButton(
        itemBuilder: (bcx) => [
              PopupMenuItem(
                value: 0,
                onTap: () => ctl.importAccounts(ctl),
                child: Text(
                  "Import Accounts",
                  style: ctx.textTheme.bodySmall,
                ),
              ),
              PopupMenuItem(
                height: 10,
                value: 1,
                child: Divider(
                  color: ctx.iconTheme.color,
                ),
              ),
              PopupMenuItem(
                value: 2,
                onTap: () => Future.delayed(
                    Duration.zero,
                    () => confirmDelete(
                        bcx, () => ctl.dbProvider.deleteAllAccount())),
                child:
                    Text("Delete all Accounts", style: ctx.textTheme.bodySmall),
              ),
              PopupMenuItem(
                value: 3,
                onTap: () => Future.delayed(
                    Duration.zero,
                    () => confirmDelete(
                        bcx, () => ctl.dbProvider.deleteAddedAccounts())),
                child: Text("Delete added Accounts",
                    style: ctx.textTheme.bodySmall),
              ),
              PopupMenuItem(
                value: 4,
                onTap: () => Future.delayed(
                    Duration.zero,
                    () => confirmDelete(
                        bcx, () => ctl.dbProvider.deleteImportedAccounts())),
                child: Text("Delete Imported Accounts",
                    style: ctx.textTheme.bodySmall),
              ),
            ])
  ];
}
