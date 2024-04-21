import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_trolley/views/add_product_screen.dart';

import '../utils/contants.dart';

class PassWordScreen extends StatefulWidget {
  const PassWordScreen({super.key});

  @override
  State<PassWordScreen> createState() => _PassWordScreenState();
}

class _PassWordScreenState extends State<PassWordScreen> {
  final currentPasswordController = TextEditingController();
  final key = GlobalKey<FormState>();
  bool passVisibility = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Password"),
        backgroundColor: Constants.bgcolor,
        elevation: 10,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Get.width * 0.04),
          child: SafeArea(
            child: Form(
              key: key,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFormField(
                      controller: currentPasswordController,
                      obscureText: passVisibility,
                      decoration: fieldStyle.copyWith(
                        hintText: "Enter Password",
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              passVisibility = !passVisibility;
                            });
                          },
                          icon: Icon(passVisibility
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                      validator: (val) {
                        if (val == null) {
                          return 'password is required';
                        } else if (val.length < 6) {
                          return 'Please Enter a Valid Password';
                        } else if (currentPasswordController.text.trim() !=
                            adminPassword) {
                          return "password is incorrect";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: Get.height * 0.1),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Constants.bgcolor),
                      onPressed: () {
                        if (key.currentState!.validate()) {
                          Get.back();
                          Get.to(() => const AddProductScreen());
                        }
                      },
                      child: const Text("Open Products DB"),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
