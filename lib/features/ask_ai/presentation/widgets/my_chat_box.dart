
import 'package:flutter/material.dart';
import 'package:pulse_max/core/theme/app_pallete.dart';
import 'package:pulse_max/core/utils/text_style_manager.dart';

class MyChatBox extends StatelessWidget {
  String text;
  MyChatBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IntrinsicWidth(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
            child: Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 18, vertical: 5),
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical:10),
              decoration: BoxDecoration(
                  gradient: AppColor.chatGradient,
                  borderRadius: BorderRadius.circular(16)),
              child: Text(
                text,
                style: getRegularStyle(
                    color: AppColor.backgroundColor, size: AppFontSizes.s16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
