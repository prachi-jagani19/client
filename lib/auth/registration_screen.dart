import 'package:client/auth/login_screen.dart';
import 'package:client/utils/color_utils.dart';
import 'package:client/utils/font_style_utils.dart';
import 'package:client/utils/size_config_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../utils/const/function/local_notification_services.dart';

class RegisterScreen extends StatefulWidget {
  String id;
  RegisterScreen({required this.id});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isCheckPassword = true;
  final formkey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    String id = widget.id;
    return GestureDetector(
      onTapDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        backgroundColor: ColorUtils.white,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: formkey,
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sign Up",
                                style: FontTextStyle.Proxima16Medium.copyWith(
                                    fontSize: 18.sp,
                                    color: ColorUtils.primaryColor,
                                    fontWeight: FontWeightClass.semiB),
                              ),
                              Text(
                                "create your account",
                                style: FontTextStyle.Proxima14Regular.copyWith(
                                    color: ColorUtils.primaryColor,
                                    fontWeight: FontWeightClass.semiB),
                              ),
                            ],
                          )),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 11.w),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    cursorColor: ColorUtils.primaryColor,
                    controller: nameController,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Name required";
                      } else if (!RegExp(
                              r'^[[A-Z]|[a-z]][[A-Z]|[a-z]|\\d|[_]]{7,29}$')
                          .hasMatch(v)) {
                        return "Enter valid name ";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(4.w),
                        filled: true,
                        fillColor: ColorUtils.greyE7.withOpacity(0.5),
                        hintText: "Full Name",
                        hintStyle: FontTextStyle.Proxima14Regular.copyWith(
                            color: ColorUtils.primaryColor),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 2.w),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    cursorColor: ColorUtils.primaryColor,
                    controller: emailController,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Email required";
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                              r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                              r"{0,253}[a-zA-Z0-9])?)*$")
                          .hasMatch(v)) {
                        return "please enter valid email ";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(4.w),
                        filled: true,
                        fillColor: ColorUtils.greyE7.withOpacity(0.5),
                        hintText: "Email/Username",
                        hintStyle: FontTextStyle.Proxima14Regular.copyWith(
                            color: ColorUtils.primaryColor),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2.w, left: 6.w, right: 6.w),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    cursorColor: ColorUtils.primaryColor,
                    controller: mobileNumberController,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      // add your custom validation here.
                      if (v!.isEmpty) {
                        return "Mobile number required";
                      } else if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                          .hasMatch(v)) {
                        return "please enter 10 digits ";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(4.w),
                        filled: true,
                        fillColor: ColorUtils.greyE7.withOpacity(0.5),
                        hintText: "Mobile number",
                        hintStyle: FontTextStyle.Proxima14Regular.copyWith(
                            color: ColorUtils.primaryColor),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 4.w),
                  child: TextFormField(
                    cursorColor: ColorUtils.primaryColor,
                    controller: passwordController,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Please enter password';
                      }
                      if (v.length <= 6) {
                        return 'Password must be at least 6 characters long';
                      }
                    },
                    obscureText: isCheckPassword,
                    decoration: InputDecoration(
                        suffixIconColor: MaterialStateColor.resolveWith(
                            (states) => states.contains(MaterialState.focused)
                                ? ColorUtils.primaryColor
                                : Colors.grey),
                        contentPadding: EdgeInsets.all(4.w),
                        filled: true,
                        fillColor: ColorUtils.greyE7.withOpacity(0.5),
                        hintText: "Password",
                        suffixIcon: InkWell(
                          onTap: () {
                            isCheckPassword = !isCheckPassword;
                            setState(() {});
                          },
                          child: Icon(isCheckPassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        hintStyle: FontTextStyle.Proxima14Regular.copyWith(
                            color: ColorUtils.primaryColor),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
                SizeConfig.sH3,
                InkWell(
                  onTap: () async {
                    FocusScope.of(context).requestFocus();
                    if (formkey.currentState!.validate()) {
                      final newuser =
                          await _auth.createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text);
                      String? fcmToken =
                          await LocalNotificationServices.getFCMToken();
                      FirebaseFirestore.instance
                          .collection(id)
                          .doc(id)
                          .collection('Client')
                          .doc(_auth.currentUser!.uid)
                          .set({
                        'Name': nameController.text,
                        'Phone': mobileNumberController.text,
                        'Email': emailController.text,
                        'password': passwordController.text,
                        'Uid': _auth.currentUser!.uid,
                      });
                      FirebaseFirestore.instance
                          .collection(id)
                          .doc(id)
                          .collection('user')
                          .doc(_auth.currentUser!.uid)
                          .set({
                        'Name': nameController.text + "(Client)",
                        'City': '',
                        'DOB': '',
                        'Email': emailController.text,
                        'Phone': '',
                        'Password': passwordController.text,
                        'Uid': _auth.currentUser!.uid,
                        'ProfileImage': "",
                        'fcmToken': fcmToken ?? '',
                      });

                      Get.showSnackbar(
                        GetSnackBar(
                          message: "Register Succesfully",
                          borderRadius: 10.0,
                          margin: EdgeInsets.only(
                              left: 4.w, right: 4.w, bottom: 4.w),
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: ColorUtils.primaryColor,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                      Future.delayed(
                        const Duration(seconds: 3),
                        () {
                          Get.to(() => LoginScreen(id: id));
                        },
                      );
                    }
                  },
                  child: Container(
                    height: 6.h,
                    width: 55.w,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              ColorUtils.primaryColor,
                              ColorUtils.primaryColor.withOpacity(0.5),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
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
                      "SIGN UP",
                      style: FontTextStyle.Proxima16Medium.copyWith(
                          color: ColorUtils.white),
                    )),
                  ),
                ),
                SizeConfig.sH2,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Do you have an account ?",
                      style: FontTextStyle.Proxima10Regular.copyWith(
                          color: ColorUtils.primaryColor,
                          fontWeight: FontWeightClass.semiB),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(() => LoginScreen(id: id));
                        },
                        child: Text(
                          "Sign In",
                          style: FontTextStyle.Proxima14Regular.copyWith(
                              color: ColorUtils.primaryColor,
                              fontWeight: FontWeightClass.semiB),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
