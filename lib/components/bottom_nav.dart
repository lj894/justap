import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:justap/controllers/navigation.dart';

class BottomNav extends StatefulWidget {
  //const BottomNav({Key? key}) : super(key: key);

  final int activeButtonIndex;
  const BottomNav(this.activeButtonIndex);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    NavigationController navigation =
        Provider.of<NavigationController>(context, listen: false);

    return BottomNavigationBar(
      currentIndex: widget.activeButtonIndex,
      selectedItemColor: Colors.black,
      onTap: (buttonIndex) {
        switch (buttonIndex) {
          case 0:
            navigation.changeScreen('/');
            break;
          case 1:
            navigation.changeScreen('/wallet');
            break;
          case 2:
            navigation.changeScreen('/social');
            break;
          // case 2:
          //   navigation.changeScreen('/reward_exchange');
          //   break;
          case 3:
            navigation.changeScreen('/profile');
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Image.asset("assets/images/REWARD_ICON_INACTIVE.png",
              width: 30, height: 30),
          activeIcon: Image.asset("assets/images/REWARD_ICON_ACTIVE.png",
              width: 30, height: 30),
          label: 'Reward',
        ),
        BottomNavigationBarItem(
          icon: Image.asset("assets/images/WALLET_ICON_INACTIVE.png",
              width: 30, height: 30),
          activeIcon: Image.asset("assets/images/WALLET_ICON_ACTIVE.png",
              width: 30, height: 30),
          label: 'Wallet',
        ),
        BottomNavigationBarItem(
          //icon: Icon(Icons.remember_me, color: Colors.grey),
          icon: Image.asset("assets/images/SOCIAL_ICON_INACTIVE.png",
              width: 30, height: 30),
          activeIcon: Image.asset("assets/images/SOCIAL_ICON_ACTIVE.png",
              width: 30, height: 30),
          //activeIcon: Icon(Icons.remember_me, color: Colors.black),
          label: 'Social',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.currency_exchange, color: Colors.grey),
        //   activeIcon: Icon(Icons.currency_exchange, color: Colors.black),
        //   label: 'Exchange',
        // ),
        BottomNavigationBarItem(
          icon: Image.asset("assets/images/PROFILE_ICON_INACTIVE.png",
              width: 30, height: 30),
          activeIcon: Image.asset("assets/images/PROFILE_ICON_ACTIVE.png",
              width: 30, height: 30),
          label: 'Profile',
        ),
      ],
    );
  }
}
