import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pulse_max/core/helpers/notification_service.dart';
import 'package:pulse_max/features/alarm/data/models/medicine.dart';
import 'package:pulse_max/features/alarm/presentation/cubit/medicine_cubit.dart';

class CustomAlarmCard extends StatelessWidget {
  final Medicine medicine;

  const CustomAlarmCard({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 12.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(color: Colors.grey[300]!),
      ),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: IntrinsicHeight(
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if(medicine.isEnabled)
              VerticalDivider(
                color:  Colors.green,
                thickness: 5,
                indent: 10.h,
                endIndent: 10.h,
                width: 16.w,
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: DateFormat('h:mm')
                                  .format(medicine.time), // Large numbers
                              style: TextStyle(
                                fontSize: 32.sp, // Large font size
                                fontWeight: FontWeight.bold,
                                color: medicine.isEnabled
                                    ? Colors.green
                                    : Colors.black87,
                              ),
                            ),
                            TextSpan(
                              text: DateFormat(' a')
                                  .format(medicine.time), // AM/PM part
                              style: TextStyle(
                                fontSize: 14.sp, // Smaller font size
                                fontWeight: FontWeight.normal,
                                color: medicine.isEnabled
                                    ? Colors.green
                                    : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${medicine.name} - ${medicine.frequency} - ${medicine.dosage}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: medicine.isEnabled ? Colors.green : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Switch(
                value: medicine.isEnabled,
                onChanged: (value) {
                  final updatedMedicine = medicine.copyWith(isEnabled: value);
          
                  context.read<MedicineCubit>().updateMedicine(updatedMedicine);
          
                  if (value) {
                    if (updatedMedicine.frequency == 'Daily') {
                      NotificationService.scheduleDailyNotification(
                          updatedMedicine); // ⏰ Daily Alarm
                    } else {
                      NotificationService.scheduleNotification(
                          updatedMedicine); // ⏰ One-time Alarm
                    }
                  } else {
                    NotificationService.cancelNotification(updatedMedicine.id);
                  }
                },
                activeColor: Colors.green,
                activeTrackColor: Colors.green[200],
                inactiveThumbColor: const Color(0xffE0E0E0),
                inactiveTrackColor: const Color(0xffBDBDBD),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
