import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce_multi_vendor_app/consts/consts.dart';
import 'package:ecomerce_multi_vendor_app/services/firestore_services.dart';
import 'package:ecomerce_multi_vendor_app/widgets_common/loading_indicator.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../category_screen/item_details.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder(
          future: FirestoreServices.searchProducts(title),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndecator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No products found".text.makeCentered();
            } else {
              var data = snapshot.data!.docs;
              var filtered = data
                  .where(
                    (element) => element['p_name']
                        .toString()
                        .toLowerCase()
                        .contains(title!.toLowerCase()),
                  )
                  .toList();
              return GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    mainAxisExtent: 300),
                children: filtered
                    .mapIndexed((currentValue, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: Image.network(
                                filtered[index]['p_imgs'][0],
                                height: 200,
                                width: 200,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const Spacer(),
                            "${filtered[index]['p_name']}"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .size(14)
                                .make(),
                            10.heightBox,
                            VxRating(
                              isSelectable: false,
                              value: double.parse(filtered[index]['p_rating']),
                              onRatingUpdate: (value) {},
                              normalColor: textfieldGrey,
                              selectionColor: golden,
                              count: 5,
                              size: 20,
                              maxRating: 5,
                            ),
                            10.heightBox,
                            "\$${filtered[index]['p_price']}"
                                .text
                                .color(redColor)
                                .fontFamily(bold)
                                .size(16)
                                .make(),
                          ],
                        )
                            .box
                            .white
                            .shadow
                            .margin(const EdgeInsets.symmetric(horizontal: 4))
                            .roundedSM
                            .padding(const EdgeInsets.all(12))
                            .make()
                            .onTap(() {
                          Get.to(() => ItemDetails(
                                title: "${filtered[index]['p_name']}",
                                data: filtered[index],
                              ));
                        }))
                    .toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
