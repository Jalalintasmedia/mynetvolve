import 'package:flutter/material.dart';
import 'package:mynetvolve/helpers/popups.dart';
import 'package:mynetvolve/screens/menu/paket_screen.dart';
import 'package:mynetvolve/screens/splash_screen.dart';
import 'package:mynetvolve/widgets/buttons/gradient_button.dart';
import 'package:mynetvolve/widgets/gradient_widget.dart';
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
      const PaketScreen(),
      const ChatScreen(),
      // const AreaScreen(),
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
                    backgroundColor: Colors.white,
                    unselectedItemColor: Colors.black,
                    selectedItemColor: Colors.blue,
                    currentIndex: _selectedPageIndex,
                    type: BottomNavigationBarType.fixed,
                    iconSize: 24,
                    selectedFontSize: 0,
                    unselectedFontSize: 0,
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
                        icon: 'responsive.png',
                        label: 'Paket',
                      ),
                      navBarItem(
                        icon: 'chat.png',
                        label: 'Chat',
                      ),
                      // navBarItem(
                      //   icon: 'map.png',
                      //   label: 'Area',
                      // ),
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
      icon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: Column(
          children: [
            GradientWidget(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  colors: [
                    Color.fromRGBO(0, 236, 255, 0.5),
                    Colors.cyanAccent,
                    Color.fromRGBO(0, 26, 255, 0.9),
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  stops: [0.3, 0.5, 0.9],
                ).createShader(bounds);
              },
              child: ImageIcon(
                AssetImage('assets/icons/$icon'),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      label: '',
    );
  }
}
