import 'package:ecomerce_multi_vendor_app/consts/consts.dart';
import 'package:ecomerce_multi_vendor_app/controlers/cart_controller.dart';
import 'package:ecomerce_multi_vendor_app/views/cart_screen/payment_method.dart';
import 'package:ecomerce_multi_vendor_app/widgets_common/button.dart';
import 'package:ecomerce_multi_vendor_app/widgets_common/custom_textfield.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: SizedBox(
          height: 50,
          child: Button(
              title: "Continue",
              textColor: whiteColor,
              color: redColor,
              onPress: () {
                if (controller.addressController.text.length > 10 &&
                    controller.cityController.text.isNotEmpty &&
                    controller.stateController.text.isNotEmpty &&
                    controller.postalcodeController.text.isNotEmpty &&
                    controller.phoneController.text.length == 11) {
                  Get.to(() => PaymentMethods());
                } else {
                  VxToast.show(context, msg: "Please fill all feild");
                }
              }),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextfield(
                hint: "Address",
                isPass: false,
                title: "Address",
                controller: controller.addressController),
            customTextfield(
                hint: "City",
                isPass: false,
                title: "City",
                controller: controller.cityController),
            customTextfield(
                hint: "State",
                isPass: false,
                title: "State",
                controller: controller.stateController),
            customTextfield(
                hint: "Postal Code",
                isPass: false,
                title: "Postal Code",
                controller: controller.postalcodeController),
            customTextfield(
                hint: "Phone",
                isPass: false,
                title: "Phone",
                controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}
