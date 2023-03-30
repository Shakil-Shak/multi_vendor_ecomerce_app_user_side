import 'package:ecomerce_multi_vendor_app/consts/consts.dart';
import 'package:ecomerce_multi_vendor_app/widgets_common/button.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
      const Divider(),
      10.heightBox,
      "Are you want to exit".text.size(16).color(darkFontGrey).make(),
      10.heightBox,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Button(
              color: redColor,
              onPress: () {
                SystemNavigator.pop();
              },
              textColor: whiteColor,
              title: "Yes"),
          Button(
              color: redColor,
              onPress: () {
                Navigator.pop(context);
              },
              textColor: whiteColor,
              title: "No"),
        ],
      )
    ]).box.color(lightGrey).padding(const EdgeInsets.all(12)).rounded.make(),
  );
}
