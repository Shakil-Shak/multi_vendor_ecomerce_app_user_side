import 'package:ecomerce_multi_vendor_app/consts/consts.dart';

Widget bgWidget({Widget? child}) {
  return Container(
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(imgBackground), fit: BoxFit.cover, opacity: 0.8)),
    child: child,
  );
}

Widget bgWidget2({Widget? child}) {
  return Container(
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(imgBackground2),
            fit: BoxFit.cover,
            opacity: 0.8)),
    child: child,
  );
}

Widget bgWidget3({Widget? child}) {
  return Container(
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(imgBackground3),
            fit: BoxFit.cover,
            opacity: 0.8)),
    child: child,
  );
}
