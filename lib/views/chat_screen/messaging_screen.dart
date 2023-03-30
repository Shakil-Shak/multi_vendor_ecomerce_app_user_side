import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce_multi_vendor_app/consts/consts.dart';
import 'package:ecomerce_multi_vendor_app/services/firestore_services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widgets_common/loading_indicator.dart';
import 'chat_screen.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:
            "My Messages".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllMessages(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndecator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No messages found".text.color(darkFontGrey).makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Get.to(() => ChatScreen(), arguments: [
                              data[index]['friend_name'],
                              data[index]['toId']
                            ]);
                          },
                          leading: const CircleAvatar(
                            backgroundColor: redColor,
                            child: Icon(
                              Icons.person_2,
                              color: whiteColor,
                            ),
                          ),
                          title: "${data[index]['friend_name']}"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          subtitle: "${data[index]['last_msg']}".text.make(),
                        ),
                      );
                    },
                  ))
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
