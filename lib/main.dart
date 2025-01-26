import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_max/bloc_observer.dart';
import 'package:pulse_max/core/di/di.dart';
import 'package:pulse_max/firebase_options.dart';
import 'package:pulse_max/core/routes/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   configureDependencies();  
  Bloc.observer = SimpleBlocObserver(); // Set the global observer

 await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(
    const AppRoot(),
  );
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Pulse Max',
      debugShowCheckedModeBanner: false,
      routerConfig: routerConfig,
    );
  }
}
