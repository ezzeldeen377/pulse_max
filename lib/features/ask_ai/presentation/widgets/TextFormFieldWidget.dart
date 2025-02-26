
import 'package:flutter/material.dart';
import 'package:pulse_max/core/theme/app_pallete.dart';
import 'package:pulse_max/core/utils/text_style_manager.dart';

typedef MyValidator = String? Function(String?);

class TextFormFieldWidget extends StatefulWidget {
  String hint;
  Widget? suffixIcon;
  Widget? prefixIcon;
  bool? obscureText;
  MyValidator? validator;
  TextEditingController controller;
  bool show;
  ImageIcon? SuffixIconShowed;
  TextFormFieldWidget(
      {required this.hint,
      this.suffixIcon,
      this.obscureText,
      this.validator,
      this.show = false,
      this.SuffixIconShowed,
      this.prefixIcon,
      required this.controller});

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText ?? false,
      validator: widget.validator,
      style:
          getRegularStyle(color: AppColor.backgroundColor, size: AppFontSizes.s14),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal:10),
        suffixIcon: widget.suffixIcon,
        hintText: widget.hint,
        hintStyle: getLightStyle(
            color: AppColor.backgroundColor.withOpacity(.5),
            size: AppFontSizes.s14),
        filled: true,
        fillColor: Colors.grey,
        prefixIcon: widget.prefixIcon,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.teal,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
