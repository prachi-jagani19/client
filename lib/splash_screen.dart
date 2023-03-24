import 'dart:async';
import 'dart:developer';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:client/bottom_screen.dart';
import 'package:client/company_list_screen.dart';
import 'package:client/onBoarding_screen.dart';
import 'package:client/service/animayted_text.dart';
import 'package:client/service/wavy_text.dart';
import 'package:client/utils/color_utils.dart';
import 'package:client/utils/font_style_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }

  @override
  String? cid;
  String? uid;
  String? leader;
  setData() async {
    final pref = await SharedPreferences.getInstance();
    cid = pref.getString("companyId");
    uid = pref.getString("userId");
    leader = pref.getString("leaderId");
    log("""
    
   userid       ${pref.getString("userId")};
    company id -- ${pref.getString("companyId")};
    """);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
          splash: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/logo.png',
                color: ColorUtils.primaryColor,
                height: 10.w,
                width: 15.w,
              ),
              AnimatedCustomeTextKit(
                animatedTexts: [
                  WavyAnimatedText(" P r o j e c t u r e ",
                      textStyle: FontTextStyle.Proxima16Medium.copyWith(
                          fontWeight: FontWeightClass.extraB,
                          fontSize: 20.sp,
                          color: ColorUtils.primaryColor),
                      speed: const Duration(milliseconds: 210)),
                ],
                isRepeatingAnimation: true,
                repeatForever: true,
              ),
            ],
          ),
          duration: 4000,
          splashTransition: SplashTransition.sizeTransition,
          backgroundColor: ColorUtils.white,
          nextScreen: uid == null ? CompanyListScreen() : BottomScreen(),
        ));
  }
}
