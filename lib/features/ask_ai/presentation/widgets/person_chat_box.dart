import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pulse_max/core/theme/app_pallete.dart';
import 'package:pulse_max/core/utils/text_style_manager.dart';

class PersonChatBox extends StatelessWidget {
  String text;
  PersonChatBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8),
          child: CircleAvatar(
            radius: 20,
            child: SvgPicture.asset(
              'assets/images/Gemini.svg',
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
        ),
        IntrinsicWidth(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width -
                  50, // Limit width for long text
            ),
            child: Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color: AppColor.lightTeal,
                  borderRadius: BorderRadius.circular(16)),
              child: Text(
                text,
                softWrap: true,
                style: getRegularStyle(
                    color: AppColor.primaryTextColor, size: AppFontSizes.s16),
              ),
            ),
          ),
        )
      ],
    );
  }
}
