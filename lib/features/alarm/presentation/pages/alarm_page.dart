import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pulse_max/core/utils/show_snack_bar.dart';
import 'package:pulse_max/features/alarm/presentation/cubit/medicine_cubit.dart';
import 'package:pulse_max/features/alarm/presentation/cubit/medicine_state.dart';
import 'package:pulse_max/features/alarm/presentation/widgets/custom_alarm_card.dart';
import 'package:pulse_max/features/alarm/presentation/widgets/custom_dailog_form.dart';
import 'package:pulse_max/features/alarm/presentation/widgets/custom_head_title.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlarmPage extends StatelessWidget {
  const AlarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MedicineCubit, MedicineState>(
      listener: (context, state) {
        if (state.isEmpty) {
          showSnackBar(context, state.errorMessage!);
        }
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 250.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.teal.shade400,
                    Colors.teal.shade200,
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(height: 30.h),
                  const CustomHeadTitle(),
                  SizedBox(height: 30.h),
                  BlocBuilder<MedicineCubit, MedicineState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.isError) {
                        return Center(child: Text(state.errorMessage!));
                      } else if (state.isSuccess) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.medicines?.length,
                          itemBuilder: (context, index) {
                            final medicine = state.medicines![index];
                            return Slidable(
                              key: const ValueKey(0),
                              startActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                extentRatio: 0.3, // Makes slidable smaller
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      context
                                          .read<MedicineCubit>()
                                          .deleteMedicine(
                                              medicine.id);
                                    },
                                    backgroundColor:
                                        Color.fromARGB(255, 63, 51, 51),
                                    foregroundColor: Colors.white,
                                    borderRadius: BorderRadius.circular(16.r),
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                ],
                              ),
                              child: CustomAlarmCard(medicine: medicine),
                            );
                          },
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ]),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showAddAlarmDialog(context),
          backgroundColor: Colors.green,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          icon: Icon(Icons.add, size: 20.sp, color: Colors.white),
          label: Text(
            "Add Medication",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  Future<void> _showAddAlarmDialog(BuildContext context) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return BlocProvider.value(
            value: context.read<MedicineCubit>(),
            child: const CustomDailogForm());
      },
    );
  }
}
