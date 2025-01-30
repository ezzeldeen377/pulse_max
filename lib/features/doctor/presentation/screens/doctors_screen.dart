import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pulse_max/features/doctor/data/models/doctor.dart';
import 'package:pulse_max/features/doctor/presentation/providers/doctors_cubit.dart';
import 'package:pulse_max/features/doctor/presentation/widgets/doctor_tile.dart';

class DoctorsScreen extends StatefulWidget {
  static const routeName = '/doctors';
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  double height = 0;

  String? query;

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var doctors = context.watch<DoctorsCubit>().state.doctors;

    List<DoctorModel> filteredDoctors = doctors??[];

    if (query != null) {
      filteredDoctors = doctors
          !.where((doctor) =>
              doctor.name!.toLowerCase().contains(query!.toLowerCase()))
          .toList();
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
             automaticallyImplyLeading: false,
            pinned: true,centerTitle: true,
            snap: true,
            floating: true,
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                children: [
                  const Text('Doctors'),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      context.read<DoctorsCubit>().createDoctor(
                            DoctorModel.faker(),
                          );
                    },
                    icon: const Icon(Icons.add),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                child: SearchBar(
                  elevation: WidgetStateProperty.all(1),
                  controller: _controller,
                  hintText: 'Search for a doctor',
                  trailing: [
                    if (height != 0)
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            query = null;
                            _controller.clear();
                          });
                        },
                      ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      query = value;
                    });
                  },
                ),
              ),
            ),
          ),
          if (filteredDoctors.isEmpty)
            const SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('No doctors found'),
                ),
              ),
            ),
          if (filteredDoctors.isNotEmpty)
            SliverList.list(
              children: filteredDoctors
                  .map(
                    (doctor) => DoctorTile(doctor: doctor),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}
