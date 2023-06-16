import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int selectedTab;
  final ThemeData ctx;
  final Function setIndex;
  const BottomNav({
    Key? key,
    required this.selectedTab,
    required this.ctx,
    required this.setIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedTab,
      type: BottomNavigationBarType.fixed,
      backgroundColor: ctx.primaryColor,
      elevation: 0,
      selectedItemColor: ctx.colorScheme.secondary,
      selectedFontSize: 15,
      showUnselectedLabels: true,
      unselectedItemColor: ctx.iconTheme.color,
      onTap: (i) => setIndex(i),
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.switch_account_outlined),
            activeIcon: Icon(Icons.switch_account),
            label: 'Accounts'),
        BottomNavigationBarItem(
            icon: Icon(Icons.payments_outlined),
            activeIcon: Icon(Icons.payment_rounded),
            label: 'Cards'),
        BottomNavigationBarItem(
            icon: Icon(Icons.more_vert_outlined),
            activeIcon: Icon(Icons.more_horiz_outlined),
            label: 'More'),
      ],
    );
  }
}
