import 'package:client/onBoarding_screen.dart';
import 'package:client/utils/color_utils.dart';
import 'package:client/utils/font_style_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
              Padding(
                padding: EdgeInsets.only(left: 7.w, right: 7.w),
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Company List')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            padding: EdgeInsets.only(top: 1.h),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, i) {
                              var data = snapshot.data!.docs[i];
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 2.w, horizontal: 3.w),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(() =>
                                            OnBoardingScreen(id: data['uid']));
                                      },
                                      child: Container(
                                          height: 5.h,
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: ColorUtils.greyBB
                                                      .withOpacity(0.1),
                                                  spreadRadius: 2,
                                                  blurRadius: 3,
                                                  offset: const Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: ColorUtils.primaryColor),
                                          child: Center(
                                            child: Text(data['Company Name'],
                                                style: FontTextStyle
                                                        .Proxima16Medium
                                                    .copyWith(
                                                        color:
                                                            ColorUtils.white)),
                                          )),
                                    ),
                                  ),
                                ],
                              );
                            });
                      } else {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: ColorUtils.primaryColor,
                        ));
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
