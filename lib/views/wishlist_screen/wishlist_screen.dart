import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce_multi_vendor_app/consts/consts.dart';
import 'package:ecomerce_multi_vendor_app/services/firestore_services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../widgets_common/loading_indicator.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            "My Wishlists".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getWishlists(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndecator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No wishlist found".text.color(darkFontGrey).makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Image.network(
                          "${data[index]['p_imgs'][0]}",
                          width: 100,
                          fit: BoxFit.fill,
                        ),
                        title: "${data[index]['p_name']}"
                            .text
                            .fontFamily(semibold)
                            .size(16)
                            .make(),
                        subtitle: "${data[index]['p_price']}"
                            .numCurrency
                            .text
                            .fontFamily(semibold)
                            .color(redColor)
                            .make(),
                        trailing: const Icon(
                          Icons.favorite,
                          color: redColor,
                        ).onTap(() async {
                          await firestore
                              .collection(prouductsCollection)
                              .doc(data[index].id)
                              .set({
                            'p_wishlist':
                                FieldValue.arrayRemove([currentUser!.uid])
                          }, SetOptions(merge: true));
                        }),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
