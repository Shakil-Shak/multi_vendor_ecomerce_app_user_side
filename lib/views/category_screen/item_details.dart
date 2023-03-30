import 'dart:math';

import 'package:ecomerce_multi_vendor_app/consts/consts.dart';
import 'package:ecomerce_multi_vendor_app/consts/lists.dart';
import 'package:ecomerce_multi_vendor_app/controlers/product_controller.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ecomerce_multi_vendor_app/consts/consts.dart';
import 'package:get/get.dart';

import '../../widgets_common/button.dart';
import '../chat_screen/chat_screen.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({super.key, required this.title, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              controller.resetValues();
              Get.back();
            },
          ),
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                )),
            Obx(
              () => IconButton(
                  onPressed: () {
                    if (controller.isFav.value) {
                      controller.removeFromWishlist(data.id, context);
                    } else {
                      controller.addToWishlist(data.id, context);
                    }
                  },
                  icon: Icon(
                    Icons.favorite_outlined,
                    color: controller.isFav.value ? redColor : darkFontGrey,
                  )),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // product image with swipe
                    VxSwiper.builder(
                        autoPlay: true,
                        height: 350,
                        itemCount: data['p_imgs'].length,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        itemBuilder: (context, index) {
                          return Image.network(
                            data["p_imgs"][index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        }),
                    10.heightBox,
                    // product ame and description
                    title!.text
                        .size(17)
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    10.heightBox,
                    VxRating(
                      isSelectable: false,
                      value: double.parse(data['p_rating']),
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      count: 5,
                      size: 25,
                      maxRating: 5,
                    ),
                    10.heightBox,
                    "\$${data['p_price']}"
                        .text
                        .color(redColor)
                        .fontFamily(bold)
                        .size(18)
                        .make(),

                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                            child: "${data['p_seller']}"
                                .text
                                .fontFamily(semibold)
                                .color(whiteColor)
                                .size(16)
                                .make()),
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.message_rounded,
                            color: darkFontGrey,
                          ),
                        ).onTap(() {
                          Get.to(() => ChatScreen(),
                              arguments: [data['p_seller'], data['vendor_id']]);
                        })
                      ],
                    )
                        .box
                        .height(60)
                        .padding(const EdgeInsets.symmetric(horizontal: 16))
                        .color(redColor)
                        .roundedSM
                        .make(),

                    //color section
                    20.heightBox,
                    Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Color: ".text.color(redColor).make(),
                              ),
                              Row(
                                children: List.generate(
                                    data['p_colors'].length,
                                    (index) => Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            VxBox()
                                                .size(40, 40)
                                                .roundedFull
                                                .color(Color(
                                                        data['p_colors'][index])
                                                    .withOpacity(1.0))
                                                .margin(
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6))
                                                .make()
                                                .onTap(() {
                                              controller
                                                  .changeColorIndex(index);
                                            }),
                                            Visibility(
                                              visible: index ==
                                                  controller.colorIndex.value,
                                              child: const Icon(
                                                Icons.done,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        )),
                              )
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),

                          // quantity
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Quantity: ".text.color(redColor).make(),
                              ),
                              Obx(
                                () => Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          controller.decreaseQuantity();
                                          controller.calculateTotalPrice(
                                              int.parse(data['p_price']));
                                        },
                                        icon: const Icon(Icons.remove)),
                                    controller.quantity.value.text
                                        .size(16)
                                        .color(darkFontGrey)
                                        .fontFamily(bold)
                                        .make(),
                                    IconButton(
                                        onPressed: () {
                                          controller.increaseQuantity(
                                              int.parse(data['p_quantity']));
                                          controller.calculateTotalPrice(
                                              int.parse(data['p_price']));
                                        },
                                        icon: const Icon(Icons.add)),
                                    10.widthBox,
                                    "(${data['p_quantity']} available)"
                                        .text
                                        .color(redColor)
                                        .make()
                                  ],
                                ),
                              )
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Total: ".text.color(redColor).make(),
                              ),
                              "${controller.totalPrice.value}"
                                  .numCurrency
                                  .text
                                  .color(redColor)
                                  .size(16)
                                  .fontFamily(bold)
                                  .make()
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make()
                        ],
                      ).box.white.shadowSm.roundedSM.make(),
                    ),
                    // description section
                    20.heightBox,
                    "Description"
                        .text
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    10.heightBox,
                    "${data['p_desc']}".text.color(darkFontGrey).make(),

                    // buttons
                    10.heightBox,
                    ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                          itemDetalsButtonList.length,
                          (index) => ListTile(
                                title: "${itemDetalsButtonList[index]}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                trailing: const Icon(Icons.arrow_forward),
                              )),
                    ),
                    //product may like section
                    20.heightBox,
                    // productsyoumaylike.text
                    //     .fontFamily(bold)
                    //     .size(16)
                    //     .color(darkFontGrey)
                    //     .make(),
                    // 10.heightBox,
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     children: List.generate(
                    //         6,
                    //         (index) => Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Image.asset(
                    //                   imgP1,
                    //                   width: 150,
                    //                   fit: BoxFit.cover,
                    //                 ),
                    //                 10.heightBox,
                    //                 "Laptop 8GB/500GB"
                    //                     .text
                    //                     .fontFamily(semibold)
                    //                     .color(darkFontGrey)
                    //                     .make(),
                    //                 10.heightBox,
                    //                 "\$7999"
                    //                     .text
                    //                     .color(redColor)
                    //                     .fontFamily(bold)
                    //                     .size(16)
                    //                     .make()
                    //               ],
                    //             )
                    //                 .box
                    //                 .white
                    //                 .margin(const EdgeInsets.symmetric(
                    //                     horizontal: 4))
                    //                 .roundedSM
                    //                 .padding(const EdgeInsets.all(8))
                    //                 .make()),
                    //   ),
                    // )
                  ],
                ),
              ),
            )),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: Button(
                  color: redColor,
                  onPress: () {
                    if (controller.quantity.value > 0) {
                      controller.addToCart(
                          context: context,
                          color: data['p_colors'][controller.colorIndex.value],
                          img: data['p_imgs'][0],
                          qty: controller.quantity.value,
                          sellername: data['p_seller'],
                          title: data['p_name'],
                          vendorId: data['vendor_id'],
                          tprice: controller.totalPrice.value);
                      VxToast.show(context, msg: "Added to cart");
                    } else {
                      VxToast.show(context, msg: "Quantity can not be 0");
                    }
                  },
                  textColor: whiteColor,
                  title: "Add to cart"),
            )
          ],
        ),
      ),
    );
  }
}
