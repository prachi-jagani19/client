import 'package:client/auth/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'color_utils.dart';
import 'font_style_utils.dart';

class CompanyListScreen extends StatefulWidget {
  const CompanyListScreen({Key? key}) : super(key: key);

  @override
  State<CompanyListScreen> createState() => _CompanyListScreenState();
}

class _CompanyListScreenState extends State<CompanyListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset("assets/images/background.png"),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/logo.png',
                            color: ColorUtils.white,
                            height: 9.w,
                            width: 12.w,
                          ),
                          Text(
                            "Projecture",
                            style: FontTextStyle.Proxima16Medium.copyWith(
                                color: ColorUtils.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeightClass.extraB),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 45.w),
                      child: Container(
                        height: 20.w,
                        width: Get.width,
                        decoration: const BoxDecoration(
                            color: ColorUtils.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(90.0))),
                        child: Center(
                          child: Text(
                            "Choose Company",
                            style: FontTextStyle.Proxima16Medium.copyWith(
                                fontSize: 18.sp,
                                color: ColorUtils.primaryColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                                              LoginScreen(id: data['uid']));
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
                                                          color: ColorUtils
                                                              .white)),
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
      ),
    );
  }
}
