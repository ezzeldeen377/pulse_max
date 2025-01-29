import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:pulse_max/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:pulse_max/core/common/cubit/app_user/app_user_state.dart';
import 'package:pulse_max/core/routes/routes.dart';
import 'package:pulse_max/core/screens/home_screen/widgets/doctor_card.dart';
import 'package:pulse_max/core/screens/home_screen/widgets/nav_item.dart';
import 'package:pulse_max/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:pulse_max/features/doctor/presentation/providers/doctors_cubit.dart';
import 'package:pulse_max/features/doctor/presentation/providers/doctors_state.dart';
import 'package:pulse_max/features/doctor/presentation/screens/doctors_screen.dart';
import 'package:pulse_max/features/message/presentation/screens/user_chats_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<AppUserCubit, AppUserState>(
      listener: (context, state) {
  if (state.isClearUserData()) {
          context.pop();
          context.pushReplacementNamed(SignInScreen.routeName);
        }      },
      child: Scaffold(
        body: SafeArea(
          // maintainBottomViewPadding: false,
          minimum: EdgeInsets.zero,
          child: Column(
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(size.width * 0.1),
                            bottomRight: Radius.circular(size.width * 0.1),
                          ),
                        ),
                        color: Theme.of(context).primaryColor,
                        child: SizedBox(
                          width: size.width,
                          height: size.height * 0.2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Pulse Max',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width,
                        height: size.height * 0.1,
                        // color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 25,
                    child: SizedBox(
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          NavItem(
                            icon: FontAwesome.hospital,
                            title: 'Doctor',
                            description: 'Search for a doctor',
                            onTap: () {
                            Navigator.pushNamed(context, RouteNames.doctorsScreen);
                            },
                          ),
                          NavItem(
                            icon: Icons.home,
                            title: 'Medicine',
                            description: 'Search for a medicine',
                            onTap: () {
                            Navigator.pushNamed(context, RouteNames.userChats);
                            },
                          ),
                          NavItem(
                            icon: Icons.home,
                            title: 'Diagnostic',
                            description: 'Book a diagnostic test',
                            onTap: () {
                                                        context.read<AppUserCubit>().signOut();

                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Card(
                          child: SizedBox(
                            width: size.width,
                            height: size.height * 0.2,
                            child: const Center(
                              child: Text('Awesome Add'),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Row(
                            children: [
                              const Text('Doctors near you'),
                              const Spacer(),
                              TextButton(
                                onPressed: () {
                                  context.push(DoctorsScreen.routeName);
                                },
                                child: const Text('See all'),
                              ),
                            ],
                          ),
                          subtitle: SizedBox(
                            height: size.height * 0.4,
                            child: BlocBuilder<DoctorsCubit, DoctorsState>(
                                builder: (context, state) {
                              final doctors = state.doctors ?? [];
                              if (doctors.isEmpty)
                                return const Center(
                                  child: Text('No Doctors'),
                                );
                              return ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return DoctorCard(doctor: doctors[index]);
                                  },
                                  separatorBuilder: (context, index) {
                                    return const Divider();
                                  },
                                  itemCount: doctors.length);
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
