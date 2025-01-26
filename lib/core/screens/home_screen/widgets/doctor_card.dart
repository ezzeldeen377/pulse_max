import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pulse_max/features/doctor/domain/entities/doctor.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key,
    required this.doctor,
  });

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            Container(
              height: size.height * 0.05,
            ),
            Card(
              child: SizedBox(
                height: size.height * 0.2,
                width: size.width * 0.3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Text(
                        doctor.name??'',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text(
                        doctor.specialization??"",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Row(
                        children: [
                          const Icon(
                            FontAwesome.star_solid,
                            size: 15,
                            color: Colors.amber,
                          ),
                          Text(
                            '4.2',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 10,
          left: size.width * 0.08,
          child: CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(doctor.imageUrl??""),
          ),
        ),
      ],
    );
  }
}
