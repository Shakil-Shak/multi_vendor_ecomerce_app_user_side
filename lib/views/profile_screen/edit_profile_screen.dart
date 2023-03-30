import 'dart:io';

import 'package:ecomerce_multi_vendor_app/consts/consts.dart';
import 'package:ecomerce_multi_vendor_app/controlers/profile_controller.dart';
import 'package:ecomerce_multi_vendor_app/widgets_common/bg_widgget.dart';
import 'package:ecomerce_multi_vendor_app/widgets_common/button.dart';
import 'package:ecomerce_multi_vendor_app/widgets_common/custom_textfield.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;

  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget2(
        child: Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                  ? Image.asset(
                      imgProfile2,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                      ? Image.network(
                          data['imageUrl'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.file(
                          File(controller.profileImgPath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              Button(
                  color: redColor,
                  onPress: () {
                    controller.changeImage(context);
                  },
                  textColor: whiteColor,
                  title: "Change Photo"),
              const Divider(),
              20.heightBox,
              customTextfield(
                  hint: nameHint,
                  title: name,
                  isPass: false,
                  controller: controller.nameController),
              10.heightBox,
              controller.isloading.value
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : SizedBox(
                      width: context.screenWidth - 100,
                      child: Button(
                          color: redColor,
                          onPress: () async {
                            controller.isloading(true);

                            // img check
                            if (controller.profileImgPath.value.isNotEmpty) {
                              await controller.uplodeProfileImage();
                            } else {
                              controller.profileImgLink = data['imageUrl'];
                            }

                            await controller.updateNamePhoto(
                              imgUrl: controller.profileImgLink,
                              name: controller.nameController.text,
                            );
                            controller.isloading(false);
                            VxToast.show(context, msg: "Upated");
                          },
                          textColor: whiteColor,
                          title: "Save Info"),
                    ),
              20.heightBox,
              customTextfield(
                  hint: passwordHint,
                  title: oldpass,
                  isPass: true,
                  controller: controller.oldpasswordController),
              10.heightBox,
              customTextfield(
                  hint: passwordHint,
                  title: newpass,
                  isPass: true,
                  controller: controller.newpasswordController),
              20.heightBox,
              controller.isloading.value
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : SizedBox(
                      width: context.screenWidth - 100,
                      child: Button(
                          color: redColor,
                          onPress: () async {
                            controller.isloading(true);

                            // password chk

                            if (data['password'] ==
                                controller.oldpasswordController.text) {
                              await controller.changeAuthPassword(
                                  email: data['email'],
                                  password:
                                      controller.oldpasswordController.text,
                                  newpassword:
                                      controller.newpasswordController.text);

                              await controller.updatePassword(
                                  password:
                                      controller.newpasswordController.text);
                              controller.isloading(false);
                              VxToast.show(context, msg: "Upated");
                            } else {
                              VxToast.show(context, msg: "Wrong old password");
                              controller.isloading(false);
                            }
                          },
                          textColor: whiteColor,
                          title: "Chnage Password"),
                    ),
            ],
          )
              .box
              .white
              .shadowLg
              .rounded
              .padding(EdgeInsets.all(16))
              .margin(EdgeInsets.only(top: 50, left: 12, right: 12))
              .make(),
        ),
      ),
    ));
  }
}
