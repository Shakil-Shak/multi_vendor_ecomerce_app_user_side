import 'package:ecomerce_multi_vendor_app/consts/consts.dart';
import 'package:ecomerce_multi_vendor_app/views/category_screen/category_details.dart';
import 'package:get/get.dart';

import '../../../consts/lists.dart';

Widget featuredButton({String? title, icon,controller,index}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 60,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      Expanded(
        child: title!.text
            .overflow(TextOverflow.fade)
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      )
    ],
  )
      .box
      .width(200)
      .white
      .margin(EdgeInsets.symmetric(horizontal: 4))
      .padding(const EdgeInsets.all(4))
      .roundedSM
      .outerShadowSm
      .make()
      .onTap(() {
         controller.getSubCategories(categoriesList[index]);
    Get.to(() => CategoryDetails(title: title));
  });
}
