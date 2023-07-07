import 'package:flutter/material.dart';
import 'package:mynetvolve/core/palette.dart';
import 'package:mynetvolve/helpers/popups.dart';
import 'package:mynetvolve/screens/splash_screen.dart';
import 'package:mynetvolve/widgets/buttons/gradient_button.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../providers/auth.dart';
import '../../providers/customer_profile.dart';
import 'chat_screen.dart';
import 'beranda_screen.dart';
import 'profile_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late final _custProfileFuture =
      Provider.of<CustomerProfile>(context, listen: true).getUserProfile();
  late List<Widget> _pages;
  var _selectedPageIndex = 0;

  void askPermission() {
    Future<PermissionStatus> permissionStatus =
        NotificationPermissions.requestNotificationPermissions();
  }

  @override
  void initState() {
    askPermission();
    _pages = [
      const BerandaScreen(),
      const ChatScreen(),
      const ProfileScreen(),
    ];
    setState(() {});
    super.initState();
  }

  void _selectScreen(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      onFinish: () => showEmailVerificationPopUp(context),
      builder: Builder(
        builder: (_) => FutureBuilder(
          future: _custProfileFuture,
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            } else {
              if (dataSnapshot.error != null) {
                return Scaffold(
                  body: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Terdapat Kesalahan Pada Data Anda'),
                          const Text('Mohon Hubungi Customer Service'),
                          const SizedBox(height: 10),
                          GradientButton(
                            buttonHandle: () =>
                                Provider.of<Auth>(context, listen: false)
                                    .logout(),
                            text: 'Logout',
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Scaffold(
                  // body: _pages[_selectedPageIndex],
                  body: IndexedStack(
                    index: _selectedPageIndex,
                    children: _pages,
                  ),
                  bottomNavigationBar: BottomNavigationBar(
                    onTap: _selectScreen,
                    selectedItemColor: Palette.kToDark,
                    currentIndex: _selectedPageIndex,
                    type: BottomNavigationBarType.fixed,
                    iconSize: 24,
                    selectedFontSize: 10,
                    unselectedFontSize: 10,
                    selectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    items: [
                      navBarItem(
                        icon: 'house.png',
                        label: 'Beranda',
                      ),
                      navBarItem(
                        icon: 'chat.png',
                        label: 'Chat',
                      ),
                      navBarItem(
                        icon: 'user.png',
                        label: 'Profile',
                      ),
                    ],
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }

  BottomNavigationBarItem navBarItem({
    required String icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: ImageIcon(
        AssetImage('assets/icons/$icon'),
      ),
      label: label,
    );
  }
}
