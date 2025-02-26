import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_max/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:pulse_max/core/di/di.dart';
import 'package:pulse_max/core/routes/routes.dart';
import 'package:pulse_max/features/alarm/presentation/cubit/medicine_cubit.dart';
import 'package:pulse_max/features/alarm/presentation/pages/alarm_page.dart';
import 'package:pulse_max/features/ask_ai/presentation/cubit/ask_ai_cubit.dart';
import 'package:pulse_max/features/ask_ai/presentation/ui/ask_ai_screen.dart';
import 'package:pulse_max/features/home/presentation/pages/home_screen.dart';
import 'package:pulse_max/core/screens/initial_screen.dart';
import 'package:pulse_max/features/authentication/presentation/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:pulse_max/features/authentication/presentation/cubits/sign_up_cubit/sign_up_cubit.dart';
import 'package:pulse_max/features/authentication/presentation/screens/on_boarding_screen.dart';
import 'package:pulse_max/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:pulse_max/features/authentication/presentation/screens/sign_up_screen.dart';
import 'package:pulse_max/features/doctor/data/models/doctor.dart';
import 'package:pulse_max/features/doctor/presentation/bloc/bloc/edit_doctor_bloc.dart';
import 'package:pulse_max/features/doctor/presentation/bloc/doctors/doctors_cubit.dart';
import 'package:pulse_max/features/doctor/presentation/screens/doctor_details_screen.dart';
import 'package:pulse_max/features/doctor/presentation/screens/doctors_screen.dart';
import 'package:pulse_max/features/doctor/presentation/screens/edit_doctor_details.dart';
import 'package:pulse_max/features/measurement/presentation/pages/measurement_page.dart';
import 'package:pulse_max/features/message/data/models/chat_model.dart';
import 'package:pulse_max/features/message/presentation/cubits/chats_cubit.dart';
import 'package:pulse_max/features/message/presentation/screens/chat_screen.dart';
import 'package:pulse_max/features/message/presentation/screens/user_chats_screen.dart';

class PulseMaxRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case RouteNames.signIn:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<SignInCubit>(),
                  child: const SignInScreen(),
                ));
      case RouteNames.signUp:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<SignUpCubit>(),
                  child: const SignUpScreen(),
                ));

      case RouteNames.doctorsScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<DoctorsCubit>()..getDoctorss((settings.arguments as String?)),
                  child:  DoctorsScreen(startCategory: settings.arguments as String?,),
                ));
      case RouteNames.doctorDetails:
        final args = settings.arguments as DoctorModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<DoctorsCubit>(),
            child: DoctorDetailsScreen(doctor: args),
          ),
        );
      case RouteNames.chatScreen:
        final args = settings.arguments as ChatModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final args = settings.arguments as ChatModel;
              return getIt<ChatsCubit>()..listOnChatMessages(args.id!);
            },
            child: ChatScreen(chat: args),
          ),
        );
      case RouteNames.userChats:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => getIt<ChatsCubit>()
                    ..getChats(context.read<AppUserCubit>().state.user!.uid!),
                  child: const UserChatsScreen(),
                ));
      case RouteNames.measurement:
        return MaterialPageRoute(builder: (context) =>  MeasurementPage());
      case RouteNames.initial:
        return MaterialPageRoute(builder: (context) => const InitialScreen());
      case RouteNames.editDoctor:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => getIt<DoctorBloc>()..initState(settings.arguments as DoctorModel),
                  child: const EditProfileScreen(),
                ));
      case RouteNames.alarm:
        return MaterialPageRoute(
            builder: (context) =>  BlocProvider(
  create: (context) => getIt<MedicineCubit>()..getMedicines(),
  child: const AlarmPage(),
));
      case RouteNames.askAi:
        return MaterialPageRoute(
            builder: (context) =>  BlocProvider(
  create: (context) => getIt<AskAiCubit>(),
  child: const AskAiScreen(),
));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
