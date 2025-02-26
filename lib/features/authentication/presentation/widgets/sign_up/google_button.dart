import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pulse_max/core/theme/app_pallete.dart';


import '../../../../../core/theme/style.dart';

class GoogleButton extends StatelessWidget {
  final void Function()? onTapButton;
  const GoogleButton({super.key, required this.onTapButton});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapButton,
      child: Container(
        height: 45.h,
        width: 305.w,
        decoration: BoxDecoration(
          color: AppPallete.whiteColor,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/google.svg'),
            SizedBox(width: 3.w),
            Text("Connect with Google",
                style: TextStyles.font14RobotoDarkGreenColorMedium),
          ],
        ),
      ),
    );
  }
}
