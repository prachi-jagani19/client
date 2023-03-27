import 'dart:developer';

import 'package:client/change_theme/model_theme.dart';
import 'package:client/shimmer_effect.dart';
import 'package:client/show_all_details.dart';
import 'package:client/utils/color_utils.dart';
import 'package:client/utils/font_style_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return Scaffold(
        backgroundColor:
            themeNotifier.isDark ? Colors.black.withOpacity(0.8) : Colors.white,
        body: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: cid != null
                ? isShimmer == true
                    ? projectList()
                    : StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection(cid!)
                            .doc(cid)
                            .collection('Client')
                            .doc(_auth.currentUser!.uid)
                            .collection('ClientProject')
                            .snapshots(),
                        builder: (context, snapshot) {
                          return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data == null
                                ? 0
                                : snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              var data = snapshot.data!.docs[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.w, horizontal: 5.w),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(() => TaskScreen(
                                        Project: data['PROJECT NAME']));
                                  },
                                  child: Container(
                                    height: 18.w,
                                    width: 55.w,
                                    decoration: const BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: ColorUtils.purple,
                                            offset: Offset(0, 3),
                                            blurRadius: 15,
                                            spreadRadius: -5,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        color: ColorUtils.purple),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5.w, vertical: 3.w),
                                      child: Text(
                                        data['PROJECT NAME'],
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: FontTextStyle.Proxima16Medium
                                            .copyWith(
                                          fontWeight: FontWeightClass.extraB,
                                          color: ColorUtils.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        })
                : const SizedBox(),
          ),
        ),
      );
    });
  }
}
