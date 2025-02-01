import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_max/features/doctor/presentation/bloc/bloc/edit_doctor_bloc.dart';
import 'package:pulse_max/features/doctor/presentation/bloc/bloc/edit_doctor_event.dart';
import 'package:pulse_max/features/doctor/presentation/bloc/bloc/edit_doctor_state.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  // Controllers for each field
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DoctorBloc>();
    return BlocListener<DoctorBloc, DoctorState>(
      listener: (context, state) {
        if(state.isSuccess){
          Navigator.pop(context);
        }
      },
      child: Scaffold(
                backgroundColor : Colors.grey[100],

        appBar: AppBar(
          title: const Text('Edit Profile',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade700, Colors.teal.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: bloc.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Personal Information Section
                _buildSectionHeader('Personal Information'),
                _buildTextField(
                  context,
                  bloc.nameController,
                  'Name',
                  Icons.person,
                  isRequired: true,
                  onChanged: (value) {
                    final updatedDoctor = context
                        .read<DoctorBloc>()
                        .state
                        .doctor
                        ?.copyWith(name: value);
                    context
                        .read<DoctorBloc>()
                        .add(UpdateDoctor(updatedDoctor!));
                  },
                ),
                _buildTextField(
                    context, bloc.emailController, 'Email', Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    isEnable: false,
                    isRequired: true,
                    onChanged: null),
                _buildTextField(
                  context,
                  bloc.phoneNumberController,
                  'Phone Number',
                  Icons.phone,
                  isRequired: true,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    final updatedDoctor = context
                        .read<DoctorBloc>()
                        .state
                        .doctor
                        ?.copyWith(phoneNumber: value);
                    context
                        .read<DoctorBloc>()
                        .add(UpdateDoctor(updatedDoctor!));
                  },
                ),

                const SizedBox(height: 20),

                // Professional Information Section
                _buildSectionHeader('Professional Information'),
                _buildTextField(
                  context,
                  bloc.specializationController,
                  'Specialization',
                  Icons.work,
                  isRequired: true,
                  onChanged: (value) {
                    final updatedDoctor = context
                        .read<DoctorBloc>()
                        .state
                        .doctor
                        ?.copyWith(specialization: value);
                    context
                        .read<DoctorBloc>()
                        .add(UpdateDoctor(updatedDoctor!));
                  },
                ),
                _buildTextField(
                  context,
                  bloc.qualificationController,
                  'Qualification',
                  Icons.school,
                  isRequired: true,
                  onChanged: (value) {
                    final updatedDoctor = context
                        .read<DoctorBloc>()
                        .state
                        .doctor
                        ?.copyWith(qualification: value);
                    context
                        .read<DoctorBloc>()
                        .add(UpdateDoctor(updatedDoctor!));
                  },
                ),
                _buildTextField(
                  context,
                  bloc.licenseNumberController,
                  'License Number',
                  Icons.assignment,
                  isRequired: true,
                  onChanged: (value) {
                    final updatedDoctor = context
                        .read<DoctorBloc>()
                        .state
                        .doctor
                        ?.copyWith(licenseNumber: value);
                    context
                        .read<DoctorBloc>()
                        .add(UpdateDoctor(updatedDoctor!));
                  },
                ),
                _buildTextField(
                  context,
                  bloc.hospitalOrClinicNameController,
                  'Hospital/Clinic Name',
                  Icons.local_hospital,
                  isRequired: true,
                  onChanged: (value) {
                    final updatedDoctor = context
                        .read<DoctorBloc>()
                        .state
                        .doctor
                        ?.copyWith(hospitalOrClinicName: value);
                    context
                        .read<DoctorBloc>()
                        .add(UpdateDoctor(updatedDoctor!));
                  },
                ),
                _buildTextField(
                  context,
                  bloc.yearsOfExperienceController,
                  'Years of Experience',
                  Icons.timeline,
                  keyboardType: TextInputType.number,
                  isRequired: true,
                  onChanged: (value) {
                    final updatedDoctor = context
                        .read<DoctorBloc>()
                        .state
                        .doctor
                        ?.copyWith(yearsOfExperience: int.parse(value));
                    context
                        .read<DoctorBloc>()
                        .add(UpdateDoctor(updatedDoctor!));
                  },
                ),
                _buildTextField(
                  context,
                  bloc.consultationFeeController,
                  'Consultation Fee',
                  Icons.attach_money,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  isRequired: true,
                  onChanged: (value) {
                    final updatedDoctor = context
                        .read<DoctorBloc>()
                        .state
                        .doctor
                        ?.copyWith(consultationFee: double.parse(value));
                    context
                        .read<DoctorBloc>()
                        .add(UpdateDoctor(updatedDoctor!));
                  },
                ),
                const SizedBox(height: 20),

                // Bio Section
                _buildSectionHeader('Bio'),
                TextFormField(
                  controller: bloc.bioController,
                  decoration: InputDecoration(
                    hintText: 'Write something about yourself...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.teal.shade50,
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a bio';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: BlocBuilder<DoctorBloc, DoctorState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                context.read<DoctorBloc>().add(SaveDoctor());
              },
              backgroundColor: Colors.teal.shade700,
              elevation: 2,
              child: state.isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Icon(Icons.save, color: Colors.white),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.teal.shade700,
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context,
    TextEditingController controller,
    String label,
    IconData icon, {
    bool isEnable = true,
    TextInputType? keyboardType,
    bool isRequired = false,
    required Function(String)? onChanged, // Callback for onChanged
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        enabled: isEnable,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.teal.shade700),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.teal.shade50,
        ),
        onChanged: onChanged, // Use the provided callback
        keyboardType: keyboardType,
        validator: (value) {
          if (isRequired && (value == null || value.isEmpty)) {
            return 'This field is required';
          }
          if (label == 'Email' && !value!.contains('@')) {
            return 'Please enter a valid email';
          }
          if (label == 'Phone Number' && value!.length < 10) {
            return 'Please enter a valid phone number';
          }
          return null;
        },
      ),
    );
  }
}
