// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:secrete/constants/widgets/bottomnav.dart';
import 'package:secrete/constants/widgets/side_drawer.dart';
import 'package:secrete/core.dart';
import 'package:secrete/features/dashboard/core.dart';
import 'contents/dashboard_actions.dart';
import 'contents/pages.dart';

class Dashboard extends ConsumerStatefulWidget {
  static const routeName = "dashboard/";

  const Dashboard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
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
    super.initState();
  }

  @override
  dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ctx = Theme.of(context);
    final ctl = ref.watch(databseAccountControllerProvider);
    bool savedTheme = ref.watch(databaseProvider).currentThemeLight();
    return Scaffold(
      key: _key,
      appBar: AppBar(
          title: Text(setTitle(), style: ctx.appBarTheme.titleTextStyle!.copyWith(color: Colors.teal),),
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
