import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Placeholder home for the main app, built with the design system.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;

    return Scaffold(
      appBar: DsAppBar(
        title: 'Turbi',
        actions: <Widget>[
          IconButton(
            icon: Icon(DsIcons.bell, color: ds.textSecondary),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(DsSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Bem-vindo', style: DsTypography.heading1),
            const SizedBox(height: DsSpacing.xs),
            Text(
              'App base do Turbi mobile.',
              style:
                  DsTypography.bodyLarge.copyWith(color: ds.textSecondary),
            ),
            const SizedBox(height: DsSpacing.xl),
            DsCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: const <Widget>[
                      DsAvatar(initials: 'TB'),
                      SizedBox(width: DsSpacing.md),
                      Expanded(
                        child: Text('Sua conta', style: DsTypography.heading3),
                      ),
                      DsTag(label: 'Ativa', tone: DsTone.success),
                    ],
                  ),
                  const SizedBox(height: DsSpacing.md),
                  DsButton(
                    label: 'Começar',
                    icon: DsIcons.arrowRight,
                    expanded: true,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
