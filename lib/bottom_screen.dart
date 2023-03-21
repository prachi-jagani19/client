import 'package:client/change_theme/model_theme.dart';
import 'package:client/chat_screen.dart';
import 'package:client/home_screen.dart';
import 'package:client/utils/color_utils.dart';
import 'package:client/utils/font_style_utils.dart';
import 'package:client/utils/size_config_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    const ChatScreen(),
  ];

  var myIndex = 0;
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
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor:
              themeNotifier.isDark ? Colors.black26 : ColorUtils.primaryColor,
          title: Text("hftyvbjnm"),
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 2.w),
              child: IconButton(
                  onPressed: () {
                    themeNotifier.isDark = !themeNotifier.isDark;
                  },
                  icon: Icon(themeNotifier.isDark
                      ? Icons.nights_stay
                      : Icons.wb_sunny)),
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
            color: themeNotifier.isDark
                ? Colors.black12.withOpacity(0.2)
                : Colors.white,
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
                child: Container(
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
                                  ? Colors.red
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
                                ? Colors.red
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
                                  ? Colors.red
                                  : ColorUtils.primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    myIndex = 1;
                  });
                },
                child: Container(
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
                                  ? Colors.red
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
                                ? Colors.red
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
                                  ? Colors.red
                                  : ColorUtils.primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
