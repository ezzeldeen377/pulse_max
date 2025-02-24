
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pulse_max/core/env/env.dart';
import 'package:pulse_max/core/theme/app_pallete.dart';
import 'package:pulse_max/features/ask_ai/presentation/cubit/ask_ai_cubit.dart';
import 'package:pulse_max/features/ask_ai/presentation/widgets/bottom_text_field.dart';
import 'package:pulse_max/features/ask_ai/presentation/widgets/image_name_row.dart';
import 'package:pulse_max/features/ask_ai/presentation/widgets/my_chat_box.dart';
import 'package:pulse_max/features/ask_ai/presentation/widgets/person_chat_box.dart';

class AskAiScreen extends StatelessWidget {
  const AskAiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColor.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColor.teal,
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
          title: ImageNameRow(name: 'Gemini', imagePath: ImageAssets.gemini),
      
        ),  
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: BlocBuilder<AskAiCubit, AskAiState>(
            builder: (context, state) {
              return Column(
                children: [
                  // Expanded to ensure chat content is scrollable and takes remaining space
                  Expanded(
                    child: ListView(
                        children:
                           context.read<AskAiCubit>().chats.map((object) {
                      return object.state == 'send'
                          ? MyChatBox(text: object.message)
                          : PersonChatBox(text: object.message);
                    }).toList()),
                  ),
                  // Bottom TextField remains at the bottom, not part of scrollable content
                   Container(color: AppColor.teal.withOpacity(.2),
                    padding: const EdgeInsets.all(8.0),
                    child: const BottomTextField(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
