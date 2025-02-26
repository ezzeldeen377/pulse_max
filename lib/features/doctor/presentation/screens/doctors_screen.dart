import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pulse_max/core/routes/routes.dart';
import 'package:pulse_max/features/doctor/data/models/doctor.dart';
import 'package:pulse_max/features/doctor/presentation/bloc/doctors/doctors_cubit.dart';
import 'package:pulse_max/features/doctor/presentation/bloc/doctors/doctors_state.dart';
import 'package:pulse_max/features/doctor/presentation/widgets/doctor_item.dart';
import 'package:pulse_max/features/doctor/presentation/widgets/doctor_tile.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key, this.startCategory});
  final String? startCategory;
  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen>
    with SingleTickerProviderStateMixin {
  String? query;
  String? cateory;
  List<String> categories = [
    "All",
    "General",
    "Neurology",
    "Nutrition",
    "Dentist",
    "Pediatric",
    "Radiology",
    "Ophthalmology"
  ];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    int initialIndex = categories.indexOf(widget.startCategory ?? 'All');
    _tabController = TabController(
        length: categories.length,
        vsync: this,
        initialIndex: initialIndex >= 0 ? initialIndex : 0);
  }

  @override
  Widget build(BuildContext context) {
    var doctors = context.watch<DoctorsCubit>().state.doctors;
    cateory = context.watch<DoctorsCubit>().state.category;

    List<DoctorModel> filteredDoctors = doctors ?? [];

    if (query != null) {
      filteredDoctors = doctors!
          .where((doctor) =>
              doctor.name!.toLowerCase().contains(query!.toLowerCase()))
          .toList();
    }

    return Scaffold(
      backgroundColor:  Colors.grey[100],
        body: Column(
      children: [
        const SizedBox(height: 20),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
              decoration: const InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
              onChanged: (value) {
                query = value;
                setState(() {});
              }),
        ),
        const SizedBox(height: 20),
     
        Expanded(
          child: BlocBuilder<DoctorsCubit, DoctorsState>(
            builder: (context, state) {
              if (state.isLoading)
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.teal,
                ));
              if (filteredDoctors.isEmpty)
                return const Center(child: Text('No Doctor Found '));
              return ListView.builder(
                  itemCount: filteredDoctors.length,
                  itemBuilder: (context, index) {
                    return DoctorItem(
                      doctor: filteredDoctors[index],
                    );
                  });
            },
          ),
        )
      ],
    ));
  }
}
