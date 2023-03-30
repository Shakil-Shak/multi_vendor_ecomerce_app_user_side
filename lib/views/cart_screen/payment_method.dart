import 'package:ecomerce_multi_vendor_app/consts/colors.dart';
import 'package:ecomerce_multi_vendor_app/consts/consts.dart';
import 'package:ecomerce_multi_vendor_app/consts/lists.dart';
import 'package:ecomerce_multi_vendor_app/controlers/cart_controller.dart';
import 'package:ecomerce_multi_vendor_app/views/home_screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../widgets_common/button.dart';
import '../../widgets_common/loading_indicator.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 50,
          child: controller.placingOrder.value
              ? Center(
                  child: loadingIndecator(),
                )
              : Button(
                  title: "Place my order",
                  textColor: whiteColor,
                  color: redColor,
                  onPress: () async {
                    await controller.placeMyOrder(
                        orderPaymentMethod:
                            paymentMethods[controller.paymentIndex.value],
                        totalAmount: controller.totalP.value);
                    await controller.clearCart();
                    VxToast.show(context, msg: "order placed successfully");
                    Get.offAll(const Home());
                  }),
        ),
        appBar: AppBar(
          title: "Choice Payment Method"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => Column(
              children: List.generate(paymentMethodImg.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.changePaymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: controller.paymentIndex.value == index
                              ? redColor
                              : Colors.transparent,
                          width: 4,
                        )),
                    margin: EdgeInsets.only(bottom: 8),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.asset(
                          paymentMethodImg[index],
                          width: double.infinity,
                          height: 130,
                          fit: BoxFit.fill,
                          colorBlendMode: controller.paymentIndex.value == index
                              ? BlendMode.darken
                              : BlendMode.color,
                          color: controller.paymentIndex.value == index
                              ? Colors.black.withOpacity(0.3)
                              : Colors.transparent,
                        ),
                        controller.paymentIndex.value == index
                            ? Transform.scale(
                                scale: 1.4,
                                child: Checkbox(
                                    activeColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    value: true,
                                    onChanged: (value) {}),
                              )
                            : Container(),
                        Positioned(
                            bottom: 10,
                            right: 15,
                            child: paymentMethods[index]
                                .text
                                .white
                                .fontFamily(bold)
                                .size(16)
                                .make()),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
