import 'package:flutter/material.dart';

import 'package:design_system/design_system.dart';

import 'showcase/ds_gallery.dart';

void main() {
  runApp(const MobileApp());
}

class MobileApp extends StatelessWidget {
  const MobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Turbi Mobile',
      debugShowCheckedModeBanner: false,
      theme: DsTheme.light(),
      home: const DsGallery(),
    );
  }
}
