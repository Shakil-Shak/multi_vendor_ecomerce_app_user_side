import 'package:ecomerce_multi_vendor_app/consts/colors.dart';
import 'package:ecomerce_multi_vendor_app/consts/consts.dart';
import 'package:ecomerce_multi_vendor_app/views/auth_screen/login_screen.dart';
import 'package:ecomerce_multi_vendor_app/views/home_screen/home.dart';
import 'package:ecomerce_multi_vendor_app/widgets_common/applogo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  changeScreen() {
    Future.delayed(Duration(seconds: 3), () {
      // Get.to(() => LoginScreen());
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(() => LoginScreen());
        } else {
          Get.to(() => Home());
        }
      });
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Column(children: [
        Align(
          alignment: Alignment.topLeft,
          child: Image.asset(
            icSplashBg,
            width: 300,
          ),
        ),
        20.heightBox,
        applogoWidget(),
        10.heightBox,
        appname.text.fontFamily(bold).size(22).white.make(),
        5.heightBox,
        appversion.text.white.make(),
        Spacer(),
        credits.text.white.fontFamily(semibold).make(),
        30.heightBox
      ]),
    );
  }
}
