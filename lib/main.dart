// ignore_for_file: depend_on_referenced_packages, unnecessary_import

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

import 'screen/home/home_screen.dart';
import 'screen/home/myhome_screen.dart';
import 'screen/signin/signin.dart';
import 'screen/signup/signup.dart';

void main() {
// Initialize FFI
  // WidgetsFlutterBinding.ensureInitialized();
  // sqfliteFfiInit();
  // databaseFactory = databaseFactoryFfi;

  databaseFactory = databaseFactoryFfiWeb;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      routes: {
        "main": (context) => const MyHomePage(),
        "home": (context) => const HomeScreen(),
        "login": (context) => const SignIn(),
        "signUp": (context) => const SignUp(),
      },
    );
  }
}
