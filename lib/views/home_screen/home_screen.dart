import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce_multi_vendor_app/consts/consts.dart';
import 'package:ecomerce_multi_vendor_app/services/firestore_services.dart';
import 'package:ecomerce_multi_vendor_app/views/category_screen/item_details.dart';
import 'package:ecomerce_multi_vendor_app/views/home_screen/components/search_screen.dart';
import 'package:ecomerce_multi_vendor_app/views/profile_screen/profile_screen.dart';
import 'package:ecomerce_multi_vendor_app/widgets_common/bg_widgget.dart';
import 'package:ecomerce_multi_vendor_app/widgets_common/home_buttons.dart';
import 'package:ecomerce_multi_vendor_app/widgets_common/loading_indicator.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../consts/lists.dart';
import '../../controlers/home_controler.dart';
import '../../controlers/product_controller.dart';
import 'components/featured_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeControler>();
    var pcontroller = Get.find<ProductController>();
    return bgWidget3(
      child: Container(
        padding: const EdgeInsets.all(12),
        width: context.screenWidth,
        height: context.screenHeight,
        child: SafeArea(
            child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.searchController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        suffixIcon: Icon(Icons.search).onTap(() {
                          if (controller
                              .searchController.text.isNotEmptyAndNotNull) {
                            Get.to(() => SearchScreen(
                                  title: controller.searchController.text,
                                ));
                          }
                        }),
                        filled: true,
                        fillColor: whiteColor,
                        hintText: searchanything,
                        hintStyle: TextStyle(color: textfieldGrey)),
                  ),
                ),
                10.widthBox,
                StreamBuilder(
                  stream: FirestoreServices.getUser(currentUser!.uid),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        ),
                      );
                    } else {
                      var data = snapshot.data!.docs[0];
                      return Container(
                        child: data['imageUrl'] == ''
                            ? Image.asset(
                                imgProfile2,
                                width: 20,
                                fit: BoxFit.contain,
                              ).box.roundedFull.clip(Clip.antiAlias).make()
                            : Image.network(
                                data['imageUrl'],
                                width: 45,
                                fit: BoxFit.contain,
                              ).box.roundedFull.clip(Clip.antiAlias).make(),
                      ).box.make().onTap(() {
                        Get.to(const ProfileScreen());
                      });
                    }
                  },
                )
              ],
            ),
            // brand swiper
            10.heightBox,
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 250,
                        enableInfiniteScroll: true,
                        itemCount: brandSliderList.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            brandSliderList[index],
                            fit: BoxFit.fill,
                          )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),
                    // 10.heightBox,
                    // //deal buttons

                    // Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: List.generate(
                    //         2,
                    //         (index) => homeButtons(
                    //               height: context.screenHeight * 0.1,
                    //               width: context.screenWidth / 2.5,
                    //               icon: index == 0 ? icTodaysDeal : icFlashDeal,
                    //               title: index == 0 ? todayDeal : flashsale,
                    //             ))),
                    //2nd swiper

                    // 10.heightBox,

                    // VxSwiper.builder(
                    //     aspectRatio: 16 / 9,
                    //     autoPlay: true,
                    //     height: 150,
                    //     enableInfiniteScroll: true,
                    //     itemCount: secondSliderList.length,
                    //     itemBuilder: (context, index) {
                    //       return Image.asset(
                    //         secondSliderList[index],
                    //         fit: BoxFit.fill,
                    //       )
                    //           .box
                    //           .rounded
                    //           .clip(Clip.antiAlias)
                    //           .margin(const EdgeInsets.symmetric(horizontal: 8))
                    //           .make();
                    //     }),

                    10.heightBox,
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            3,
                            (index) => homeButtons(
                                height: context.screenHeight * 0.1,
                                width: context.screenWidth / 4.0,
                                icon: index == 0
                                    ? icTopCategories
                                    : index == 1
                                        ? icFlashDeal
                                        : icTopSeller,
                                title: index == 0
                                    ? topCategories
                                    : index == 1
                                        ? flashSale
                                        : topSellers,
                                onPress: index))),

                    // featured products
                    20.heightBox,
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: redColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            featuredProduct.text.white
                                .fontFamily(bold)
                                .size(18)
                                .make(),
                            10.heightBox,
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: FutureBuilder(
                                  future:
                                      FirestoreServices.getFeaturedProducts(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: loadingIndecator(),
                                      );
                                    } else if (snapshot.data!.docs.isEmpty) {
                                      return "No featured products"
                                          .text
                                          .white
                                          .makeCentered();
                                    } else {
                                      var featuredData = snapshot.data!.docs;
                                      return Row(
                                        children: List.generate(
                                            featuredData.length,
                                            (index) => Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Image.network(
                                                      featuredData[index]
                                                          ['p_imgs'][0],
                                                      width: 150,
                                                      height: 130,
                                                      fit: BoxFit.contain,
                                                    ),
                                                    10.heightBox,
                                                    "${featuredData[index]['p_name']}"
                                                        .text
                                                        .fontFamily(semibold)
                                                        .color(darkFontGrey)
                                                        .make(),
                                                    10.heightBox,
                                                    VxRating(
                                                      isSelectable: false,
                                                      value: double.parse(
                                                          featuredData[index]
                                                              ['p_rating']),
                                                      onRatingUpdate:
                                                          (value) {},
                                                      normalColor:
                                                          textfieldGrey,
                                                      selectionColor: golden,
                                                      count: 5,
                                                      size: 20,
                                                      maxRating: 5,
                                                    ),
                                                    10.heightBox,
                                                    "${featuredData[index]['p_price']}"
                                                        .numCurrency
                                                        .text
                                                        .color(redColor)
                                                        .fontFamily(bold)
                                                        .size(16)
                                                        .make()
                                                  ],
                                                )
                                                    .box
                                                    .white
                                                    .margin(const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 4))
                                                    .roundedSM
                                                    .padding(
                                                        const EdgeInsets.all(8))
                                                    .make()
                                                    .onTap(() {
                                                  Get.to(() => ItemDetails(
                                                        title:
                                                            "${featuredData[index]['p_name']}",
                                                        data:
                                                            featuredData[index],
                                                      ));
                                                })),
                                      );
                                    }
                                  }),
                            )
                          ]),
                    ),
                    //eatured category
                    20.heightBox,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: featuredCategories.text
                          .color(Colors.white)
                          .size(18)
                          .fontFamily(semibold)
                          .make(),
                    ),
                    20.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: List.generate(
                              3,
                              (index) => Column(
                                    children: [
                                      featuredButton(
                                          icon: featuerdList1[index],
                                          title: featuerdTitles1[index],
                                          controller: pcontroller,
                                          index: index),
                                      10.heightBox,
                                      featuredButton(
                                          icon: featuerdList2[index],
                                          title: featuerdTitles2[index],
                                          controller: pcontroller,
                                          index: index),
                                    ],
                                  ))),
                    ),
                    // 3rd swiper
                    20.heightBox,

                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        enableInfiniteScroll: true,
                        itemCount: secondSliderList.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            secondSliderList[index],
                            fit: BoxFit.fill,
                          )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),

                    //all products section
                    20.heightBox,
                    StreamBuilder(
                      stream: FirestoreServices.allproducts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return loadingIndecator();
                        } else {
                          var allproductsdata = snapshot.data!.docs;
                          return GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: allproductsdata.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                      mainAxisExtent: 300),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.network(
                                      allproductsdata[index]['p_imgs'][0],
                                      height: 130,
                                      width: 150,
                                      fit: BoxFit.contain,
                                    ),
                                    10.heightBox,
                                    "${allproductsdata[index]['p_name']}"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .size(14)
                                        .make(),
                                    10.heightBox,
                                    VxRating(
                                      isSelectable: false,
                                      value: double.parse(
                                          allproductsdata[index]['p_rating']),
                                      onRatingUpdate: (value) {},
                                      normalColor: textfieldGrey,
                                      selectionColor: golden,
                                      count: 5,
                                      size: 20,
                                      maxRating: 5,
                                    ),
                                    10.heightBox,
                                    "${allproductsdata[index]['p_price']}"
                                        .numCurrency
                                        .text
                                        .color(redColor)
                                        .fontFamily(bold)
                                        .size(16)
                                        .make(),
                                  ],
                                )
                                    .box
                                    .white
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .roundedSM
                                    .padding(const EdgeInsets.all(8))
                                    .make()
                                    .onTap(() {
                                  Get.to(() => ItemDetails(
                                        title:
                                            "${allproductsdata[index]['p_name']}",
                                        data: allproductsdata[index],
                                      ));
                                });
                              });
                        }
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
