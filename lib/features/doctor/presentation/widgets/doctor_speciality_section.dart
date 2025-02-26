import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_max/core/di/di.dart';
import 'package:pulse_max/features/doctor/data/models/doctor.dart';
import 'package:pulse_max/features/doctor/presentation/bloc/doctors/doctors_cubit.dart';
import 'package:pulse_max/features/doctor/presentation/bloc/doctors/doctors_state.dart';
import 'package:pulse_max/features/home/presentation/widgets/doctor_home_card.dart';

class DoctorSpecialitySection extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.add, 'title': 'General'},
    {'icon': Icons.biotech, 'title': 'Neurology'},
    {'icon': Icons.nature_people, 'title': 'Nutrition'},
    {'icon': Icons.medical_services, 'title': 'Dentist'},
    {'icon': Icons.child_care, 'title': 'Pediatric'},
    {'icon': Icons.radar, 'title': 'Radiology'},
    {'icon': Icons.remove_red_eye, 'title': 'Ophthalmology'},
    {'icon': Icons.more_horiz, 'title': null},
  ];
  DoctorSpecialitySection({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Doctor Speciality",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {},
              child:
                  const Text("See All", style: TextStyle(color: Colors.teal)),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 230,
          width: double.infinity,
          child: BlocBuilder<DoctorsCubit, DoctorsState>(
            bloc: getIt<DoctorsCubit>()..getDoctorss(null),
            builder: (context, state) {
              if (state.status == DoctorsStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.teal),
                );
              }

              if (state.status == DoctorsStatus.error) {
                return Center(
                  child: Text(
                    state.errorMessage ?? 'Something went wrong',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              if (state.doctors == null || state.doctors!.isEmpty) {
                return const Center(
                  child: Text('No doctors available'),
                );
              }

              final doctorList = state.doctors??[];
              return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: doctorList.length,
                itemBuilder: (context, index) {
                  final doctor = doctorList[index];
                  return DoctorHomeCard(doctor: doctor);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
