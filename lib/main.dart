import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulse_max/bloc_observer.dart';
import 'package:pulse_max/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:pulse_max/core/di/di.dart';
import 'package:pulse_max/core/theme/app_pallete.dart';
import 'package:pulse_max/custom_main_bloc_consumer.dart';
import 'package:pulse_max/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  Bloc.observer = SimpleBlocObserver(); // Set the global observer
  bool isConnected = await checkInternetConnection();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    BlocProvider(
      create: (context) => getIt<AppUserCubit>()..isFirstInstallation(),
      child:  AppRoot(isConnected: isConnected,),
    ),
  );
}

class AppRoot extends StatelessWidget {
    final bool isConnected;

  const AppRoot({super.key, required this.isConnected});

  @override
  Widget build(BuildContext context) {
   
    return  ScreenUtilInit(
      
        designSize: const Size(412, 900),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        child: SafeArea(child:isConnected? const CustomMainBlocConsumer():const AppRoute()),
        );
  }
}

Future<bool> checkInternetConnection() async {
  var connectivityResult = await Connectivity().checkConnectivity();
return connectivityResult.contains(ConnectivityResult.wifi) ||
      connectivityResult.contains(ConnectivityResult.mobile);
}

class AppRoute extends StatelessWidget {
  const AppRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        
        appBar: AppBar(title: const Text("Failed",style: TextStyle(fontSize: 20,color: AppColor.teal),)),
        body:  Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/no_connection.jpg",width: double.infinity,fit: BoxFit.fitWidth,),
            const Text("No internet connection",style: TextStyle(fontSize: 20,color: AppColor.teal)),
          ],
        )),
      ),
    );
  }
}