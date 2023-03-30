import 'package:ecomerce_multi_vendor_app/consts/consts.dart';

Widget loadingIndecator() {
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redColor),
  );
}
