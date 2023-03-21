import 'package:client/onBoarding_screen.dart';
import 'package:client/utils/color_utils.dart';
import 'package:client/utils/font_style_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class CompanyListScreen extends StatefulWidget {
  const CompanyListScreen({Key? key}) : super(key: key);

  @override
  State<CompanyListScreen> createState() => _CompanyListScreenState();
}

class _CompanyListScreenState extends State<CompanyListScreen> {
  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black26,
        systemNavigationBarContrastEnforced: false,
        systemStatusBarContrastEnforced: false,
        systemNavigationBarDividerColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: [SystemUiOverlay.bottom]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 6.h),
          child: Column(
            children: [
              Text("Choose Company",
                  style: FontTextStyle.Proxima16Medium.copyWith(
                      fontSize: 15.sp,
                      fontWeight: FontWeightClass.extraB,
                      color: ColorUtils.primaryColor)),
              Lottie.asset("assets/lottie/chooseCompany.json", height: 25.h),
              SizedBox(
                height: 60.h,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 1.h),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => OnBoardingScreen());
                        },
                        child: Container(
                          height: 6.h,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(13.0)),
                              color: ColorUtils.primaryColor,
                              boxShadow: [
                                BoxShadow(
                                    color: ColorUtils.greyCE,
                                    blurRadius: 9.0,
                                    spreadRadius: 0.5),
                              ]),
                          child: Center(
                            child: Text(
                              "Company name",
                              style: FontTextStyle.Proxima16Medium.copyWith(
                                  color: ColorUtils.white),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
