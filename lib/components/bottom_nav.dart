import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:justap/controllers/navigation.dart';

class BottomNav extends StatelessWidget {
  //const BottomNav({Key? key}) : super(key: key);

  final int activeButtonIndex;
  const BottomNav(this.activeButtonIndex);

  @override
  Widget build(BuildContext context) {
    NavigationController navigation =
        Provider.of<NavigationController>(context, listen: false);

    return BottomNavigationBar(
      currentIndex: activeButtonIndex,
      onTap: (buttonIndex) {
        switch (buttonIndex) {
          case 0:
            navigation.changeScreen('/');
            break;
          case 1:
            navigation.changeScreen('/settings');
            break;
          case 2:
            navigation.changeScreen('/profile');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
