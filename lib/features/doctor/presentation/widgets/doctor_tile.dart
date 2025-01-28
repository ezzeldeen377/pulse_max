import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pulse_max/core/routes/routes.dart';
import 'package:pulse_max/features/doctor/domain/entities/doctor.dart';
import 'package:pulse_max/features/doctor/presentation/screens/doctor_details_screen.dart';

class DoctorTile extends StatelessWidget {
  final Doctor doctor;
  const DoctorTile({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.doctorDetails,
            arguments: doctor);
      },
      leading: Hero(
        tag: doctor.id ?? "",
        child: CircleAvatar(
          backgroundImage: NetworkImage(doctor.imageUrl ?? ""),
        ),
      ),
      title: Text(doctor.name ?? ""),
      subtitle: Text(doctor.specialization ?? ''),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
