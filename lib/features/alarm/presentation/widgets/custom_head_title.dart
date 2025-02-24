import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulse_max/features/alarm/presentation/cubit/medicine_cubit.dart';
import 'package:pulse_max/features/alarm/presentation/cubit/medicine_state.dart';

class CustomHeadTitle extends StatelessWidget {
  const CustomHeadTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 20.w,
      children: [
        Column(
          children: [
            Text("Time for Your Meds!",
                style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            BlocBuilder<MedicineCubit, MedicineState>(
              builder: (context, state) {
                return Text(
                  state.medicines?.isEmpty ?? false
                      ? "It's time for your next dose!"
                      : getNextDoseTime(
                          state.medicines?.first.time ?? DateTime.now()),
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                );
              },
            ),
          ],
        ),
        CircleAvatar(
          radius: 40.r,
          backgroundColor: const Color(0xFF54dea7),
          child: Icon(
            Icons.alarm,
            color: Colors.white,
            size: 40.r,
          ),
        )
      ],
    );
  }
}

String getNextDoseTime(DateTime futureTime) {
  DateTime now = DateTime.now();
  Duration difference = futureTime.difference(now);
  int minutesLeft = difference.inMinutes;

  if (minutesLeft > 0) {
    if (minutesLeft >= 60) {
      int hours = minutesLeft ~/ 60; // Get full hours
      int minutes = minutesLeft % 60; // Get remaining minutes

      if (minutes > 0) {
        return "Next dose in $hours hours $minutes minutes";
      } else {
        return "Next dose in $hours hours";
      }
    } else {
      return "Next dose in $minutesLeft minutes";
    }
  } else {
    return "It's time for your next dose!";
  }
}
