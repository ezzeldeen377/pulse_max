import 'package:flutter/material.dart';
import 'package:pulse_max/core/routes/routes.dart';

import '../../../../../core/theme/style.dart';

class CustomeAlreadyHaveAnAccountRow extends StatelessWidget {
  final VoidCallback onTap;
  const CustomeAlreadyHaveAnAccountRow({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: TextStyles.font14RobotoLightBlackColorRegular,
        ),
        InkWell(
          onTap: () {
                      Navigator.pushNamed(context,RouteNames.signIn);

          },
          child: Text(
            'Sign In',
            style: TextStyles.font14RobotoLightBlackColorMedium,
          ),
        ),
      ],
    );
  }
}
