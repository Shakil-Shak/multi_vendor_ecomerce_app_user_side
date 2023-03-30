import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce_multi_vendor_app/consts/consts.dart';
import 'package:ecomerce_multi_vendor_app/controlers/product_controller.dart';
import 'package:ecomerce_multi_vendor_app/services/firestore_services.dart';
import 'package:ecomerce_multi_vendor_app/views/category_screen/item_details.dart';
import 'package:ecomerce_multi_vendor_app/widgets_common/bg_widgget.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../widgets_common/loading_indicator.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;
  const CategoryDetails({super.key, required this.title});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (controller.subcat.contains(title)) {
      productMethod = FirestoreServices.getSubCategoryProducts(title);
    } else {
      productMethod = FirestoreServices.getProducts(title);
    }
  }

  var controller = Get.find<ProductController>();
  dynamic productMethod;

  @override
  Widget build(BuildContext context) {
    return bgWidget2(
        child: Scaffold(
            appBar:
                AppBar(title: widget.title!.text.white.fontFamily(bold).make()),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: List.generate(
                          controller.subcat.length,
                          (index) => "${controller.subcat[index]}"
                                  .text
                                  .size(16)
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .makeCentered()
                                  .box
                                  .white
                                  .rounded
                                  .size(130, 60)
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
                                  .make()
                                  .onTap(() {
                                switchCategory("${controller.subcat[index]}");
                                setState(() {});
                              })),
                    ),
                  ),
                ),
                5.heightBox,
                StreamBuilder(
                    stream: productMethod,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Expanded(
                          child: Center(
                            child: loadingIndecator(),
                          ),
                        );
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Expanded(
                          child: "No products found!"
                              .text
                              .color(darkFontGrey)
                              .makeCentered(),
                        );
                      } else {
                        var data = snapshot.data!.docs;
                        return Container(
                            padding: EdgeInsets.all(12),
                            child: GridView.builder(
                                physics: BouncingScrollPhysics(),
                                //  physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: data.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8,
                                        mainAxisExtent: 250),
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        data[index]['p_imgs'][0],
                                        height: 160,
                                        width: 200,
                                        fit: BoxFit.contain,
                                      )
                                          .box
                                          .roundedSM
                                          .clip(Clip.antiAlias)
                                          .make(),
                                      "${data[index]['p_name']}"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .size(14)
                                          .make(),
                                      10.heightBox,
                                      "${data[index]['p_price']}"
                                          .numCurrencyWithLocale()
                                          .text
                                          .color(redColor)
                                          .fontFamily(bold)
                                          .size(16)
                                          .make()
                                    ],
                                  )
                                      .box
                                      .white
                                      .outerShadow
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 4))
                                      .roundedSM
                                      .padding(const EdgeInsets.all(12))
                                      .make()
                                      .onTap(() {
                                    controller.checkIfFav(data[index]);
                                    Get.to(ItemDetails(
                                      title: "${data[index]['p_name']}",
                                      data: data[index],
                                    ));
                                  });
                                }));
                      }
                    }),
              ],
            )));
  }
}
