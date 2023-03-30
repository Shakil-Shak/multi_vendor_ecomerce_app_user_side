import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce_multi_vendor_app/consts/consts.dart';
import 'package:ecomerce_multi_vendor_app/consts/lists.dart';
import 'package:ecomerce_multi_vendor_app/controlers/auth_controller.dart';
import 'package:ecomerce_multi_vendor_app/controlers/profile_controller.dart';
import 'package:ecomerce_multi_vendor_app/views/auth_screen/login_screen.dart';
import 'package:ecomerce_multi_vendor_app/views/chat_screen/messaging_screen.dart';
import 'package:ecomerce_multi_vendor_app/views/order_screen/order_screen.dart';
import 'package:ecomerce_multi_vendor_app/views/profile_screen/edit_profile_screen.dart';
import 'package:ecomerce_multi_vendor_app/views/wishlist_screen/wishlist_screen.dart';
import 'package:ecomerce_multi_vendor_app/widgets_common/bg_widgget.dart';
import 'package:ecomerce_multi_vendor_app/widgets_common/loading_indicator.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../services/firestore_services.dart';
import 'components/details_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget2(
        child: Scaffold(
      body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];
              return SafeArea(
                  child: Column(
                children: [
                  // 10.heightBox,
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: const Align(
                  //     alignment: Alignment.centerRight,
                  //     child: Icon(
                  //       Icons.logout,
                  //       color: whiteColor,
                  //     ),
                  //   ).onTap(() async {

                  //   }),
                  // ),
                  15.heightBox,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        20.widthBox,
                        data['imageUrl'] == ''
                            ? Image.asset(
                                imgProfile2,
                                width: 90,
                                fit: BoxFit.cover,
                              ).box.roundedFull.clip(Clip.antiAlias).make()
                            : Image.network(
                                data['imageUrl'],
                                width: 90,
                                fit: BoxFit.cover,
                              ).box.roundedFull.clip(Clip.antiAlias).make(),
                        10.widthBox,
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "${data['name']}"
                                .text
                                .fontFamily(semibold)
                                .white
                                .make(),
                            1.heightBox,
                            "${data['email']}"
                                .text
                                .overflow(TextOverflow.ellipsis)
                                .white
                                .make()
                          ],
                        )),
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: whiteColor)),
                            onPressed: () {
                              // await Get.put(AuthController())
                              //     .signoutMethod(context);
                              // Get.offAll(() => const LoginScreen());
                              controller.nameController.text = data['name'];
                              Get.to(() => EditProfileScreen(
                                    data: data,
                                  ));
                            },
                            child: edit.text.fontFamily(semibold).white.make()),
                        20.widthBox,
                      ],
                    ).box.color(redColor).roundedLg.make(),
                  ),
                  20.heightBox,
                  FutureBuilder(
                    future: FirestoreServices.getCounts(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: loadingIndecator(),
                        );
                      } else {
                        var countData = snapshot.data;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              detailsCard(
                                  count: countData[0].toString(),
                                  title: "in your cart",
                                  width: context.screenWidth / 3.4),
                              detailsCard(
                                  count: countData[1].toString(),
                                  title: "in your wishlist",
                                  width: context.screenWidth / 3.4),
                              detailsCard(
                                  count: countData[2].toString(),
                                  title: "your orders",
                                  width: context.screenWidth / 3.4),
                            ],
                          ).box.white.roundedSM.shadowLg.make(),
                        );
                      }
                    },
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     detailsCard(
                  //         count: data['cart_count'],
                  //         title: "in your cart",
                  //         width: context.screenWidth / 3.4),
                  //     detailsCard(
                  //         count: data['wishlist_count'],
                  //         title: "in your wishlist",
                  //         width: context.screenWidth / 3.4),
                  //     detailsCard(
                  //         count: data['order_count'],
                  //         title: "your orders",
                  //         width: context.screenWidth / 3.4),
                  //   ],
                  // ),
                  ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return const Divider(
                              color: lightGrey,
                            );
                          },
                          itemCount: profileButtonsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              onTap: () async {
                                switch (index) {
                                  case 0:
                                    Get.to(() => const OrderScreen());
                                    break;
                                  case 1:
                                    Get.to(() => const WishlistScreen());
                                    break;
                                  case 2:
                                    Get.to(() => const MessagesScreen());
                                    break;
                                  case 3:
                                    await Get.put(AuthController())
                                        .signoutMethod(context);
                                    Get.offAll(() => const LoginScreen());
                                }
                              },
                              trailing: Icon(Icons.arrow_forward_ios),
                              leading: Image.asset(
                                profileButtonsIcon[index],
                                width: 22,
                              ),
                              title: profileButtonsList[index]
                                  .text
                                  .fontFamily(bold)
                                  .color(darkFontGrey)
                                  .make(),
                            );
                          })
                      .box
                      .white
                      .rounded
                      .margin(EdgeInsets.all(12))
                      .shadowLg
                      .padding(const EdgeInsets.symmetric(horizontal: 16))
                      .make()
                      .box
                      .make()
                ],
              ));
            }
          }),
    ));
  }
}
