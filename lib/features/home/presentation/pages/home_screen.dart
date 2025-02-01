import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulse_max/core/routes/routes.dart';
import 'package:pulse_max/features/doctor/presentation/widgets/doctor_card.dart';
import 'package:pulse_max/features/doctor/presentation/widgets/doctor_speciality_section.dart';
import 'package:pulse_max/features/home/presentation/widgets/top_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
                  color : Colors.grey[100],

          padding:  EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TopSection(),
                          SizedBox(height: 20.h),
          
              SizedBox(height: 10.h),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ImageSlideshow(
                  width: double.infinity,               
                height: 215,
                  initialPage: 0,
                  indicatorColor: Colors.white,
                  indicatorBackgroundColor: Colors.grey,
                  autoPlayInterval: 4000,
                  isLoop: true,
                  children:[
                    DoctorCard(),
                    DoctorCard(),
                    DoctorCard(),
                    DoctorCard(),
                  ],
                ),
              ),
                        SizedBox(height: 20.h),
          const Text(
                "Our Services",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
                          SizedBox(height: 20.h),
          
              Stack(alignment: Alignment.center,
                children: [
                 Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [   
                       
                      Expanded(child: _buildButton("Medication Schedule",context , Icons.calendar_today, topLeft: true)),
                      const SizedBox(width: 10),
                      Expanded(child: _buildButton("Book a Doctor", context, Icons.medical_services, topRight: true)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(child: _buildButton("Start Chat with Doctor", context, Icons.chat, bottomLeft: true)),
                      const SizedBox(width: 10),
                      Expanded(child: _buildButton("Disease History", context, Icons.history, bottomRight: true)),
                    ],
                  ),
                ],
              ),
                  
                ],
              ),
              SizedBox(height: 20.h),
              DoctorSpecialitySection(),
            ],
          ),
        ),
      ),
    );
  }

Widget _buildButton(String text, BuildContext context, IconData icon,
    {bool topLeft = false, bool topRight = false, bool bottomLeft = false, bool bottomRight = false}) {
  return InkWell(
    onTap: () {
      if (text == "Book a Doctor" || text == "Start Chat with Doctor") {
        Navigator.pushNamed(context, RouteNames.doctorsScreen);
      }
    },

    child: Container(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeft ? 15 : 0),
          topRight: Radius.circular(topRight ? 15 : 0),
          bottomLeft: Radius.circular(bottomLeft ? 15 : 0),
          bottomRight: Radius.circular(bottomRight ? 15 : 0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}

}
