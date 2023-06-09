import 'package:client/change_theme/model_theme.dart';
import 'package:client/company_list_screen.dart';
import 'package:client/home_screen.dart';
import 'package:client/screens/chat/chat_screen.dart';
import 'package:client/shimmer_effect.dart';
import 'package:client/utils/color_utils.dart';
import 'package:client/utils/font_style_utils.dart';
import 'package:client/utils/size_config_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BottomScreen extends StatefulWidget {
  const BottomScreen({Key? key}) : super(key: key);

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  var pageAll = [
    const HomeScreen(),
    //todoShimmer(),
    ChatScreen(),
  ];

  var myIndex = 0;
  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarContrastEnforced: false,
        systemStatusBarContrastEnforced: false,
        systemNavigationBarDividerColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: [SystemUiOverlay.bottom]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor:
              themeNotifier.isDark ? Colors.black : ColorUtils.primaryColor,
          title: const Text("Projecture"),
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 2.w),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: Column(
                                  children: [
                                    Text(
                                      'Log out',
                                      style: FontTextStyle.Proxima16Medium
                                          .copyWith(
                                              color: ColorUtils.primaryColor,
                                              fontWeight:
                                                  FontWeightClass.extraB,
                                              fontSize: 13.sp),
                                    ),
                                    SizeConfig.sH1,
                                  ],
                                ),
                                content: Text(
                                    'are you sure you want to log out?',
                                    style:
                                        FontTextStyle.Proxima16Medium.copyWith(
                                            color: ColorUtils.primaryColor)),
                                actions: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => CompanyListScreen());
                                    },
                                    child: Container(
                                      height: 10.w,
                                      width: 25.w,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0)),
                                          color: ColorUtils.primaryColor),
                                      child: const Center(
                                        child: Text(
                                          "Done",
                                          style: TextStyle(
                                              color: ColorUtils.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                      height: 10.w,
                                      width: 25.w,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0)),
                                          color: ColorUtils.primaryColor),
                                      child: const Center(
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                              color: ColorUtils.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      icon: Icon(Icons.logout)),
                  IconButton(
                      onPressed: () {
                        themeNotifier.isDark = !themeNotifier.isDark;
                      },
                      icon: Icon(themeNotifier.isDark
                          ? Icons.nights_stay
                          : Icons.wb_sunny)),
                ],
              ),
            )
          ],
        ),
        body: pageAll[myIndex],
        bottomNavigationBar: Container(
          height: 7.h,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0.9,
                  color: ColorUtils.black.withOpacity(0.2),
                  blurRadius: 5.0)
            ],
            color: themeNotifier.isDark ? Colors.black : Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    myIndex = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 0.5.h,
                      width: 10.w,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: themeNotifier.isDark
                            ? myIndex == 0
                                ? ColorUtils.purple
                                : ColorUtils.white
                            : myIndex == 0
                                ? ColorUtils.purpleColor
                                : ColorUtils.primaryColor,
                      ),
                    ),
                    SizeConfig.sH05,
                    Icon(
                      Icons.home,
                      color: themeNotifier.isDark
                          ? myIndex == 0
                              ? ColorUtils.purple
                              : ColorUtils.white
                          : myIndex == 0
                              ? ColorUtils.purpleColor
                              : ColorUtils.primaryColor,
                    ),
                    Text(
                      "Home",
                      style: FontTextStyle.Proxima14Regular.copyWith(
                        color: themeNotifier.isDark
                            ? myIndex == 0
                                ? ColorUtils.purple
                                : ColorUtils.white
                            : myIndex == 0
                                ? ColorUtils.purpleColor
                                : ColorUtils.primaryColor,
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    myIndex = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 0.5.h,
                      width: 10.w,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: themeNotifier.isDark
                            ? myIndex == 1
                                ? ColorUtils.purple
                                : ColorUtils.white
                            : myIndex == 1
                                ? ColorUtils.purpleColor
                                : ColorUtils.primaryColor,
                      ),
                    ),
                    SizeConfig.sH05,
                    Icon(
                      Icons.chat,
                      color: themeNotifier.isDark
                          ? myIndex == 1
                              ? ColorUtils.purple
                              : ColorUtils.white
                          : myIndex == 1
                              ? ColorUtils.purpleColor
                              : ColorUtils.primaryColor,
                    ),
                    Text(
                      "Chat",
                      style: FontTextStyle.Proxima14Regular.copyWith(
                        color: themeNotifier.isDark
                            ? myIndex == 1
                                ? ColorUtils.purple
                                : ColorUtils.white
                            : myIndex == 1
                                ? ColorUtils.purpleColor
                                : ColorUtils.primaryColor,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
