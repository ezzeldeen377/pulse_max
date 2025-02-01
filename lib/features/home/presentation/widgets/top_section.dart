import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_max/core/common/cubit/app_user/app_user_cubit.dart';

class TopSection extends StatelessWidget {
  const TopSection({super.key});

  @override
  Widget build(BuildContext context) {
    final user=context.read<AppUserCubit>().state.user;
    return  Column(
      children:  [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                backgroundColor: Colors.grey,
                backgroundImage:user?.profileImage==null?null: NetworkImage(user?.profileImage??''), // Change to NetworkImage if needed
                ),
                const SizedBox(width: 10),
                Text(
                  user?.name??'',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Row(
              children: [
                Icon(Icons.notifications_none, size: 28),
                SizedBox(width: 10),
                Icon(Icons.favorite_border, size: 28),
              ],
            ),
          ],
        ),
        
      ],
    );
  }
}