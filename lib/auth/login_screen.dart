import 'package:client/auth/registration_screen.dart';
import 'package:client/bottom_screen.dart';
import 'package:client/utils/color_utils.dart';
import 'package:client/utils/font_style_utils.dart';
import 'package:client/utils/size_config_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  String id;
  LoginScreen({required this.id});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool isCheckPassword = true;
  final formkey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String id = widget.id;
    return GestureDetector(
      onTapDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorUtils.white,
        body: Form(
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
                      child: Center(
                        child: Text(
                          "Welcome Back",
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
                child: TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  cursorColor: ColorUtils.primaryColor,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "please email required";
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
                      suffixIcon: Icon(
                        Icons.email_outlined,
                        size: 5.w,
                      ),
                      suffixIconColor: MaterialStateColor.resolveWith(
                          (states) => states.contains(MaterialState.focused)
                              ? ColorUtils.primaryColor
                              : Colors.grey),
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
                    return null;
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
              SizeConfig.sH1,
              Padding(
                padding: EdgeInsets.only(right: 6.w, top: 1.h),
                child: GestureDetector(
                  onTap: () {},
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Forgot Password?",
                      style: FontTextStyle.Proxima10Regular.copyWith(
                          color: ColorUtils.grey79,
                          fontWeight: FontWeightClass.semiB),
                    ),
                  ),
                ),
              ),
              SizeConfig.sH3,
              InkWell(
                onTap: () async {
                  FocusScope.of(context).requestFocus();
                  if (formkey.currentState!.validate()) {
                    final newUser = await _auth.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text);
                    final pref = await SharedPreferences.getInstance();
                    pref.setString("userId", _auth.currentUser!.uid);
                    pref.setString("companyId", id);

                    Get.showSnackbar(
                      GetSnackBar(
                        message: "Login Succesfully",
                        borderRadius: 10.0,
                        margin:
                            EdgeInsets.only(left: 4.w, right: 4.w, bottom: 4.w),
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: ColorUtils.primaryColor,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                    Future.delayed(
                      const Duration(seconds: 3),
                      () {
                        Get.to(() => const BottomScreen());
                      },
                    );
                  }
                },
                child: Container(
                  height: 6.h,
                  width: 55.w,
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
                    "SIGN IN",
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
                    "Don't have account ?",
                    style: FontTextStyle.Proxima10Regular.copyWith(
                        color: ColorUtils.primaryColor,
                        fontWeight: FontWeightClass.semiB),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.to(() => RegisterScreen(id: id));
                      },
                      child: Text(
                        "Sign Up",
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
    );
  }
}
