import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_max/core/helpers/notification_service.dart';
import 'package:pulse_max/features/alarm/presentation/cubit/medicine_cubit.dart';

class CustomDropDownField extends StatefulWidget {
  const CustomDropDownField(
      {super.key,
      required this.value,
      required this.label,
      required this.items});
  final String value;
  final String label;
  final List<String> items;

  @override
  State<CustomDropDownField> createState() => _CustomDropDownFieldState();
}

class _CustomDropDownFieldState extends State<CustomDropDownField> {
  @override
  initState() {
    super.initState();
    NotificationService.init();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: context.read<MedicineCubit>().state.selectedFrequency,
      decoration: InputDecoration(
        labelText: widget.label,
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
      items: widget.items
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (value) => setState(() {
        context.read<MedicineCubit>().changeFrequency(value!);
        print('hereeeeeeeeeee ${context.read<MedicineCubit>().state.selectedFrequency}');
      }),
    );
  }
}
