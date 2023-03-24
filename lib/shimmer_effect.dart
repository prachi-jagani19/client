import 'package:client/change_theme/model_theme.dart';
import 'package:client/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class ShimmerEffect extends StatefulWidget {
  const ShimmerEffect({Key? key}) : super(key: key);

  @override
  State<ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<ShimmerEffect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: todoShimmer(),
    );
  }
}

Widget todoShimmer() {
  return Consumer<ModelTheme>(
      builder: (context, ModelTheme themeNotifier, child) {
    return Shimmer.fromColors(
      baseColor: themeNotifier.isDark ? Colors.grey : ColorUtils.primaryColor,
      highlightColor: ColorUtils.white,
      child: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 3.h),
                  height: 39.h,
                  width: 350,
                  decoration: BoxDecoration(
                    color: ColorUtils.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(top: 1.h),
                  height: 39.h,
                  width: 350,
                  decoration: BoxDecoration(
                    color: ColorUtils.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(top: 1.h),
                  height: 39.h,
                  width: 350,
                  decoration: BoxDecoration(
                    color: ColorUtils.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  });
}

Widget projectList() {
  return Consumer<ModelTheme>(
      builder: (context, ModelTheme themeNotifier, child) {
    return Shimmer.fromColors(
      baseColor: themeNotifier.isDark ? Colors.grey : ColorUtils.purple,
      highlightColor: ColorUtils.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 5.w),
              child: Container(
                height: 18.w,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 5.w),
              child: Container(
                height: 18.w,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 5.w),
              child: Container(
                height: 18.w,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 5.w),
              child: Container(
                height: 18.w,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 5.w),
              child: Container(
                height: 18.w,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 5.w),
              child: Container(
                height: 18.w,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 5.w),
              child: Container(
                height: 18.w,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 5.w),
              child: Container(
                height: 18.w,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 5.w),
              child: Container(
                height: 18.w,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
          ],
        ),
      ),
    );
  });
}
