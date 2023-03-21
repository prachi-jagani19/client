import 'package:client/auth/login_screen.dart';
import 'package:client/auth/registration_screen.dart';
import 'package:client/utils/color_utils.dart';
import 'package:client/utils/font_style_utils.dart';
import 'package:client/utils/size_config_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizeConfig.sH8,
            Text(
              "Hello There!",
              style: FontTextStyle.Proxima16Medium.copyWith(
                  color: ColorUtils.primaryColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeightClass.extraB),
            ),
            SizeConfig.sH4,
            Text(
              "Automatic identify verification which enable you to",
              style: FontTextStyle.Proxima12Regular.copyWith(
                  fontSize: 10.sp, color: ColorUtils.grey),
            ),
            Text(
              "verify your identity",
              style: FontTextStyle.Proxima12Regular.copyWith(
                  color: ColorUtils.grey, fontSize: 10.sp),
            ),
            Padding(
              padding: EdgeInsets.only(left: 7.w, right: 7.w, top: 4.h),
              child: Lottie.asset(
                "assets/lottie/onboarding.json",
              ),
            ),
            SizeConfig.sH2,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.w),
              child: InkWell(
                onTap: () {
                  Get.to(() => LoginScreen());
                },
                child: Container(
                  height: 6.h,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: ColorUtils.greyCE,
                            blurRadius: 9.0,
                            spreadRadius: 0.5)
                      ],
                      border: Border.all(color: ColorUtils.primaryColor),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Center(
                    child: Text(
                      "Sign In",
                      style: FontTextStyle.Proxima16Medium.copyWith(
                          color: ColorUtils.primaryColor,
                          fontSize: 13.sp,
                          fontWeight: FontWeightClass.extraB),
                    ),
                  ),
                ),
              ),
            ),
            SizeConfig.sH2,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.w),
              child: InkWell(
                onTap: () {
                  Get.to(() => RegisterScreen());
                },
                child: Container(
                  height: 6.h,
                  decoration: BoxDecoration(
                      color: ColorUtils.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Center(
                    child: Text(
                      "Sign Up",
                      style: FontTextStyle.Proxima16Medium.copyWith(
                          color: ColorUtils.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeightClass.extraB),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
