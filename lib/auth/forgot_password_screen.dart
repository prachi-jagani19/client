import 'package:client/utils/color_utils.dart';
import 'package:client/utils/font_style_utils.dart';
import 'package:client/utils/size_config_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final firebase = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorUtils.white,
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset("assets/images/background.png"),
              Padding(
                padding: EdgeInsets.only(top: 45.w),
                child: Container(
                  height: 20.w,
                  width: Get.width,
                  decoration: const BoxDecoration(
                      color: ColorUtils.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(90.0))),
                  child: Center(
                    child: Text(
                      "Forgot Password",
                      style: FontTextStyle.Proxima16Medium.copyWith(
                          fontSize: 18.sp,
                          color: ColorUtils.primaryColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 11.w),
            child: Theme(
              data: Theme.of(context).copyWith(
                inputDecorationTheme:
                    Theme.of(context).inputDecorationTheme.copyWith(
                  iconColor: MaterialStateColor.resolveWith(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.focused)) {
                      return ColorUtils.primaryColor;
                    }
                    if (states.contains(MaterialState.error)) {
                      return Colors.red;
                    }
                    return Colors.grey;
                  }),
                ),
              ),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(4.w),
                    filled: true,
                    fillColor: ColorUtils.greyE7.withOpacity(0.5),
                    hintText: "Email/Username",
                    suffixIcon: Icon(
                      Icons.email_outlined,
                      size: 5.w,
                    ),
                    hintStyle: FontTextStyle.Proxima14Regular.copyWith(
                        color: ColorUtils.primaryColor),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)))),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.w, right: 16.w, top: 2.w),
            child: Text(
              "we will send reset password link to entered email address.",
              style: FontTextStyle.Proxima10Regular.copyWith(
                  color: ColorUtils.grey79, fontWeight: FontWeightClass.semiB),
            ),
          ),
          SizeConfig.sH3,
          GestureDetector(
              onTap: () {
                setState(() async {
                  try {
                    await _auth.sendPasswordResetEmail(
                        email: emailController.text);
                    Get.showSnackbar(
                      GetSnackBar(
                        message: "Email send Successfully",
                        borderRadius: 10.0,
                        margin:
                            EdgeInsets.only(left: 4.w, right: 4.w, bottom: 4.w),
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: ColorUtils.primaryColor,
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  } catch (e) {
                    print(e);
                  }
                });
              },
              child: Container(
                height: 6.5.h,
                width: 60.w,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      ColorUtils.primaryColor,
                      ColorUtils.primaryColor.withOpacity(0.5),
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(
                            5,
                            5,
                          ),
                          blurRadius: 10)
                    ]),
                child: Center(
                    child: Text(
                  "Send Email",
                  style: FontTextStyle.Proxima16Medium.copyWith(
                      color: ColorUtils.white),
                )),
              )),
        ],
      ),
    );
  }
}
