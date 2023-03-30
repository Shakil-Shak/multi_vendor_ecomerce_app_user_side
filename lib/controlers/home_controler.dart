import 'package:ecomerce_multi_vendor_app/consts/consts.dart';
import 'package:get/get.dart';

class HomeControler extends GetxController {
  @override
  void onInit() {
    getUsername();
    // getCartCount();
    super.onInit();
  }
  

  var currentNavIndex = 0.obs;

  var username = '';
  // var cartCount = ''.obs;

  var searchController = TextEditingController();

  getUsername() async {
    var n = await firestore
        .collection(userCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });
    username = n;
  }

  // getCartCount() async {
  //   var count = await firestore
  //       .collection(cartCollection)
  //       .where('added_by', isEqualTo: currentUser!.uid)
  //       .get()
  //       .then((value) {
  //     return value.docs.length;
  //   });
  //   cartCount.value = count.toString();
  // }
}
