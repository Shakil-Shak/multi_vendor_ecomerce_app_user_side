import 'package:ecomerce_multi_vendor_app/consts/consts.dart';
import 'package:ecomerce_multi_vendor_app/controlers/auth_controller.dart';
import 'package:ecomerce_multi_vendor_app/views/auth_screen/signup_screen.dart';
import 'package:ecomerce_multi_vendor_app/views/home_screen/home.dart';
import 'package:ecomerce_multi_vendor_app/widgets_common/applogo_widget.dart';
import 'package:ecomerce_multi_vendor_app/widgets_common/bg_widgget.dart';
import 'package:ecomerce_multi_vendor_app/widgets_common/button.dart';
import 'package:ecomerce_multi_vendor_app/widgets_common/custom_textfield.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/lists.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(children: [
          (context.screenHeight * 0.1).heightBox,
          applogoWidget(),
          10.heightBox,
          "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
          15.heightBox,
          Obx(
            () => Column(
              children: [
                customTextfield(
                    hint: emailHint,
                    title: email,
                    isPass: false,
                    controller: controller.emailController),
                customTextfield(
                    hint: passwordHint,
                    title: password,
                    isPass: true,
                    controller: controller.passwordController),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {}, child: forgetpass.text.make())),
                5.heightBox,
                controller.isloading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : Button(
                        color: redColor,
                        title: login,
                        textColor: whiteColor,
                        onPress: () async {
                          if (controller.emailController.text.isNotEmpty &&
                              controller.passwordController.text.isNotEmpty) {
                            controller.isloading(true);
                            await controller
                                .loginMethod(context: context)
                                .then((value) {
                              if (value != null) {
                                VxToast.show(context, msg: loginSuccess);
                                Get.offAll(() => const Home());
                              } else {
                                controller.isloading(false);
                              }
                            });
                          } else {
                            VxToast.show(context,
                                msg: "Please fill all fields");
                          }
                        }).box.width(context.screenWidth - 50).make(),
                5.heightBox,
                // createNewAccount.text.color(fontGrey).make(),
                // 5.heightBox,
                // Button(
                //     color: lightGolden,
                //     title: signup,
                //     textColor: redColor,
                //     onPress: () {
                //       Get.to(() => const SignupScreen());
                //     }).box.width(context.screenWidth - 50).make(),
                10.heightBox,
                loginWith.text.color(fontGrey).make(),
                5.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      3,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: lightGrey,
                              radius: 25,
                              child: Image.asset(
                                socialIconList[index],
                                width: 30,
                              ),
                            ),
                          )),
                ),
                20.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    noAccount.text.color(fontGrey).make(),
                    signup.text.color(redColor).bold.make().onTap(() {
                      Get.to(() => const SignupScreen());
                    })
                  ],
                )
              ],
            )
                .box
                .white
                .rounded
                .padding(EdgeInsets.all(16))
                .width(context.screenWidth - 70)
                .shadowSm
                .make(),
          ),
        ]),
      ),
    ));
  }
}
