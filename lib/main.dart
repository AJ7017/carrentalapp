import 'package:carrentalapp/firebase_options.dart';
import 'package:carrentalapp/presentation/bloc/car_bloc.dart';
import 'package:carrentalapp/presentation/bloc/car_event.dart';
import 'package:carrentalapp/presentation/pages/Onboardpage.dart';
import 'package:carrentalapp/presentation/pages/Registrationpage.dart';
import 'package:carrentalapp/presentation/pages/car_list_screen.dart';
import 'package:carrentalapp/presentation/pages/loginpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:carrentalapp/utils/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carrentalapp/firebase_options.dart';
import 'package:carrentalapp/injection_container.dart';
import 'package:carrentalapp/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initInjection();
  runApp( MyApp());
  
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
   return BlocProvider(
      create: (_) => getIt<CarBloc>()..add(LoadCars()),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        initialRoute: MyRoutes.onboardRoute,
       routes:{
            MyRoutes.onboardRoute: (context) => Onboardpage(),
            MyRoutes.loginRoute: (context) => Loginpage(),  
            MyRoutes.registerRoute: (context) => Registrationpage(),   
            MyRoutes.carlistscreen: (context) => CarListScreen(), 
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Onboardpage(),
      ),
    );
  
  }
}




