import 'package:flutter/material.dart';

const adminPassword = '123456';

class Constants {
  static const bgcolor = Color.fromRGBO(20, 70, 155, 1);
  static const fgcolor = Colors.white;
  static const image = 'assets/images/logo.png';
  // static const buttonBorder = OutlineInputBorder(
  //   borderRadius: BorderRadius.circular(5),
  //   borderSide: BorderSide(
  //     color: Colors.black,
  //     width: 1,
  //   ),
  // );
}

final fieldStyle = InputDecoration(
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Color(0xffBFBFBF), width: 1),
    borderRadius: BorderRadius.circular(5),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Color(0xffBFBFBF), width: 1),
    borderRadius: BorderRadius.circular(5),
  ),
  disabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Color(0xffBFBFBF), width: 1),
    borderRadius: BorderRadius.circular(5),
  ),
  labelStyle: const TextStyle(color: Constants.bgcolor),
);
