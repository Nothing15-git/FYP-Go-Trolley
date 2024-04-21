import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_trolley/controllers/product_controller.dart';
import 'package:go_trolley/views/add_to_cart.dart';

import '../utils/contants.dart';

class NameScreen extends StatelessWidget {
  NameScreen({super.key});
  final _key = GlobalKey<FormState>();
  final productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Your Name to Get Started"),
        backgroundColor: Constants.bgcolor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Get.width * 0.04),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Form(
                key: _key,
                child: TextFormField(
                  decoration: fieldStyle.copyWith(hintText: "Name "),
                  controller: productController.nameController,
                  onChanged: (value) {
                    productController.nameController.text = value;
                  },
                )),
            SizedBox(height: Get.height * 0.1),
            ElevatedButton(
              onPressed: () {
                Get.back();
                Get.to(() => const CartScreen());
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Constants.bgcolor),
              child: const Text(
                "Start Shopping",
                style: TextStyle(
                  color: Constants.fgcolor,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
