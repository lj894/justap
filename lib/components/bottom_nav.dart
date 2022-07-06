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
      selectedItemColor: Colors.black,
      onTap: (buttonIndex) {
        switch (buttonIndex) {
          case 0:
            navigation.changeScreen('/');
            break;
          // case 1:
          //   navigation.changeScreen('/reward');
          //   break;
          // case 2:
          //   navigation.changeScreen('/reward_exchange');
          //   break;
          case 1:
            navigation.changeScreen('/profile');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.remember_me, color: Colors.grey),
          activeIcon: Icon(Icons.remember_me, color: Colors.black),
          label: 'Home',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.military_tech, color: Colors.grey),
        //   activeIcon: Icon(Icons.military_tech, color: Colors.black),
        //   label: 'Reward',
        // ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.currency_exchange, color: Colors.grey),
        //   activeIcon: Icon(Icons.currency_exchange, color: Colors.black),
        //   label: 'Exchange',
        // ),
        BottomNavigationBarItem(
          icon: Icon(Icons.face, color: Colors.grey),
          activeIcon: Icon(Icons.face, color: Colors.black),
          label: 'Profile',
        ),
      ],
    );
  }
}
