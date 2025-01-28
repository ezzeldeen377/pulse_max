import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_max/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:pulse_max/core/di/di.dart';
import 'package:pulse_max/core/routes/routes.dart';
import 'package:pulse_max/core/screens/home_screen/home_screen.dart';
import 'package:pulse_max/features/authentication/presentation/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:pulse_max/features/authentication/presentation/cubits/sign_up_cubit/sign_up_cubit.dart';
import 'package:pulse_max/features/authentication/presentation/screens/on_boarding_screen.dart';
import 'package:pulse_max/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:pulse_max/features/authentication/presentation/screens/sign_up_screen.dart';
import 'package:pulse_max/features/doctor/domain/entities/doctor.dart';
import 'package:pulse_max/features/doctor/presentation/providers/doctors_cubit.dart';
import 'package:pulse_max/features/doctor/presentation/screens/doctor_details_screen.dart';
import 'package:pulse_max/features/doctor/presentation/screens/doctors_screen.dart';
import 'package:pulse_max/features/measurement/presentation/pages/measurement_page.dart';
import 'package:pulse_max/features/message/data/models/chat_model.dart';
import 'package:pulse_max/features/message/presentation/cubits/chats_cubit.dart';
import 'package:pulse_max/features/message/presentation/screens/chat_screen.dart';
import 'package:pulse_max/features/message/presentation/screens/user_chats_screen.dart';

class PulseMaxRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.onboarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
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
      case RouteNames.home:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<DoctorsCubit>()..getDoctorss(),
                  child: const HomeScreen(),
                ));
      case RouteNames.doctorsScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<DoctorsCubit>()..getDoctorss(),
                  child: const DoctorsScreen(),
                ));
      case RouteNames.doctorDetails:
        final args = settings.arguments as Doctor;
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
              final args=settings.arguments as ChatModel;
              return  getIt<ChatsCubit>()..listOnChatMessages(args.id!);},
            child: ChatScreen(chat: args),
          ),
        );
      case RouteNames.userChats:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => getIt<ChatsCubit>()
                    ..getChats(context.read<AppUserCubit>().state.user!.uid),
                  child: const UserChatsScreen(),
                ));
      case RouteNames.measurement:
        return MaterialPageRoute(
            builder: (context) => const MeasurementPage());
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
