import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulse_max/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:pulse_max/core/routes/routes.dart';
import 'package:pulse_max/core/theme/app_pallete.dart';
import 'package:pulse_max/core/utils/show_snack_bar.dart';
import 'package:pulse_max/features/doctor/data/models/appointment_model.dart';

import 'package:pulse_max/features/doctor/data/models/doctor.dart';
import 'package:pulse_max/features/doctor/presentation/bloc/doctors/doctors_cubit.dart';
import 'package:pulse_max/features/doctor/presentation/bloc/doctors/doctors_state.dart';
import 'package:pulse_max/features/doctor/presentation/widgets/show_time_picker_bottom_sheet.dart';
import 'package:pulse_max/features/message/data/models/chat_model.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final DoctorModel doctor;
  const DoctorDetailsScreen({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    final localUser = context.read<AppUserCubit>().state.user;
    return BlocListener<DoctorsCubit, DoctorsState>(
      listener: (context, state) {
  if (state.isPicked) {
          showCustomDialog(context, 'Appointment Booked', () {
            Navigator.pop(context);
          });
        }      },
      child: Scaffold(
       
        backgroundColor : Colors.grey[100],
        appBar: AppBar(
          backgroundColor: AppColor.lightTeal,
          title: const Text('Doctor Details'),centerTitle: true,

        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Row(
                  crossAxisAlignment: CrossAxisAlignment.center, // Align items to the top
                  children: [
                    const CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/images/doctor_image.png'),
                    ),
                    const SizedBox(width: 16),
                    Expanded( // Allow the column to take available space
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min, // Prevent unnecessary expansion
              children: [
                Text(
                  "Dr ${doctor.name}",
                  style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.teal,
                  ),
                ),
                Text(
                  doctor.specialization ?? '',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Text(
                  doctor.qualification ?? '',
                  style: const TextStyle(color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1, // Ensures the text truncates if it overflows
                ),
              ],
            ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const StatItem(
                        count: '100+', label: 'Patients', icon: Icons.person),
                     StatItem(
                        count: doctor.yearsOfExperience?.toStringAsFixed(1)??'', label: 'Years Exp', icon: Icons.work),
                    // StatItem(count: '10+', label: 'Years Exp.', icon: Icons.work),
                    StatItem(count: doctor.rating==null ? 'no rated' : doctor.rating!.toStringAsFixed(1), label: 'Rating', icon: Icons.star),
                    const StatItem(
                        count: '50+', label: 'Reviews', icon: Icons.comment),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('About',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                 Text(
                  doctor.bio??" no bio for this doctor added yet ",
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                const Text('Working Hours',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const WorkingHoursWidget(),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        label: const Text('Chat Now'),
                        
                        onPressed: () async {
                          final chat = ChatModel(
                            senderId: localUser?.uid,
                            senderName: localUser?.name,
                            senderProfilePicture: localUser?.profileImage,
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
                              const SnackBar(
                                  content: Text('Something went wrong')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.teal,
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.chat,color :Colors.white),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        label: const Text('Book Appointment'),
                        onPressed: () async {
                          final selectedTime =
                              await showTimePickerBottomSheet(context);
                          if (selectedTime != null) {
                            context.read<DoctorsCubit>().createAppointment(
                                AppointmentModel(
                                    createdAt: DateTime.now(),
                                    date: selectedTime,
                                    doctorId: doctor.uid,
                                    userId: localUser?.uid,
                                    status: 'pending'));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                             backgroundColor: AppColor.teal,
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.calendar_month,color:Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StatItem extends StatelessWidget {
  final String count;
  final String label;
  final IconData icon;
  const StatItem({super.key, required this.count, required this.label, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: AppColor.lightTeal,
          child: Icon(icon, color:AppColor.teal, size: 30),
        ),
        const SizedBox(height: 8),
        Text(count,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: AppColor.teal)),
        Text(label,style: const TextStyle(color:Colors.grey),),
      ],
    );
  }
}

class WorkingHoursWidget extends StatelessWidget {
  const WorkingHoursWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          WorkingHourItem(day: 'Monday', hours: '10:00 - 15:00'),
          WorkingHourItem(day: 'Tuesday', hours: '12:00 - 17:00'),
          WorkingHourItem(day: 'Wednesday', hours: '08:00 - 13:00'),
          WorkingHourItem(day: 'Thursday', hours: '15:00 - 20:00'),
          WorkingHourItem(day: 'Friday', hours: '09:00 - 14:00'),
          WorkingHourItem(day: 'Saturday', hours: '11:00 - 16:00'),
        ],
      ),
    );
  }
}

class WorkingHourItem extends StatelessWidget {
  final String day;
  final String hours;
  const WorkingHourItem({super.key, required this.day, required this.hours});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(day, style: const TextStyle(fontSize: 16)),
        Text(hours, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
