import 'package:secrete/core.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:secrete/features/dashboard/view/pages/more/id_cards.dart';

import '../info/more.dart';
import 'wifi_page.dart';

class MoreAccountsPage extends ConsumerStatefulWidget {
  const MoreAccountsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MoreAccountsPageState();
}

class _MoreAccountsPageState extends ConsumerState<MoreAccountsPage> {
  int _selectedIndex = 0;

  List<Widget> content = const [
    WifiPage(),
    IdCardsPage(),
    MoreDetailScreen(),
  ];

  void setContentIndex(int i) {
    setState(() {
      _selectedIndex = i;
      setIcon();
    });
  }

  IconData setIcon() {
    switch (_selectedIndex) {
      case 0:
        return Icons.wifi;
      case 1:
        return Icons.badge_outlined;
      case 2:
        return Icons.info;
      default:
        return Icons.wifi;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ctx = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [Expanded(child: content[_selectedIndex])],
      ),
      floatingActionButton: SpeedDial(
        activeLabel: Text(
          'Wifi',
          style: ctx.textTheme.bodySmall,
        ),
        children: [
          SpeedDialChild(
              label: "wifi",
              child: Icon(color: ctx.iconTheme.color!, Icons.wifi),
              onTap: () => setContentIndex(0)),
          SpeedDialChild(
              label: "Id Cards",
              child: Icon(color: ctx.iconTheme.color!, Icons.badge_outlined),
              onTap: () => setContentIndex(1)),
          SpeedDialChild(
              label: "Information",
              child: Icon(color: ctx.iconTheme.color!, Icons.info),
              onTap: () => setContentIndex(2)),
        ],
        child: Icon(setIcon(), color: ctx.iconTheme.color!),
      ),
    );
  }
}
