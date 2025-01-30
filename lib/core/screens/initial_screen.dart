import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_max/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:pulse_max/core/di/di.dart';
import 'package:pulse_max/core/screens/home_screen/home_screen.dart';
import 'package:pulse_max/features/message/presentation/cubits/chats_cubit.dart';
import 'package:pulse_max/features/message/presentation/screens/user_chats_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  int _currentIndex = 0; // Tracks the selected tab index
  final PageController _pageController =
      PageController(); // Controls page sliding

  // List of pages to display
  final List<Widget> _pages = [
    const HomeScreen(),
    BlocProvider(
      create: (context) => getIt<ChatsCubit>()
        ..getChats(context.read<AppUserCubit>().state.user!.uid!),
      child: const UserChatsScreen(),
    ),
    const Center(child: Text('Favorites Page', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Profile Page', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index; // Update the selected tab index
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the selected tab index
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ); // Slide to the selected page
          });
        },
        type: BottomNavigationBarType.fixed, // Fixed type for 4 tabs
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose the PageController
    super.dispose();
  }
}
