import 'package:ecomerce_multi_vendor_app/consts/consts.dart';

Widget detailsCard({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).color(darkFontGrey).size(17).make(),
      5.heightBox,
      title!.text.color(darkFontGrey).make()
    ],
  ).box.rounded.height(70).width(width).padding(const EdgeInsets.all(4)).make();
}
