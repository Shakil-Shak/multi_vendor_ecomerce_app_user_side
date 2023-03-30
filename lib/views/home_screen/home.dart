import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce_multi_vendor_app/consts/consts.dart';
import 'package:ecomerce_multi_vendor_app/controlers/home_controler.dart';
import 'package:ecomerce_multi_vendor_app/services/firestore_services.dart';
import 'package:ecomerce_multi_vendor_app/views/chat_screen/messaging_screen.dart';
import 'package:ecomerce_multi_vendor_app/widgets_common/exit_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../controlers/product_controller.dart';
import '../cart_screen/cart_screen.dart';
import '../category_screen/category_screen.dart';
import '../profile_screen/profile_screen.dart';
import 'home_screen.dart';
import 'package:badges/badges.dart' as badges;

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeControler());
    var pcontroller = Get.put(ProductController());

    var navBarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 26,
          ),
          label: home),
      BottomNavigationBarItem(
          icon: Image.asset(
            icChat,
            width: 26,
          ),
          label: message),
      // BottomNavigationBarItem(
      //     icon: Image.asset(
      //       icCart,
      //       width: 26,
      //     ),
      //     label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
          ),
          label: account),
    ];

    var navBody = [
      HomeScreen(),
      MessagesScreen(),
      //CartScreen(),
      ProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        floatingActionButton: badges.Badge(
          badgeContent: StreamBuilder(
            stream: FirestoreServices.getCartCount(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Container();
              } else {
                var orderdata = snapshot.data!.docs;
                return Text("${orderdata.length}");
              }
            },
          ),
          child: FloatingActionButton.extended(
            label: cart.text.color(redColor).make(),
            backgroundColor: Color.fromARGB(255, 250, 239, 138),
            icon: const ImageIcon(
              AssetImage(icCart),
              color: redColor,
            ),
            onPressed: () {
              Get.to(const CartScreen());
            },
          ),
        ),
        body: Column(
          children: [
            Obx(() => Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value)))
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: redColor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            type: BottomNavigationBarType.fixed,
            backgroundColor: whiteColor,
            items: navBarItem,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}
