import 'dart:developer';

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

class Done extends StatefulWidget {
  var Project;
  Done({this.Project});

  @override
  State<Done> createState() => _DoneState();
}

class _DoneState extends State<Done> {
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

  @override
  void initState() {
    setData();
    super.initState();
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
              ? StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection(cid!)
                      .doc(cid)
                      .collection(Project)
                      .doc(Project)
                      .collection('Done')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          padding: EdgeInsets.only(top: 2.h),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
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
                                          boxShadow: [
                                            BoxShadow(
                                              color: ColorUtils.black
                                                  .withOpacity(0.2),
                                              spreadRadius: 0.5,
                                              blurRadius: 9.0,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: ColorUtils.white),
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
                                                  "Task Name :",
                                                  style: FontTextStyle
                                                          .Proxima16Medium
                                                      .copyWith(
                                                          color: ColorUtils
                                                              .primaryColor),
                                                ),
                                                Text(
                                                  data['task'],
                                                  style: FontTextStyle
                                                          .Proxima16Medium
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: ColorUtils
                                                              .primaryColor),
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
                                                : Image.network(
                                                    data['Image'],
                                                    height: 25.h,
                                                    width: 50.w,
                                                    fit: BoxFit.fill,
                                                  ),
                                            SizeConfig.sH2,
                                            Row(
                                              children: [
                                                Text(
                                                  "Starting Date :",
                                                  style: FontTextStyle
                                                          .Proxima16Medium
                                                      .copyWith(
                                                          color: ColorUtils
                                                              .primaryColor),
                                                ),
                                                Text(
                                                  data['AssignDate'],
                                                  style: FontTextStyle
                                                          .Proxima16Medium
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: ColorUtils
                                                              .primaryColor),
                                                ),
                                              ],
                                            ),
                                            SizeConfig.sH05,
                                            Row(
                                              children: [
                                                Text(
                                                  "Due Date :",
                                                  style: FontTextStyle
                                                          .Proxima16Medium
                                                      .copyWith(
                                                          color: ColorUtils
                                                              .primaryColor),
                                                ),
                                                Text(
                                                  data['LastDate'],
                                                  style: FontTextStyle
                                                          .Proxima16Medium
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: ColorUtils
                                                              .primaryColor),
                                                ),
                                              ],
                                            ),
                                            SizeConfig.sH05,
                                            Row(
                                              children: [
                                                Text(
                                                  "User Name  :",
                                                  style: FontTextStyle
                                                          .Proxima16Medium
                                                      .copyWith(
                                                          color: ColorUtils
                                                              .primaryColor),
                                                ),
                                                Text(
                                                  data['Email'],
                                                  style: FontTextStyle
                                                          .Proxima16Medium
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: ColorUtils
                                                              .primaryColor),
                                                ),
                                              ],
                                            ),
                                            SizeConfig.sH05,
                                            Row(
                                              children: [
                                                Text(
                                                  "Starting Date :",
                                                  style: FontTextStyle
                                                          .Proxima16Medium
                                                      .copyWith(
                                                          color: ColorUtils
                                                              .primaryColor),
                                                ),
                                                Text(
                                                  data['StartingDate'],
                                                  style: FontTextStyle
                                                          .Proxima16Medium
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: ColorUtils
                                                              .primaryColor),
                                                ),
                                              ],
                                            ),
                                            SizeConfig.sH05,
                                            Row(
                                              children: [
                                                Text(
                                                  "CheckRequest Date :",
                                                  style: FontTextStyle
                                                          .Proxima16Medium
                                                      .copyWith(
                                                          color: ColorUtils
                                                              .primaryColor),
                                                ),
                                                Text(
                                                  data['CheckRequestDate'],
                                                  style: FontTextStyle
                                                          .Proxima16Medium
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: ColorUtils
                                                              .primaryColor),
                                                ),
                                              ],
                                            ),
                                            SizeConfig.sH05,
                                            Row(
                                              children: [
                                                Text(
                                                  "Approved Date :",
                                                  style: FontTextStyle
                                                          .Proxima16Medium
                                                      .copyWith(
                                                          color: ColorUtils
                                                              .primaryColor),
                                                ),
                                                Text(
                                                  data['ApprovedDate'],
                                                  style: FontTextStyle
                                                          .Proxima16Medium
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: ColorUtils
                                                              .primaryColor),
                                                ),
                                              ],
                                            ),
                                            SizeConfig.sH05,
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.yellow,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0))),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  data['Name'],
                                                  style: FontTextStyle
                                                          .Proxima16Medium
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeightClass
                                                                  .extraB,
                                                          color: ColorUtils
                                                              .primaryColor),
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
                    } else
                      return CircularProgressIndicator();
                  })
              : SizedBox(),
        ),
      ),
    );
  }
}
