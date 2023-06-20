// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:secrete/constants/widgets/bottomnav.dart';
import 'package:secrete/constants/widgets/side_drawer.dart';
import 'package:secrete/core.dart';
import 'package:secrete/features/dashboard/core.dart';
import 'package:secrete/features/dashboard/view/pages/more/widgets/wifi_dialog.dart';
import 'contents/dashboard_actions.dart';
import 'contents/pages.dart';
import 'pages/more/widgets/id_cards_dialog.dart';

class Dashboard extends ConsumerStatefulWidget {
  static const routeName = "dashboard/";

  const Dashboard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard>
    with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  PageController? _pageController;

  int _selectedTab = 0;

  void setIndex(int i) {
    setState(() {
      _selectedTab = i;
    });
    _pageController!.animateToPage(i,
        duration: const Duration(microseconds: 200), curve: Curves.easeInOut);
  }

  String setTitle() {
    switch (_selectedTab) {
      case 1:
        return "Accounts";
      case 2:
        return "Cards";
      case 3:
        return "More Details";
      default:
        return "Dashboard";
    }
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: _selectedTab);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  dispose() {
    _pageController!.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// To be implemeted later.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      //
      case AppLifecycleState.detached:
      //

      case AppLifecycleState.inactive:
      //
      case AppLifecycleState.resumed:
      // Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ctx = Theme.of(context);
    final ctl = ref.watch(databseAccountControllerProvider);
    bool savedTheme = ref.watch(databaseProvider).currentThemeLight();
    return Scaffold(
      key: _key,
      appBar: _selectedTab == 3
          ? infoAppbar(ctx, () => _key.currentState!.openDrawer(), [
              () => showDialog(
                  context: context,
                  builder: (_) {
                    return const WifiDialog(
                      isForUpdate: false,
                    );
                  }),
              () => confirmDelete(
                  context, () => DatabaseHelper().deleteAllWifi()),
              () => showDialog(
                  context: context, builder: (_) => const IdCardsDialog()),
              () => confirmDelete(
                  context, () => DatabaseHelper().deleteAllIndentification()),
            ])
          : AppBar(
              title: Text(
                setTitle(),
                style: ctx.appBarTheme.titleTextStyle!
                    .copyWith(color: Colors.white70),
              ),
              automaticallyImplyLeading: false,
              leading: IconButton(
                  onPressed: () => _key.currentState!.openDrawer(),
                  icon: Icon(Icons.menu, color: ctx.iconTheme.color)),
              actions: dashboardActions(ctx, ctl, context, _selectedTab)),
      drawer: SideDrawer(savedTheme: savedTheme),
      bottomNavigationBar: BottomNav(
          ctx: ctx, selectedTab: _selectedTab, setIndex: (i) => setIndex(i)),
      body: PageView(
        controller: _pageController,
        onPageChanged: (i) => setState(() {
          _selectedTab = i;
        }),
        children: pages,
      ).addAllPadding(10),
    );
  }
}

AppBar infoAppbar(
    ThemeData ctx, VoidCallback onPressed, List<Function> itemCallbacks) {
  return AppBar(
    title: const Text("Other Accounts"),
    automaticallyImplyLeading: false,
    leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: ctx.iconTheme.color!,
        ),
        onPressed: onPressed),
    actions: [
      PopupMenuButton(
          itemBuilder: (_) => <PopupMenuEntry>[
                PopupMenuItem(
                    value: 0,
                    onTap: () =>
                        Future.delayed(Duration.zero, () => itemCallbacks[0]()),
                    child: Text(
                      "Add Wi-Fi",
                      style: ctx.textTheme.bodySmall,
                    )),
                PopupMenuItem(
                    value: 1,
                    onTap: () =>
                        Future.delayed(Duration.zero, () => itemCallbacks[1]()),
                    child: Text(
                      "Delete All Wi-Fi",
                      style: ctx.textTheme.bodySmall,
                    )),
                PopupMenuItem(
                    value: 2,
                    onTap: () =>
                        Future.delayed(Duration.zero, () => itemCallbacks[2]()),
                    child: Text(
                      "Add Identity card",
                      style: ctx.textTheme.bodySmall,
                    )),
                PopupMenuItem(
                    value: 3,
                    onTap: () =>
                        Future.delayed(Duration.zero, () => itemCallbacks[3]()),
                    child: Text(
                      "Delete all Identity Cards",
                      style: ctx.textTheme.bodySmall,
                    )),
              ])
    ],
  );
}
