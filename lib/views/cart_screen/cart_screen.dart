import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce_multi_vendor_app/consts/consts.dart';
import 'package:ecomerce_multi_vendor_app/controlers/cart_controller.dart';
import 'package:ecomerce_multi_vendor_app/services/firestore_services.dart';
import 'package:ecomerce_multi_vendor_app/views/cart_screen/shipping_screen.dart';
import 'package:ecomerce_multi_vendor_app/widgets_common/button.dart';
import 'package:ecomerce_multi_vendor_app/widgets_common/loading_indicator.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../controlers/auth_controller.dart';
import '../auth_screen/login_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        backgroundColor: whiteColor,
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () async {
        //     await Get.put(AuthController()).signoutMethod(context);
        //     Get.offAll(() => const LoginScreen());
        //   },
        // ),
        bottomNavigationBar: SizedBox(
          height: 50,
          child: Button(
              color: redColor,
              textColor: whiteColor,
              title: "Proceed to shipping",
              onPress: () {
                if (controller.isCartEmpty == true) {
                  Get.to(() => const ShippingDetails());
                } else {
                  VxToast.show(context, msg: "Cart is empty");
                }
              }),
        ),
        appBar: AppBar(
          title: "Shopping cart"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getCart(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndecator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "Cart is empty".text.color(darkFontGrey).make(),
              );
            } else {
              var data = snapshot.data!.docs;
              controller.calculate(data);
              controller.isCartEmpty(true);
              controller.productSnapshot = data;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Image.network(
                            "${data[index]['img']}",
                            width: 100,
                            fit: BoxFit.contain,
                          ),
                          title:
                              "${data[index]['title']} (x${data[index]['qty']})"
                                  .text
                                  .fontFamily(semibold)
                                  .size(16)
                                  .make(),
                          subtitle: "${data[index]['tprice']}"
                              .numCurrency
                              .text
                              .fontFamily(semibold)
                              .color(redColor)
                              .make(),
                          trailing: const Icon(
                            Icons.delete,
                            color: redColor,
                          ).onTap(() {
                            FirestoreServices.deleteDocument(data[index].id);
                          }),
                        );
                      },
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Total price"
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        Obx(
                          () => "${controller.totalP.value}"
                              .numCurrency
                              .text
                              .fontFamily(semibold)
                              .color(redColor)
                              .make(),
                        ),
                      ],
                    )
                        .box
                        .padding(EdgeInsets.all(12))
                        .width(context.screenWidth - 70)
                        .color(lightGolden)
                        .roundedSM
                        .make(),
                    10.heightBox,
                    // SizedBox(
                    //   width: context.screenWidth - 70,
                    //   child: Button(
                    //       color: redColor,
                    //       textColor: whiteColor,
                    //       title: "Proceed to shipping",
                    //       onPress: () {}),
                    // )
                  ],
                ),
              );
            }
          },
        ));
  }
}
