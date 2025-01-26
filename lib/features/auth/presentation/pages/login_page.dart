import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pulse_max/core/screens/home_screen/home_screen.dart';
import 'package:pulse_max/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:pulse_max/features/auth/presentation/cubit/auth_state.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/login';
   LoginPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) =>  LoginPage());
  }

  final bool _isLoading = false;

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
  return 
       BlocListener<AuthCubit, AuthState>(
         listener: (context, state) {
          if(state.isSuccess){
            context.read<AuthCubit>().saveUserRemote(state.user!);
          }
          if(state.isSaved){
            context.push(HomeScreen.routeName); 
          }
         },
         child: Scaffold(
               appBar: AppBar(title: const Text('Sign In')),
               body: ListView(
                 padding: const EdgeInsets.all(8),
                 children: [
                   TextFormField(
                     controller: _emailController,
                     decoration: const InputDecoration(labelText: 'Email'),
                     keyboardType: TextInputType.emailAddress,
                   ),
                   const SizedBox(height: 8),
                   TextFormField(
                     controller: _passwordController,
                     decoration: const InputDecoration(labelText: 'Password'),
                     obscureText: true,
                   ),
                   const SizedBox(height: 8),
                   ElevatedButton(
                     onPressed: _isLoading ? null : () async {},
                     child: const Text('Login'),
                   ),
                   const SizedBox(height: 8),
                   ElevatedButton(
                     onPressed: ()  {
                      context.read<AuthCubit>().signInWithGoogle();
                     },
                     style: ElevatedButton.styleFrom(
                       padding:
                           const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(8),
                       ),
                       backgroundColor: Colors.white,
                     ),
                     child: const Row(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         SizedBox(width: 12),
                         Text(
                           'Login with Google',
                           style: TextStyle(fontSize: 16, color: Colors.black),
                         ),
                       ],
                     ),
                   ),
                 ],
               ),
             ),
       );
    
  }
}
