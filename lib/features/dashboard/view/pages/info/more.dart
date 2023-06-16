import 'package:secrete/core.dart';
import 'package:secrete/features/dashboard/view/pages/info/help.dart';

import 'about.dart';
import 'developer.dart';
import 'privacy.dart';

class MoreDetailScreen extends ConsumerStatefulWidget {
  const MoreDetailScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MoreDetailScreenState();
}

class _MoreDetailScreenState extends ConsumerState<MoreDetailScreen> {
  int _initialTab = 0;

  List<Widget> tabs(ThemeData ctx) => const [
        HelpTab(),
        AboutTab(),
        PrivacyTab(),
        DeveloperTab(),
      ];

  void switchTab(int i) {
    setState(() {
      _initialTab = i;
    });
  }

  TextStyle setStyle(int i, ThemeData ctx) {
    switch (_initialTab == i) {
      case true:
        return ctx.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold, color: Colors.teal);
      default:
        return ctx.textTheme.bodySmall!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ctx = Theme.of(context);
    return DefaultTabController(
        length: 4,
        initialIndex: _initialTab,
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  tabButton('Help', Icons.help, () => switchTab(0), setStyle(0, ctx)),
                  tabButton('About', Icons.info, () => switchTab(1), setStyle(1, ctx)),
                  tabButton(
                      'Privacy', Icons.privacy_tip, () => switchTab(2), setStyle(2, ctx)),
                  tabButton('Developer', Icons.developer_board,
                      () => switchTab(3), setStyle(3, ctx)),
                ],
              ),
            ),
            Expanded(
              child: tabs(ctx)[_initialTab],
            )
          ],
        ));
  }
}

Widget tabButton(
    String label, IconData icon, VoidCallback onTab, TextStyle style) {
  return InkWell(
    onTap: onTab,
    child: MaterialButton(
      onPressed: onTab,
      child: Text(
        label,
        style: style,
      ),
    ),
  );
}
