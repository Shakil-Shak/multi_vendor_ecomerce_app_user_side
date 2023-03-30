import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce_multi_vendor_app/consts/consts.dart';
import 'package:ecomerce_multi_vendor_app/services/firestore_services.dart';
import 'package:ecomerce_multi_vendor_app/views/order_screen/order_details.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../widgets_common/loading_indicator.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My orders".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndecator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No orders found".text.color(darkFontGrey).makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: "${index + 1}"
                      .text
                      .fontFamily(bold)
                      .color(darkFontGrey)
                      .xl
                      .make(),
                  title: data[index]['order_code']
                      .toString()
                      .text
                      .color(redColor)
                      .fontFamily(semibold)
                      .make(),
                  subtitle: data[index]['total_amount']
                      .toString()
                      .numCurrency
                      .text
                      .fontFamily(bold)
                      .make(),
                  trailing: IconButton(
                    onPressed: () {
                      Get.to(() => OrderDetails(
                            data: data[index],
                          ));
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: darkFontGrey,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
