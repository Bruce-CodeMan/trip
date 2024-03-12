import 'package:flutter/material.dart';

Widget shadowWrap({required Widget child, EdgeInsetsGeometry? padding}) {
  return Container(
    padding: padding,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
          colors: [Color(0x66000000), Colors.transparent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
      ),
    ),
    child: child,
  );
}