import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newtoktech_project/presentation/login_screen.dart';
import 'package:newtoktech_project/presentation/user/user_home_screen.dart';
import 'package:newtoktech_project/services/signup_screen_provider.dart';
import 'package:newtoktech_project/services/user/user_home_screeen_services.dart';
import 'package:newtoktech_project/services/weather_provider.dart';
import 'package:provider/provider.dart';

import 'presentation/admin/admin_home_screen.dart';
import 'services/admin/admin_home_screen_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyDFE5OT6pTZrmv7xcjWWVmUSMeiVCYEbl0',
    appId: 'com.example.newtoktech_project',
    messagingSenderId: '472880958989',
    projectId: 'newtok-tech',
    storageBucket: 'newtok-tech.appspot.com',
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SignupScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AdminHomeScreenServices(),
        ),
        ChangeNotifierProvider(
          create: (context) => WeatherProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserHomeScreeenServices(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            // appBarTheme: AppBarTheme(
            //     backgroundColor: Color.fromARGB(255, 49, 49, 71),
            //     foregroundColor: Colors.white),
            scaffoldBackgroundColor: const Color.fromARGB(255, 56, 56, 63),
            useMaterial3: true,
          ),
          home: LoginScreen() //UserHomeScreen(), // AdminHomeScreen()
          ),
    );
  }
}
