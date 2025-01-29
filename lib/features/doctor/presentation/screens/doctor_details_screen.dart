import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:pulse_max/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:pulse_max/core/common/entities/user_model.dart';
import 'package:pulse_max/core/routes/routes.dart';
import 'package:pulse_max/core/utils/show_snack_bar.dart';
import 'package:pulse_max/features/doctor/data/models/appointment_model.dart';
import 'package:pulse_max/features/doctor/data/models/doctor.dart';
import 'package:pulse_max/features/doctor/presentation/providers/doctors_cubit.dart';
import 'package:pulse_max/features/doctor/presentation/providers/doctors_state.dart';
import 'package:pulse_max/features/doctor/presentation/widgets/show_time_picker_bottom_sheet.dart';
import 'package:pulse_max/features/message/data/models/chat_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorDetailsScreen extends StatefulWidget {
  static const routeName = '/doctor_details';
  final DoctorModel doctor;
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
  late DoctorModel doctor;
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
    return BlocListener<DoctorsCubit, DoctorsState>(
      listener: (context, state) {
        if (state.isPicked) {
          showCustomDialog(context, 'Appointment Booked', () {
            Navigator.pop(context);
          });
        }
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Align(
          alignment: Alignment.bottomRight, // Position at bottom-end
          child: Column(
            mainAxisSize: MainAxisSize.min, // Prevent full column height
            children: [
              SizedBox(
                width: 150.w,
                child: FloatingActionButton.extended(
                  heroTag: "book_appointment", // Unique tag

                  onPressed: () async {
                    final selectedTime =
                        await showTimePickerBottomSheet(context);
                    if (selectedTime != null) {
                      context.read<DoctorsCubit>().createAppointment(
                          AppointmentModel(
                              createdAt: DateTime.now(),
                              date: selectedTime,
                              doctorId: doctor.uid,
                              userId: localUser.uid,
                              status: 'pending'));
                    }
                  },
                  icon: const Icon(
                      FontAwesome.calculator_solid), // FontAwesome icon
                  label: const Text('Appointment'),
                  backgroundColor: Colors.blue, // Color for this button
                ),
              ),
              const SizedBox(height: 10), // Space between buttons
              SizedBox(
                width: 150.w,
                child: FloatingActionButton.extended(
                  heroTag: "chat_now", // Unique tag

                  onPressed: () async {
                    final chat = ChatModel(
                      senderId: localUser.uid,
                      senderName: localUser.name,
                      senderProfilePicture: localUser.profileImage,
                      receiverId: doctor.uid,
                      receiverName: doctor.name,
                      receiverProfilePicture: doctor.profileImage,
                    );
                    final result =
                        await context.read<DoctorsCubit>().startChat(chat);
                    if (result != null) {
                      Navigator.pushNamed(context, RouteNames.chatScreen,
                          arguments: result);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Something went wrong')),
                      );
                    }
                  },
                  icon:
                      const Icon(FontAwesome.message_solid), // FontAwesome icon
                  label: const Text('Chat Now'),
                  backgroundColor: Colors.green, // Color for this button
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(doctor.name ?? ''),
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
                  tag: doctor.uid ?? "",
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    child: CircleAvatar(
                      radius: currentSize,
                      backgroundImage: NetworkImage(doctor.profileImage ?? ""),
                      child: AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
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
                      subtitle: Text(doctor.gender ?? ''),
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
      ),
    );
  }
}
