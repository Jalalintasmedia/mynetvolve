import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mynetvolve/screens/auth/new_login_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'core/provs_list.dart';
import 'helpers/notification_api.dart';
import '../screens/menu/tabs_screen.dart';
import 'firebase_options.dart';
import 'screens/splash_screen.dart';
import 'providers/auth.dart';
import 'screens/auth/pick_auth_screen.dart';
import 'core/palette.dart';
import 'core/routes.dart' as routes;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'MyNetvolve',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseMessaging.instance.requestPermission();
  await Future.delayed(const Duration(milliseconds: 500));
  await FirebaseMessaging.instance.getToken();

  NotificationApi.init();
  FirebaseMessaging.onMessage.listen((message) {
    print('===== Got a message whilst in the foreground!');
    print('===== Message data: ${message.notification!.title}');
    if(message.notification != null) {
      NotificationApi.showNotification(
        id: message.notification.hashCode,
        title: message.notification!.title,
        body: message.notification!.body,
      );
    }
  });

  HttpOverrides.global = MyHttpOverrides();

  final result = await Connectivity().checkConnectivity();
  if(result == ConnectivityResult.none) {
    return;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // final String tokens;
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: PROVIDERS_LIST,
      child: Consumer<Auth>(
        builder: (ctx, auth, _) {
          // print('REBUILD!');
          // print('IS AUTH: ${auth.isAuth}');
          // print('token: ${auth.token}');
          return MaterialApp(
            title: 'MyNetvolve',
            theme: ThemeData(
              primarySwatch: Palette.kToDark,
              // fontFamily: 'Gotham',
            ),
            debugShowCheckedModeBanner: false,
            home: auth.isAuth
                ? const TabsScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? const SplashScreen()
                            : const PickAuthScreen(),
                  ),
            routes: routes.routesMap,
          );
        },
      ),
    );
  }
}
