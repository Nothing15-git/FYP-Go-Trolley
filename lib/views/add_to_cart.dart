import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:get/get.dart';
import 'package:go_trolley/views/password_screen.dart';
import 'package:qr_bar_code/qr/qr.dart';

import '../controllers/product_controller.dart';
import '../utils/contants.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ProductController productController = Get.find();
  String? barcode;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(children: [
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height * 0.1),
                  Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.018),
                    child: Text(
                      "Hi ${productController.nameController.text}! Welcome to Go Trolley",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: Get.height * 0.06),
                    ),
                  ),
                  Divider(
                    thickness: Get.height * 0.01,
                  ),
                  BarcodeKeyboardListener(
                    bufferDuration: const Duration(milliseconds: 220),
                    onBarcodeScanned: (barcode) {
                      productController.getProductByBarcode(barcode);
                      setState(() {
                        barcode = barcode;
                      });
                    },
                    useKeyDownEvent: Platform.isAndroid,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(),
                      ],
                    ),
                  ),
                  Obx(
                    () => SizedBox(
                      height: Get.height * 0.75,
                      child: ListView.builder(
                          itemCount:
                              productController.cartProducts.value.length,
                          itemBuilder: (item, index) {
                            final product =
                                productController.cartProducts.value[index];
                            return Column(
                              children: [
                                ListTile(
                                  title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(product.name),
                                        Text('    |   Price:${product.price}'),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: Get.width * 0.01,
                                            ),
                                            Text(product.quantity.toString()),
                                            SizedBox(
                                              width: Get.width * 0.01,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                productController
                                                    .decreaseQuantity(index);
                                                setState(() {});
                                              },
                                              child: Container(
                                                width: Get.width * 0.02,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                child: const Center(
                                                    child: Text("-")),
                                              ),
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.01,
                                            ),
                                            Text(
                                                '${product.price * product.quantity} Rs.'),
                                            SizedBox(
                                              width: Get.width * 0.03,
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                productController
                                                    .removeProduct(index);
                                                setState(() {});
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red),
                                              child: const Text("Delete"),
                                            ),
                                          ],
                                        ),
                                      ]),
                                ),
                                const Divider(
                                  thickness: 2,
                                ),
                              ],
                            );
                          }),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: Get.width * 0.27,
            child: Container(
              height: Get.height * 1,
              color: Constants.bgcolor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height * 0.1),
                  Image.asset(Constants.image),
                  SizedBox(height: Get.height * 0.1),
                  Text(
                    "Your Total Bill",
                    style: TextStyle(
                      color: Constants.fgcolor,
                      fontWeight: FontWeight.w400,
                      fontSize: Get.height * 0.04,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.03),
                  Obx(
                    () => Text(
                      "${productController.total} Rs.",
                      style: TextStyle(
                        color: Constants.fgcolor,
                        fontWeight: FontWeight.w400,
                        fontSize: Get.height * 0.04,
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.03),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Constants.fgcolor),
                      onPressed: () {
                        Get.snackbar("Warning", "Got to cashier First",
                            backgroundColor: Constants.bgcolor,
                            colorText: Constants.fgcolor);

                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            content: SizedBox(
                              // height: Get.height * 0.4,
                              width: 345,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(
                                          top: 17, bottom: 12),
                                      child: QRCode(
                                        size: Get.height * 0.5,
                                        data: productController.getProducts(),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "Checkout Now!",
                        style: TextStyle(
                          color: Constants.bgcolor,
                        ),
                      )),
                  SizedBox(height: Get.height * 0.03),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Constants.fgcolor),
                      onPressed: () {
                        Get.to(() => const PassWordScreen());
                      },
                      child: const Text(
                        "Add Products",
                        style: TextStyle(
                          color: Constants.bgcolor,
                        ),
                      )),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
