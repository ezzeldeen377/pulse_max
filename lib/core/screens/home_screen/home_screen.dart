import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulse_max/features/doctor/presentation/widgets/doctor_card.dart';
import 'package:pulse_max/features/doctor/presentation/widgets/doctor_speciality_section.dart';
import 'package:pulse_max/features/doctor/presentation/widgets/top_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const TopSection(),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ImageSlideshow(
              
                /// Width of the [ImageSlideshow].
                width: double.infinity,
                /// Height of the [ImageSlideshow].
                
              height: 203,
                /// The page to show when first creating the [ImageSlideshow].
                initialPage: 0,
              
                /// The color to paint the indicator.
                indicatorColor: Colors.blue,
              
                /// The color to paint behind th indicator.
                indicatorBackgroundColor: Colors.grey,
              
                /// The widgets to display in the [ImageSlideshow].
                /// Add the sample image file into the images folder
                children: [
                  const DoctorCard(),
                  const DoctorCard(),
                  const DoctorCard(),
                  const DoctorCard(),
                ],
              
                /// Called whenever the page in the center of the viewport changes.
                onPageChanged: (value) {
                  print('Page changed: $value');
                },
              
                /// Auto scroll interval.
                /// Do not auto scroll with null or 0.
                autoPlayInterval: 3000,
              
                /// Loops back to first slide.
                isLoop: true,
              ),
            ),
          
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(alignment: Alignment.center,
                children: [
                 Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [   
                       
                      Expanded(child: _buildButton("مواعيد الأدوية", Colors.red, topLeft: true)),
                      const SizedBox(width: 10),
                      Expanded(child: _buildButton("احجز دكتور", Colors.blue, topRight: true)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(child: _buildButton("ابدأ محادثة مع طبيبك", Colors.green, bottomLeft: true)),
                      const SizedBox(width: 10),
                      Expanded(child: _buildButton("تاريخك المرضي", Colors.yellow, bottomRight: true)),
                    ],
                  ),
                ],
              ),
                   Container(
                            width: 70,
                            height: 70,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                          ),
                ],
              ),
            ),
            DoctorSpecialitySection(),
          ],
        ),
      ),
    );
  }

 Widget _buildButton(String text, Color color,
      {bool topLeft = false, bool topRight = false, bool bottomLeft = false, bool bottomRight = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeft ? 15 : 0),
          topRight: Radius.circular(topRight ? 15 : 0),
          bottomLeft: Radius.circular(bottomLeft ? 15 : 0),
          bottomRight: Radius.circular(bottomRight ? 15 : 0),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

}
