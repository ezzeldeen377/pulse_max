
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pulse_max/core/theme/app_pallete.dart';
import 'package:pulse_max/core/utils/text_style_manager.dart';

class ImageNameRow extends StatelessWidget {
  String name;
  String imagePath;
  ImageNameRow({super.key, required this.name, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          child: SvgPicture.asset(
            imagePath,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(width: 10,),
        Text(
          name,
          style:
              getBoldStyle(color: AppColor.backgroundColor, size: AppFontSizes.s18),
        )
      ],
    );
  }
}
