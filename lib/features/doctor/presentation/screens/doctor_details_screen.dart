import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:pulse_max/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:pulse_max/core/common/entities/user_model.dart';
import 'package:pulse_max/core/helpers/shared_prefernece_utiles.dart';
import 'package:pulse_max/core/routes/routes.dart';
import 'package:pulse_max/features/doctor/domain/entities/doctor.dart';
import 'package:pulse_max/features/doctor/presentation/providers/doctors_cubit.dart';
import 'package:pulse_max/features/message/data/models/chat_model.dart';
import 'package:pulse_max/features/message/presentation/screens/chat_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorDetailsScreen extends StatefulWidget {
  static const routeName = '/doctor_details';
  final Doctor doctor;
  const DoctorDetailsScreen({
    super.key,
    required this.doctor,
  });

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  double startSize = 40;
  double endSize = 100;
  double currentSize = 100;
  double startFontSize = 60;
  double endFontSize = 16;
  double currentFontSize = 60;
  Alignment currentAlignment = Alignment.center;
  late Doctor doctor;
  late UserModel localUser;

  @override
  void initState() {
    super.initState();
    doctor = widget.doctor;
    _initializeUserData();
  }

  Future<void> _initializeUserData() async {
    localUser = context.read<AppUserCubit>().state.user!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final chat = ChatModel(
            senderId: localUser.uid,
            receiverId: doctor.id,
            receiverName: doctor.name,
            receiverProfilePicture: doctor.imageUrl,
          );
          final result = await context.read<DoctorsCubit>().startChat(chat);
          if (result != null) {
            Navigator.pushNamed(context, RouteNames.chatScreen,
                arguments: result);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Something went wrong'),
              ),
            );
          }
        },
        child: const Icon(FontAwesome.message_solid),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(doctor.name ?? ""),
      ),
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.forward) {
            setState(() {
              // reduce current size
              currentSize = endSize;
              currentFontSize = startFontSize;
              currentAlignment = Alignment.topCenter;
            });
          } else if (notification.direction == ScrollDirection.reverse) {
            setState(() {
              // increase current size
              currentSize = startSize;
              currentFontSize = endFontSize;
              currentAlignment = Alignment.topRight;
            });
          }
          return true;
        },
        child: Column(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              alignment: currentAlignment,
              curve: Curves.fastOutSlowIn,
              child: Hero(
                tag: doctor.id ?? "",
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  child: CircleAvatar(
                    radius: currentSize,
                    backgroundImage: NetworkImage(doctor.imageUrl ?? ""),
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.white,
                              fontSize: currentFontSize,
                            ),
                        child: Container(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: const Text('Name'),
                    subtitle: Text(
                      doctor.name ?? '',
                    ),
                    trailing: const Icon(Icons.person),
                  ),
                  ListTile(
                    title: const Text('Gender'),
                    subtitle: Text(doctor.gender!.name),
                    trailing: doctor.gender == Gender.male
                        ? const Icon(FontAwesome.person_solid)
                        : const Icon(FontAwesome.person_dress_solid),
                  ),
                  ListTile(
                    title: const Text('Email'),
                    subtitle: Text(
                      doctor.email ?? "",
                    ),
                    trailing: const Icon(FontAwesome.envelope_solid),
                    onTap: () async {
                      final Uri emailLaunchUri =
                          Uri.parse("mailto:${doctor.email}");

                      if (!await launchUrl(emailLaunchUri)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('could_not_launch'),
                          ),
                        );
                      }
                    },
                  ),
                  ListTile(
                    title: const Text('Phone'),
                    subtitle: Text(doctor.phoneNumber ?? ''),
                    trailing: const Icon(FontAwesome.phone_flip_solid),
                    onTap: () async {
                      final Uri phoneLaunchUri = Uri.parse(
                        'tel:${doctor.phoneNumber}',
                      );

                      if (!await launchUrl(phoneLaunchUri)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('could_not_launch'),
                          ),
                        );
                      }
                    },
                  ),
                  // const Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
