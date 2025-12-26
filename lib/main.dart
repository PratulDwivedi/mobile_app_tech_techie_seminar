import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app_tech_techie_seminar/features/event/screens/seminar_home_screen.dart';
import 'package:mobile_app_tech_techie_seminar/features/user/screens/login_screen.dart';

void main() {
  runApp(const ProviderScope(child: SeminarApp()));
}

class SeminarApp extends StatelessWidget {
  const SeminarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seminar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
      home: const SeminarHomeScreen(),
      //home: LoginScreen(),
    );
  }
}
