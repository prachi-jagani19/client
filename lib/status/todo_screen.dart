import 'dart:developer';

import 'package:client/shimmer_effect.dart';
import 'package:client/utils/color_utils.dart';
import 'package:client/utils/font_style_utils.dart';
import 'package:client/utils/size_config_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class TodoScreen extends StatefulWidget {
  var Project;
  TodoScreen({this.Project});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  String? cid;
  String? uid;

  setData() async {
    final pref = await SharedPreferences.getInstance();
    cid = pref.getString("companyId");
    uid = pref.getString("userId");

    log("""
    
   userid       ${pref.getString("userId")};
    company id -- ${pref.getString("companyId")};
    """);
    setState(() {});
  }

  bool isShimmer = true;
  Future durationShimmer() async {
    await Future.delayed(const Duration(milliseconds: 500));
    isShimmer = false;
    setState(() {});
  }

  @override
  void initState() {
    setData();
    super.initState();
    durationShimmer();
  }

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    String Project = widget.Project;
    return Scaffold(
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: cid != null
              ? isShimmer == true
                  ? todoShimmer()
                  : StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection(cid!)
                          .doc(cid)
                          .collection(Project)
                          .doc(Project)
                          .collection('task')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              padding: EdgeInsets.only(top: 2.h),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                var data = snapshot.data!.docs[index];
                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 2.w, horizontal: 4.w),
                                      child: Container(
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                ColorUtils.primaryColor,
                                                ColorUtils.purple,
                                                ColorUtils.purple
                                                    .withOpacity(0.8),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color:
                                                    Colors.deepPurple.shade400,
                                                offset: const Offset(0, 3),
                                                blurRadius: 15,
                                                spreadRadius: -5,
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 3.w, bottom: 2.h),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizeConfig.sH2,
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Task Name : ",
                                                      style: FontTextStyle
                                                              .Proxima16Medium
                                                          .copyWith(
                                                              color: ColorUtils
                                                                  .white),
                                                    ),
                                                    Text(
                                                      data['task'],
                                                      style: FontTextStyle
                                                              .Proxima16Medium
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: ColorUtils
                                                                  .white),
                                                    ),
                                                  ],
                                                ),
                                                SizeConfig.sH2,
                                                data['Image'] == ""
                                                    ? Center(
                                                        child: Column(
                                                          children: [
                                                            Lottie.asset(
                                                                "assets/icons/noImage.json",
                                                                height: 10.w),
                                                            Text(
                                                              " No Image",
                                                              style: FontTextStyle
                                                                      .Proxima16Medium
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .red),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : Center(
                                                        child: Container(
                                                          height: 26.h,
                                                          width: 51.w,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  width: 2,
                                                                  color: ColorUtils
                                                                      .white)),
                                                          child: Image.network(
                                                            data['Image'],
                                                            height: 25.h,
                                                            width: 50.w,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                SizeConfig.sH2,
                                                Row(
                                                  children: [
                                                    Text(
                                                      "AssignDate : ",
                                                      style: FontTextStyle
                                                              .Proxima16Medium
                                                          .copyWith(
                                                              color: ColorUtils
                                                                  .white),
                                                    ),
                                                    Text(
                                                      data['AssignDate'],
                                                      style: FontTextStyle
                                                              .Proxima16Medium
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: ColorUtils
                                                                  .white),
                                                    ),
                                                  ],
                                                ),
                                                SizeConfig.sH05,
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Due Date : ",
                                                      style: FontTextStyle
                                                              .Proxima16Medium
                                                          .copyWith(
                                                              color: ColorUtils
                                                                  .white),
                                                    ),
                                                    Text(
                                                      data['LastDate'],
                                                      style: FontTextStyle
                                                              .Proxima16Medium
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: ColorUtils
                                                                  .white),
                                                    ),
                                                  ],
                                                ),
                                                SizeConfig.sH05,
                                                Row(
                                                  children: [
                                                    Text(
                                                      "User Name  : ",
                                                      style: FontTextStyle
                                                              .Proxima16Medium
                                                          .copyWith(
                                                              color: ColorUtils
                                                                  .white),
                                                    ),
                                                    Text(
                                                      data['Email'],
                                                      style: FontTextStyle
                                                              .Proxima16Medium
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: ColorUtils
                                                                  .white),
                                                    ),
                                                  ],
                                                ),
                                                SizeConfig.sH1,
                                                Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                              ColorUtils.white),
                                                      color: ColorUtils
                                                          .primaryColor,
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  8.0))),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 0.5.h,
                                                        left: 3.w,
                                                        right: 3.w,
                                                        bottom: 0.5.h),
                                                    child: Text(
                                                      data['Name'],
                                                      style: FontTextStyle
                                                              .Proxima16Medium
                                                          .copyWith(
                                                              color: ColorUtils
                                                                  .white),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ],
                                );
                              });
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.transparent,
                            ),
                          );
                        }
                      })
              : const SizedBox(),
        ),
      ),
    );
  }
}
