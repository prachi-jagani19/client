import 'dart:developer';

import 'package:client/splash_screen.dart';
import 'package:client/utils/const/function/local_notification_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'change_theme/model_theme.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("message:::::: $message");
  await Firebase.initializeApp();

  // LocalNotificationServices.display(message);
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LocalNotificationServices.initialize();
  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    print('on refresh token');
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;
    FirebaseFirestore.instance
        .collection('user')
        .doc(currentUser.uid)
        .update({'fcmToken': fcmToken});
    // TODO: If necessary send token to application server.
    // token is generated.
  }).onError((err) {
    // Error getting token.
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  print("token:::::: ${await FirebaseMessaging.instance.getToken()}");
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print(
        "onMessageOpenedApp:onmessage $message ${message.data['phoneNumber']}");

    log("111111111::::: ${message}${message.data}");
    if (message.notification != null) {
      log("111111111::::: ${message.data}");

      LocalNotificationServices.display(message);
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ModelTheme(),
      child: Consumer<ModelTheme>(
          builder: (context, ModelTheme themeNotifier, child) {
            return Sizer(builder: (BuildContext context, Orientation orientation,
                DeviceType deviceType) {
              return GetMaterialApp(
                  title: 'Flutter Admin',
                  debugShowCheckedModeBanner: false,
                  theme: themeNotifier.isDark
                      ? ThemeData(brightness: Brightness.dark)
                      : ThemeData(brightness: Brightness.light),
                  home: const SplashScreen());
            });
          }),
    );
  }
}
