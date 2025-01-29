import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_max/core/common/cubit/app_user/app_user_state.dart';
import 'package:pulse_max/core/routes/router_genrator.dart';
import 'package:pulse_max/core/screens/initial_screen.dart';
import 'package:pulse_max/core/theme/app_pallete.dart';
import 'package:pulse_max/core/utils/show_snack_bar.dart';
import 'package:pulse_max/features/authentication/presentation/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:pulse_max/features/authentication/presentation/screens/on_boarding_screen.dart';
import 'core/common/cubit/app_user/app_user_cubit.dart';
import 'core/di/di.dart';
import 'features/authentication/presentation/screens/sign_in_screen.dart';

class CustomMainBlocConsumer extends StatelessWidget {
  const CustomMainBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    final appUserCubit = context.read<AppUserCubit>();

    return BlocConsumer<AppUserCubit, AppUserState>(
      listener: (context, state) async {
        if (state.isInstalled()) {
          appUserCubit.isUserLoggedIn();
        } else if (state.isLoggedIn()) {
          await appUserCubit.getUser(uid: state.user!.uid!);
        } else if (state.isGettedData()) {
          appUserCubit.saveUserData(state.user!);
        } else if (state.isFailureSaveData()) {
          showSnackBar(context, state.errorMessage ?? "UnExpected error");
          appUserCubit.signOut();
        } else if (state.isFailure()) {
          showSnackBar(context, state.errorMessage ?? "UnExpected error");
        } else if (state.isSignOut()) {
          appUserCubit.clearUserData();
        } else if (state.isClearUserData()) {
          appUserCubit.isUserLoggedIn();
        }
      },
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          onGenerateRoute: PulseMaxRouter.generateRoute,
          home: _buildHomeWidget(state, appUserCubit));
      },
    );
  }

  Widget _buildHomeWidget(AppUserState state, AppUserCubit appUserCubit) {
    if (state.isInitial()) {
      return const Scaffold(backgroundColor: AppPallete.whiteColor,body: Center(child: CircularProgressIndicator()));
    }
    if (state.isNotInstalled()) {
      return const OnBoardingScreen();
    }
    if (state.isLoggedIn() || state.isGettedData() || state.isSuccess()) {
      return const InitialScreen();
    }
    if (state.isNotLoggedIn() || state.isClearUserData()) {
      return BlocProvider(
        create: (context) => getIt<SignInCubit>(),
        child: const SignInScreen(),
      );
    }
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
