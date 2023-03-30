import 'package:ecomerce_multi_vendor_app/consts/consts.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'components/order_place_details.dart';
import 'components/order_status.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatelessWidget {
  final dynamic data;
  const OrderDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My orders".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(children: [
            orderStatus(
                color: redColor,
                icon: icPlaced,
                title: "Placed",
                showDone: data['order_placed']),
            const Divider(),
            orderStatus(
                color: Colors.blue,
                icon: icConfirmed,
                title: "Confirmed",
                showDone: data['order_confirmed']),
            const Divider(),
            orderStatus(
                color: Colors.green,
                icon: icOnDelivery,
                title: "On Delivery",
                showDone: data['order_on_delivery']),
            const Divider(),
            orderStatus(
                color: Colors.black,
                icon: icDeliverd,
                title: "Delivered",
                showDone: data['order_delivered']),
            const Divider(),
            10.heightBox,
            Column(
              children: [
                orderPlaceDetails(
                    d1: data['order_code'],
                    d2: data['shipping_method'],
                    title1: "Order Code",
                    title2: "Shipping Method"),
                orderPlaceDetails(
                    d1: intl.DateFormat()
                        .add_yMd()
                        .format(data['order_date'].toDate()),
                    d2: data['payment_method'],
                    title1: "Order Date",
                    title2: "Payment Method"),
                orderPlaceDetails(
                    d1: "Unpaid",
                    d2: "Order Placed",
                    title1: "Payment Status",
                    title2: "Delivery Status"),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Shipping Address".text.fontFamily(semibold).make(),
                          "${data['order_by_name']}".text.make(),
                          "${data['order_by_email']}".text.make(),
                          "${data['order_by_address']}".text.make(),
                          "${data['order_by_city']}".text.make(),
                          "${data['order_by_state']}".text.make(),
                          "${data['order_by_phone']}".text.make(),
                          "${data['order_by_postalcode']}".text.make(),
                          20.heightBox,
                          SizedBox(
                            width: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Total Amount".text.fontFamily(semibold).make(),
                                "${data['total_amount']}"
                                    .text
                                    .color(redColor)
                                    .fontFamily(semibold)
                                    .make(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ).box.outerShadowLg.white.make(),
            const Divider(),
            10.heightBox,
            "Ordered Product"
                .text
                .size(16)
                .color(darkFontGrey)
                .fontFamily(semibold)
                .makeCentered(),
            10.heightBox,
            ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(data['orders'].length, (index) {
                return ListTile(
                    leading: Image.network(
                      "${data['orders'][index]['img']}",
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                    title: "${data['orders'][index]['title']}".text.make(),
                    subtitle: Row(
                      children: [
                        "${data['orders'][index]['qty']}x".text.make(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(data['orders'][index]['color']),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            width: 30,
                            height: 20,
                            // color: Color(data['orders'][index]['color']),
                          ),
                        ),
                      ],
                    ),
                    trailing: "\$${data['orders'][index]['tprice']}"
                        .text
                        .color(redColor)
                        .make());
                // Row(

                //   children: [
                //     Image.network(
                //       "${data['orders'][index]['img']}",
                //       width: 100,
                //       fit: BoxFit.contain,
                //     ),
                //     Expanded(
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           orderPlaceDetails(
                //               title1: data['orders'][index]['title'],
                //               title2: "Price",
                //               d1: "${data['orders'][index]['qty']}x",
                //               d2: data['orders'][index]['tprice']),
                //           Padding(
                //             padding: const EdgeInsets.symmetric(horizontal: 16),
                //             child: Container(
                //               width: 30,
                //               height: 20,
                //               color: Color(data['orders'][index]['color']),
                //             ),
                //           ),
                //           const Divider()
                //         ],
                //       ),
                //     ),
                //   ],
                // );
              }).toList(),
            )
                .box
                .outerShadowLg
                .white
                .margin(const EdgeInsets.only(bottom: 4))
                .make(),
            20.heightBox,
          ]),
        ),
      ),
    );
  }
}
