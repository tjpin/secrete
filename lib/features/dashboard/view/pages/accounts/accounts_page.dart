import 'package:secrete/commons/widgets/new_account_dialog.dart';
import 'package:secrete/core.dart';

import 'added_account.dart';
import 'favorite_accounts.dart';
import 'imported_accounts.dart';

class AccountsPage extends ConsumerStatefulWidget {
  const AccountsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AccountsPageState();
}

class _AccountsPageState extends ConsumerState<AccountsPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController siteController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  int _initialTab = 0;
  final List<Widget> tabPages = const [
    AddedAccounts(),
    ImportedAccounts(),
    FavoriteAccounts(),
  ];

  void setTabIndex(int i) {
    _tabController!.animateTo(i,
        duration: const Duration(microseconds: 200), curve: Curves.easeInOut);
    setState(() {
      _initialTab = i;
    });
  }

  Color setColor(ThemeData ctx, int i) {
    switch (_initialTab == i) {
      case true:
        return Colors.cyan;
      default:
        return ctx.iconTheme.color!;
    }
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ctx = Theme.of(context);
    const fbold = FontWeight.bold;
    return Scaffold(
      body: DefaultTabController(
          length: 3,
          initialIndex: _initialTab,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                      onPressed: () => setTabIndex(0),
                      icon: Icon(
                        Icons.add,
                        color: setColor(ctx, 0),
                      ),
                      label: Text(
                        "Accounts",
                        style: ctx.textTheme.bodySmall!.copyWith(
                            color: setColor(ctx, 0),
                            fontWeight:
                                _initialTab == 0 ? fbold : FontWeight.normal),
                      )),
                  TextButton.icon(
                      onPressed: () => setTabIndex(1),
                      icon: Icon(
                        Icons.import_export,
                        color: setColor(ctx, 1),
                      ),
                      label: Text("Imports",
                          style: ctx.textTheme.bodySmall!.copyWith(
                              color: setColor(ctx, 1),
                              fontWeight: _initialTab == 1
                                  ? fbold
                                  : FontWeight.normal))),
                  TextButton.icon(
                      onPressed: () => setTabIndex(2),
                      icon: Icon(Icons.favorite, color: setColor(ctx, 2)),
                      label: Text("Favorite",
                          style: ctx.textTheme.bodySmall!.copyWith(
                              color: setColor(ctx, 2),
                              fontWeight: _initialTab == 2
                                  ? fbold
                                  : FontWeight.normal))),
                ],
              ),
              Expanded(
                child:
                    TabBarView(
                      controller: _tabController, 
                      physics: const NeverScrollableScrollPhysics(),
                      children: tabPages
                    ),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AddAccountDialog(
                    nameController: nameController,
                    passwordController: passwordController,
                    usernameController: usernameController,
                    siteController: siteController,
                  ));
        },
        child: Icon(
          Icons.add,
          color: ctx.textTheme.bodySmall!.color,
        ),
      ),
    );
  }
}
