import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';

import '../controllers/product_controller.dart';
import '../models/product.dart';
import '../utils/contants.dart';
import 'add_to_cart.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String? _barcode;
  final ProductController controller = Get.find();

  late bool visible;
  final productNameController = TextEditingController();
  final productPriceController = TextEditingController();
  final productQuantityController = TextEditingController();

  final style = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: const BorderSide(
      color: Constants.bgcolor,
      width: 1,
    ),
  );
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
        backgroundColor: Constants.bgcolor,
        elevation: 10,
      ),
      body: Form(
        key: _key,
        child: Center(
          // values only when widget is visible
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        VisibilityDetector(
                          onVisibilityChanged: (VisibilityInfo info) {
                            visible = info.visibleFraction > 0;
                          },
                          key: const Key('visible-detector-key'),
                          child: BarcodeKeyboardListener(
                            bufferDuration: const Duration(milliseconds: 200),
                            onBarcodeScanned: (barcode) async {
                              if (!visible) return;
                              // print(barcode);
                              bool exist =
                                  await controller.checkExisting(barcode);
                              if (exist) {
                                setState(() {
                                  _barcode = barcode;
                                });
                              }
                            },
                            useKeyDownEvent: Platform.isWindows,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  _barcode == null
                                      ? 'SCAN BARCODE'
                                      : 'BARCODE: $_barcode',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.04,
                        ),
                        const Text("Product Name"),
                        TextFormField(
                          enabled: _barcode == null ? false : true,
                          onChanged: (value) {
                            productNameController.text = value;
                          },
                          decoration: InputDecoration(
                            focusedBorder: style,
                            enabledBorder: style,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.04,
                        ),
                        const Text("Product Price"),
                        SizedBox(
                          height: Get.height * 0.04,
                        ),
                        TextFormField(
                          enabled: _barcode == null ? false : true,
                          onChanged: (value) {
                            productPriceController.text = value;
                          },
                          decoration: InputDecoration(
                            focusedBorder: style,
                            enabledBorder: style,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.04,
                        ),
                        SizedBox(
                          height: Get.height * 0.04,
                        ),
                        const Text("Product Quantity"),
                        SizedBox(
                          height: Get.height * 0.04,
                        ),
                        TextFormField(
                          enabled: _barcode == null ? false : true,
                          onChanged: (value) {
                            productQuantityController.text = value;
                          },
                          decoration: InputDecoration(
                            focusedBorder: style,
                            enabledBorder: style,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.04,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_key.currentState!.validate() &&
                                _barcode != null) {
                              final product = Product(
                                _barcode!,
                                productNameController.text,
                                int.parse(productQuantityController.text),
                                double.parse(productPriceController.text),
                              );
                              controller.addProductToDB(product);
                              if (!mounted) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Product added successfully with custom key')),
                              );
                            } else if (_barcode == null) {
                              Get.snackbar(
                                  "Error", "Please scan the product Properly");
                            }
                          },
                          child: const Text("Add Product"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Container(
                    height: Get.height * 1,
                    color: Constants.bgcolor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(Constants.image),
                        ElevatedButton(
                          onPressed: () {
                            Get.to(() => const CartScreen());
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Constants.fgcolor),
                          child: const Text(
                            "Cart Screen!",
                            style: TextStyle(
                              color: Constants.bgcolor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
