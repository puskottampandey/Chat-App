import 'package:chatapp/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kurakani',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          iconTheme:
              IconThemeData(color: Colors.blue.shade700, fill: 0.5, shadows: [
            Shadow(
              blurRadius: 3,
              color: Colors.blue.shade100,
            )
          ]),
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 25),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
