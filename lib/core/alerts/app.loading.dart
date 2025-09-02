import 'package:uae_meditation_center/core/theme/app.colors.dart';
import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  final bool? isWhite;
  const AppLoading({super.key, this.isWhite});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        color: (isWhite ?? false) ? AppColors.whiteColor : AppColors.primaryColor,
         strokeWidth: 3,
      ),
    );
  }
}