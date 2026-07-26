import 'package:flutter/material.dart';

import 'package:design_system/design_system.dart';

import 'ds_gallery.dart';

void main() {
  runApp(const DesignSystemExampleApp());
}

/// Standalone showcase app for the [design_system] package.
class DesignSystemExampleApp extends StatelessWidget {
  const DesignSystemExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Design System',
      debugShowCheckedModeBanner: false,
      theme: DsTheme.light(),
      home: const DsGallery(),
    );
  }
}
