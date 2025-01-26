import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:pulse_max/core/di/di.dart';
import 'package:pulse_max/core/screens/home_screen/home_screen.dart';
import 'package:pulse_max/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:pulse_max/features/auth/presentation/pages/login_page.dart';
import 'package:pulse_max/features/doctor/domain/entities/doctor.dart';
import 'package:pulse_max/features/doctor/presentation/providers/doctors_cubit.dart';
import 'package:pulse_max/features/doctor/presentation/screens/doctor_details_screen.dart';
import 'package:pulse_max/features/doctor/presentation/screens/doctors_screen.dart';
import 'package:pulse_max/features/message/data/models/chat_model.dart';
import 'package:pulse_max/features/message/presentation/cubits/chats_cubit.dart';
import 'package:pulse_max/features/message/presentation/screens/chat_screen.dart';
import 'package:pulse_max/features/message/presentation/screens/user_chats_screen.dart';

final routerConfig = GoRouter(
  routes: [
    GoRoute(
      path: DoctorsScreen.routeName,
      builder: (context, state) => BlocProvider(
          create: (context) => getIt<DoctorsCubit>(),
          child: const DoctorsScreen()),
    ),
    GoRoute(
      path: HomeScreen.routeName,
      builder: (context, state) => BlocProvider(
          create: (context) => getIt<DoctorsCubit>(),
          child: const HomeScreen()),
    ),
    GoRoute(
      path: UserChatsScreen.routeName,
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<ChatsCubit>()..getChats(),
        child: const UserChatsScreen(),
      ),
    ),
    GoRoute(
      path: LoginPage.routeName,
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: LoginPage(),
      ),
    ),
    GoRoute(
      path: DoctorDetailsScreen.routeName,
      builder: (context, state) {
        final doctor = state.extra! as Doctor;
        return BlocProvider(
          create: (context) => getIt<DoctorsCubit>(),
          child: DoctorDetailsScreen(
            doctor: doctor,
          ),
        );
      },
    ),
    GoRoute(
      path: ChatScreen.routeName,
      builder: (context, state) {
        final chat = state.extra! as ChatModel;
        return BlocProvider(
          create: (context) =>
              getIt<ChatsCubit>()..listOnChatMessages(chat.id!),
          child: ChatScreen(
            chat: chat,
          ),
        );
      },
    )
  ],
  initialLocation: HomeScreen.routeName,
);
