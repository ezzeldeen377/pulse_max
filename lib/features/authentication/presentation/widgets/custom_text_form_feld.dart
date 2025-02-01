import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulse_max/core/theme/style.dart';

import '../../../../core/theme/app_pallete.dart';

class CustomTextFormFeld extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText ;
  final Widget? suffixIcon;
  final String? hintText;
  const CustomTextFormFeld({
    super.key,
    required this.controller,
     this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.hintText,
    
    });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
          controller: controller,
          style:TextStyles.font17RobotoAccentBlackColor2Regular,
          cursorColor: AppColor.teal,
          validator: validator,
          keyboardType:keyboardType ,
          obscureText: obscureText,
          decoration: InputDecoration(
             filled: true,
            fillColor: Colors.white,
            label:Text(hintText??''),
            labelStyle: TextStyles.font17RobotoAccentBlackColor2Regular,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: const BorderSide(width: 0, color: AppPallete.mediumGrayColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: const BorderSide(width: 0, color: AppPallete.mediumGrayColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: const BorderSide(width: 1, color: AppColor.teal),
            ),
            )
         );
  }
}