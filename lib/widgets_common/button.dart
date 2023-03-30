import 'package:ecomerce_multi_vendor_app/consts/consts.dart';

Widget Button({onPress, color, textColor,String? title}) {
  return ElevatedButton(
      style:
          ElevatedButton.styleFrom(primary: color, padding: EdgeInsets.all(12)),
      onPressed: onPress,
      child: Text(
        title!,
        style: TextStyle(color: textColor, fontFamily: bold),
      ));
}
