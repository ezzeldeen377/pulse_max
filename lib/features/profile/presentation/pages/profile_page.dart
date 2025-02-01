import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_max/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:pulse_max/core/common/cubit/app_user/app_user_state.dart';
import 'package:pulse_max/core/routes/routes.dart';

class ProfilePage extends StatefulWidget {
  @override
  createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = context.read<AppUserCubit>().state.user;
    return BlocListener<AppUserCubit,AppUserState>(
      listener: (context, state) {
        if (state.isClearUserData()){
		  Navigator.pushNamedAndRemoveUntil(context, RouteNames.signIn, (route) => false);
		}
      },
      child: Scaffold(
        
        backgroundColor : Colors.grey[100],

        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Profile Picture
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  user?.profileImage ?? "", // Replace with actual image URL
                ),
              ),
              const SizedBox(height: 16),

              // User Info
              Text(
                user?.name ?? "", // Replace with dynamic data
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                user?.email ?? '', // Replace with dynamic data
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),

              // Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (user?.type == 'doctor') {
                      Navigator.pushNamed(context, RouteNames.editDoctor,
                          arguments: user?.asDoctor());
                    }
                  },
                  child: Text("Edit Profile"),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    context.read<AppUserCubit>().signOutFromEmailandPassword();
                  },
                  child: Text("Logout", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
