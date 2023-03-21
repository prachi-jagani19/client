import 'package:client/auth/login_screen.dart';
import 'package:client/utils/color_utils.dart';
import 'package:client/utils/font_style_utils.dart';
import 'package:client/utils/size_config_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
  @override
  Widget build(BuildContext context) {
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
                        return "please name required";
                      } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(v)) {
                        return "please valid name ";
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
                        return "please mobile number required";
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
                      if (v.length <= 8) {
                        return 'Password must be atleast 8 characters long';
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
                  onTap: () {
                    FocusScope.of(context).requestFocus();
                    if (formkey.currentState!.validate()) {
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
                          Get.to(() => const LoginScreen());
                        },
                      );
                    }
                  },
                  child: Container(
                    height: 6.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                        color: ColorUtils.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Center(
                      child: Text(
                        "SIGN UP",
                        style: FontTextStyle.Proxima16Medium.copyWith(
                            color: ColorUtils.white),
                      ),
                    ),
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
                          Get.to(() => LoginScreen());
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
