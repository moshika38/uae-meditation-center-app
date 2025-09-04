import 'package:flutter/material.dart';
import 'package:uae_meditation_center/core/theme/app.colors.dart';

class AppInput extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final TextEditingController? controller;
  final Function()? onTapIcon;
  final bool? obscureText;
  final bool hasError;  

  const AppInput({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.suffixIcon,
    this.controller,
    this.obscureText,
    this.onTapIcon,
    this.hasError = false,  
  });

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText ?? false,
        style: Theme.of(context).textTheme.bodySmall,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.whiteColor,
          prefixIcon: Icon(
            widget.hasError?Icons.error: widget.prefixIcon, 
            color:widget.hasError?Colors.red: AppColors.textColor,
            size: 20,
          ),
          suffixIcon: GestureDetector(
            onTap: widget.onTapIcon,
            child: Icon(
              widget.suffixIcon,
              color: AppColors.gray,
              size: 20,
            ),
          ),
          hintText: widget.hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(
                color: widget.hasError ? Colors.red : AppColors.gray,
              ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(
              color: widget.hasError ? Colors.red : AppColors.primaryColor,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(
              color: widget.hasError ? Colors.red : AppColors.primaryColor,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}

