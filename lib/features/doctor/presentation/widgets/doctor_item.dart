import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulse_max/core/routes/routes.dart';
import 'package:pulse_max/core/theme/app_pallete.dart';
import 'package:pulse_max/core/utils/start_maker.dart';
import 'package:pulse_max/features/doctor/data/models/doctor.dart';

class DoctorItem extends StatelessWidget {
  const DoctorItem({super.key, required this.doctor});
  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
          

            // Doctor Info Row
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),

                  child: Image.asset('assets/images/doctor_image.png',width: 100.w,height: 130.h,fit: BoxFit.cover,),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color:Colors.teal.shade50
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                        child: const Text(
                                        'Professional Doctor',
                                        style: TextStyle(
                                          color:Colors.teal,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                      ),  
                       Text(
                        'Dr ${doctor.name}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: AppColor.primaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                        Text(
                        doctor.specialization??'',
                        style: const TextStyle(
                          fontSize: 14,
                                                      color: AppColor.secondaryTextColor,
                  
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                           CustomStarRating(rating: doctor.rating??3,),
                          VerticalDivider(
                            color: Colors.grey[600],),
                           Text(
                            "${doctor.reviews==null?'49': doctor.reviews.toString()} reviews",
                            style: const TextStyle(
                              color:AppColor.secondaryTextColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Appointment Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                     Navigator.pushNamed(
                                context, RouteNames.doctorDetails,
                                arguments: doctor);
                },
                child: const Text(
                  'Make Appointment',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}