import 'package:ecomerce_multi_vendor_app/consts/consts.dart';

// user data
class FirestoreServices {
  static getUser(uid) {
    return firestore
        .collection(userCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  // get products accroding to category
  static getProducts(category) {
    return firestore
        .collection(prouductsCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  static getSubCategoryProducts(title) {
    return firestore
        .collection(prouductsCollection)
        .where('p_subcategory', isEqualTo: title)
        .snapshots();
  }

  // get cart
  static getCart(uid) {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  // delete doc
  static deleteDocument(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  // get chat
  static getChatMessages(docId) {
    return firestore
        .collection(chatCollection)
        .doc(docId)
        .collection(messageCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  static getAllOrders() {
    return firestore
        .collection(ordersCollection)
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getWishlists() {
    return firestore
        .collection(prouductsCollection)
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getAllMessages() {
    return firestore
        .collection(chatCollection)
        .where('fromId', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  // static getCartCount() {
  //   firestore
  //       .collection(cartCollection)
  //       .where('added_by', isEqualTo: currentUser!.uid)
  //       .get()
  //       .then((value) {
  //     return value.docs.length;
  //   });
  // }
   static getCartCount(uid) {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  static getCounts() async {
    var res = await Future.wait([
      firestore
          .collection(cartCollection)
          .where('added_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(prouductsCollection)
          .where('p_wishlist', arrayContains: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(ordersCollection)
          .where('order_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      })
    ]);
    return res;
  }

  static allproducts() {
    return firestore.collection(prouductsCollection).snapshots();
  }

  static getFeaturedProducts() {
    return firestore
        .collection(prouductsCollection)
        .where('is_featured', isEqualTo: true)
        .get();
  }

  static searchProducts(title) {
    return firestore.collection(prouductsCollection).get();
  }
}
