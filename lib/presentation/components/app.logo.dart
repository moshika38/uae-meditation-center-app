import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double? width;
  final double? height;
  const AppLogo({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/logo/logo.png",
      width: width ?? 120,
      height: height ?? 120,
    );
  }
}
