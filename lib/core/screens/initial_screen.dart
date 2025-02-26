import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_max/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:pulse_max/core/di/di.dart';
import 'package:pulse_max/core/routes/routes.dart';
import 'package:pulse_max/core/utils/custom_floating_action_button.dart';
import 'package:pulse_max/features/home/presentation/pages/home_screen.dart';
import 'package:pulse_max/features/measurement/presentation/cubit/measurement_cubit.dart';
import 'package:pulse_max/features/measurement/presentation/pages/measurement_page.dart';
import 'package:pulse_max/features/message/presentation/cubits/chats_cubit.dart';
import 'package:pulse_max/features/message/presentation/screens/user_chats_screen.dart';
import 'package:pulse_max/features/profile/presentation/pages/profile_page.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  int _currentIndex = 0; // Tracks the selected tab index
  final PageController _pageController = PageController(); // Controls page sliding

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: 4, // Number of tabs
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return const HomeScreen();
            case 1:
              return BlocProvider(
                create: (context) => getIt<ChatsCubit>()
                  ..getChats(context.read<AppUserCubit>().state.user!.uid!),
                child: const UserChatsScreen(),
              );
            case 2:
              return BlocProvider(
                create: (context) => getIt<MeasurementCubit>()..startMeasuring(),
                child: MeasurementPage(),
              );
            case 3:
              return  ProfilePage();
            default:
              return Container();
          }
        },
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RouteNames.askAi);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.teal,
        backgroundColor: Colors.grey[100],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index); // Jump directly to avoid unwanted rebuilds
          });
        },
        type: BottomNavigationBarType.fixed, // Fixed type for 4 tabs
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Measurement'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
