import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulse_max/core/routes/routes.dart';
import 'package:pulse_max/core/utils/show_snack_bar.dart';
import '../../../../core/theme/app_pallete.dart';
import '../cubits/sign_up_cubit/sign_up_cubit.dart';
import '../cubits/sign_up_cubit/sign_up_state.dart';
import '../widgets/custom_button.dart';
import '../widgets/sign_up/custome_already_have_an_account_row.dart';
import '../widgets/sign_up/custome_sign_up_input_fields.dart';
import '../widgets/sign_up/custome_sign_up_listner.dart';
import '../widgets/sign_up/custome_upper_text.dart';
import '../widgets/sign_up/google_button.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signUp';

  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? selectedRole = 'Patient'; // Default value is 'Patient'

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpCubit>();
    return CustomeSignUpListner(
      child: Scaffold(
        backgroundColor: AppPallete.whiteColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: cubit.signUpViewModel.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Doctor / Patient selection options

                  SizedBox(height: 15.h),
                  const CustomeUpperText(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Doctor selection box
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedRole = 'Patient';
                            });
                          },
                          child: Container(
                            height: 50.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                              color: selectedRole == 'Patient'
                                  ? AppPallete.darkVividVioletColor
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Patient',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: selectedRole == 'Patient'
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        // Doctor selection box
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedRole = 'Doctor';
                            });
                          },
                          child: Container(
                            height: 50.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                              color: selectedRole == 'Doctor'
                                  ? AppPallete.darkVividVioletColor
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Doctor',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: selectedRole == 'Doctor'
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),

                  CustomeSignUpInputFields(cubit: cubit.signUpViewModel),
                  SizedBox(height: 27.h),
                  Column(
                    children: [
                      BlocBuilder<SignUpCubit, SignUpState>(
                        builder: (context, state) {
                          return state.isLoading
                              ? const CircularProgressIndicator(
                                  color: AppPallete.darkVividVioletColor,
                                )
                              : CustomButton(
                                  buttonText: 'Sign Up',
                                  onTapButton: () {
                                    if (state.isChecked == true) {
                                      if (cubit
                                          .signUpViewModel.formKey.currentState!
                                          .validate()) {
                                        cubit.signUp(
                                          name: cubit.signUpViewModel
                                              .nameController!.text,
                                          email: cubit.signUpViewModel
                                              .emailController!.text,
                                          password: cubit.signUpViewModel
                                              .passwordController!.text,
                                          type: selectedRole!,
                                        );
                                      }
                                    } else {
                                      showSnackBar(context,
                                          'Please accept terms and conditions');
                                    }
                                  },
                                );
                        },
                      ),
                      SizedBox(height: 10.h),
                      CustomeAlreadyHaveAnAccountRow(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, RouteNames.signUp);
                        },
                      ),
                      SizedBox(height: 22.h),
                      GoogleButton(onTapButton: () {}),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
