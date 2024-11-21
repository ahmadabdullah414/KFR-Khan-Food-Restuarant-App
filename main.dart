import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kfr/login.dart';
import 'package:provider/provider.dart';

import 'cart_provider.dart';
import 'logoscreen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Now wrap the app with ChangeNotifierProvider
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
