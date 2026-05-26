import 'package:flutter/material.dart';

class AppImage {
  AppImage._();

  static Widget logo({
    Key? key,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
  }) {
    return Image.asset(
      'assets/images/logo.png',
      key: key,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
    );
  }
}