import 'package:flutter/material.dart';

import 'package:design_system/design_system.dart';

import 'home/home_screen.dart';

void main() {
  runApp(const MobileApp());
}

class MobileApp extends StatelessWidget {
  const MobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile App',
      debugShowCheckedModeBanner: false,
      theme: DsTheme.light(),
      home: const HomeScreen(),
    );
  }
}
