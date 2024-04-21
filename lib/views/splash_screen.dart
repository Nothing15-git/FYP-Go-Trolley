import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_trolley/utils/contants.dart';
import 'package:go_trolley/views/name_screen.dart';

import '../controllers/product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.bgcolor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Image.asset('assets/images/logo.png'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(() => NameScreen());
            },
            style: ElevatedButton.styleFrom(backgroundColor: Constants.fgcolor),
            child: const Text(
              "Let's Start",
              style: TextStyle(
                color: Constants.bgcolor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
