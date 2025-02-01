import 'package:flutter/material.dart';
import 'package:pulse_max/core/routes/routes.dart';

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
              child: const Text("See All", style: TextStyle(color: Colors.teal)),
            ),
          ],
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.8,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context,RouteNames.doctorsScreen,arguments:categories[index]['title'] );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.teal, width: 1.5),
                    ),
                    child: Icon(
                      categories[index]['icon'],
                      color: Colors.teal,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  categories[index]['title']??'More',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}