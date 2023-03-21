import 'package:client/bottom_screen.dart';
import 'package:client/change_theme/model_theme.dart';
import 'package:client/company_list_screen.dart';
import 'package:client/onBoarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'auth/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ModelTheme(),
      child: Consumer<ModelTheme>(
          builder: (context, ModelTheme themeNotifier, child) {
        return Sizer(
          builder: (BuildContext context, Orientation orientation,
              DeviceType deviceType) {
            return GetMaterialApp(
              title: 'Projecture',
              theme: themeNotifier.isDark
                  ? ThemeData(brightness: Brightness.dark)
                  : ThemeData(brightness: Brightness.light),
              debugShowCheckedModeBanner: false,
              home: CompanyListScreen(),
              // home: CompanyListScreen(),
            );
          },
        );
      }),
    );
  }
}
