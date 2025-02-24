import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pulse_max/core/helpers/notification_service.dart';
import 'package:pulse_max/core/theme/app_pallete.dart';
import 'package:pulse_max/features/alarm/presentation/cubit/medicine_cubit.dart';
import 'package:pulse_max/features/alarm/presentation/cubit/medicine_state.dart';
import 'package:pulse_max/features/alarm/presentation/widgets/custom_drop_down_field.dart';

class CustomDailogForm extends StatelessWidget {
  const CustomDailogForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration:   BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.teal.shade400,
                    Colors.teal.shade200,
                  ],
                ),
              
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.medication, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    "Add Medicine Alarm",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Medication Details Section
                    _buildSectionCard(
                      icon: Icons.medical_information,
                      title: "Medication Details",
                      primaryColor: Colors.green,
                      content: Column(
                        children: [
                          _buildTextField(
                            label: 'Medicine Name',
                            hint: 'Enter medicine name',
                            controller:
                                context.read<MedicineCubit>().nameController,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            label: 'Dosage',
                            hint: 'Enter Dosage amount',
                            controller:
                                context.read<MedicineCubit>().dosageController,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            label: 'Instructions',
                            hint: 'e.g., Take after food',
                            maxLines: 3,
                            controller:
                                context.read<MedicineCubit>().notesController,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Schedule Section
                    _buildSectionCard(
                      icon: Icons.schedule,
                      title: "Schedule & Frequency",
                      primaryColor: Colors.green,
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTimeList(context),
                          _buildAddTimeButton(Colors.green, context),
                          const SizedBox(height: 16),
                          const CustomDropDownField(
                            label: 'Frequency',
                            value: "Once",
                            items: ['Once', 'Daily'],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Actions
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel",
                        style: TextStyle(color: Colors.grey[600])),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      checkAndSubmit(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkAndSubmit(BuildContext context) {
    final medicine = context.read<MedicineCubit>().createMedicine();
    if (medicine != null) {
      context.read<MedicineCubit>().addMedicine(medicine);
      if (medicine.frequency == 'Once') {
        NotificationService.scheduleNotification(medicine);
      } else if (medicine.frequency == 'Daily') {
        NotificationService.scheduleDailyNotification(medicine);
      }
      Navigator.pop(context);
    }
  }

  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required Color primaryColor,
    required Widget content,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Icon(icon, color: primaryColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    int maxLines = 1,
    TextEditingController? controller,
  }) {
    return TextField(
      maxLines: maxLines,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildTimeList(BuildContext context) {
    return BlocBuilder<MedicineCubit, MedicineState>(
      builder: (context, state) {
        final timeList = state.timeList ?? [];
        return Column(
          children: timeList
              .map((time) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green.shade100, Colors.green.shade200],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.access_time,
                          color: Colors.green.shade700,
                        ),
                      ),
                      title: Text(
                        DateFormat.jm().format(time),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 15,
                          ),
                        ),
                        onPressed: () => context
                            .read<MedicineCubit>()
                            .removeTimeFromList(time),
                      ),
                    ),
                  ))
              .toList(),
        );
      },
    );
  }

  Widget _buildAddTimeButton(Color primaryColor, BuildContext context) {
    return TextButton.icon(
      onPressed: () async {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(primary: primaryColor),
            ),
            child: child!,
          ),
        );
        if (time != null) {
          context.read<MedicineCubit>().addTimeToList(time.toDateTime);
        }
      },
      icon: Icon(Icons.add, color: primaryColor),
      label: Text("Add Time", style: TextStyle(color: primaryColor)),
    );
  }
}

extension TimeOfDayExtension on TimeOfDay {
  DateTime get toDateTime => DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        hour,
        minute,
      );
}
