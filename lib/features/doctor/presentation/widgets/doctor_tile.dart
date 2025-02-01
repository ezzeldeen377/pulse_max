import 'package:flutter/material.dart';
import 'package:pulse_max/core/routes/routes.dart';
import 'package:pulse_max/features/doctor/data/models/doctor.dart';

class DoctorTile extends StatelessWidget {
  final DoctorModel doctor;
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
        tag: doctor.uid ?? "",
        child: CircleAvatar(
          backgroundImage: NetworkImage(doctor.profileImage ?? ""),
        ),
      ),
      title: Text(doctor.name ?? ""),
      subtitle: Text(doctor.specialization ?? ''),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
