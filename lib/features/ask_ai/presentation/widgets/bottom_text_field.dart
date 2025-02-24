
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pulse_max/core/env/env.dart';
import 'package:pulse_max/core/theme/app_pallete.dart';
import 'package:pulse_max/features/ask_ai/presentation/cubit/ask_ai_cubit.dart';
import 'package:pulse_max/features/ask_ai/presentation/widgets/TextFormFieldWidget.dart';

class BottomTextField extends StatefulWidget {
  const BottomTextField({super.key});

  @override
  State<BottomTextField> createState() => _BottomTextFieldState();
}

class _BottomTextFieldState extends State<BottomTextField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Expand the TextFormField to take the available width
        Expanded(
          child: TextFormFieldWidget(
            hint: 'Add Reply Here',
            controller: context.read<AskAiCubit>().controller,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {},
                child: const CircleAvatar(
                  radius: 5,
                  backgroundColor: AppColor.teal,
                  child: Icon(
                    Icons.add,
                    color: AppColor.backgroundColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        // Add horizontal space between the TextFormField and the icon
const SizedBox(width: 5,),        // Add padding around the icon if needed
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              context.read<AskAiCubit>().getMessage();
            },
            child: SvgPicture.asset(
              IconAssets.send,
              color: AppColor.teal,
            ),
          ),
        ),
      ],
    );
  }
}
