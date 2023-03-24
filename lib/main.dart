import 'package:client/change_theme/model_theme.dart';
import 'package:client/company_list_screen.dart';
import 'package:client/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

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
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                  child: child!,
                );
              },
              title: 'Projecture',
              theme: themeNotifier.isDark
                  ? ThemeData(brightness: Brightness.dark)
                  : ThemeData(brightness: Brightness.light),
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
              // home: CompanyListScreen(),
            );
          },
        );
      }),
    );
  }
}
