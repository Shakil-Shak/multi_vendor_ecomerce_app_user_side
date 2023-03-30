import 'package:ecomerce_multi_vendor_app/consts/consts.dart';

Widget orderStatus({icon, color, title, showDone}) {
  return ListTile(
    leading: Image.asset(
      icon,
      color: color,
    ).box.border(color: color).rounded.padding(EdgeInsets.all(4)).make(),
    title: "$title".text.color(darkFontGrey).makeCentered(),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          showDone
              ? const Icon(
                  Icons.done,
                  color: redColor,
                )
              : Container()
        ],
      ),
    ),
  );
}
