import 'package:flutter/material.dart';

import 'package:invest_app/core/analytics/analytics_service.dart';
import 'package:design_system/design_system.dart';

import '../../domain/entities/user_profile.dart';
import '../viewmodels/profile_view_model.dart';

/// 10. Perfil — Figma node 78:434.
class ProfilePage extends StatefulWidget {
  const ProfilePage({required this.viewModel, super.key});

  final ProfileViewModel viewModel;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    AnalyticsService.trackScreenView('Perfil');
    widget.viewModel.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, _) {
          final UserProfile? profile = widget.viewModel.profile;
          return ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              _ProfileHero(profile: profile),
              Padding(
                padding: const EdgeInsets.all(DsSpacing.lg),
                child: _ProfileMenu(),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Purple hero with avatar, name, e-mail and Premium badge (Figma 78:435).
class _ProfileHero extends StatelessWidget {
  const _ProfileHero({required this.profile});

  final UserProfile? profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: DsColors.purple600,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            DsSpacing.xl2,
            DsSpacing.xl3,
            DsSpacing.xl2,
            DsSpacing.xl2,
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: DsColors.neutral0,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  profile?.initials ?? '',
                  style: DsTypography.heading2.copyWith(
                    color: DsColors.purple700,
                  ),
                ),
              ),
              const SizedBox(width: DsSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      profile?.name ?? '',
                      style: DsTypography.heading3.copyWith(
                        fontSize: 18,
                        fontWeight: DsTypography.bold,
                        color: DsColors.neutral0,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      profile?.email ?? '',
                      style: DsTypography.bodyMedium.copyWith(
                        fontSize: 13,
                        color: DsColors.neutral0.withValues(alpha: 0.85),
                      ),
                    ),
                    if (profile?.isPremium ?? false) ...<Widget>[
                      const SizedBox(height: DsSpacing.sm),
                      Container(
                        padding: const EdgeInsets.fromLTRB(8, 4, 10, 4),
                        decoration: BoxDecoration(
                          color: DsColors.neutral0.withValues(alpha: 0.18),
                          borderRadius: DsRadius.fullAll,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              '★',
                              style: DsTypography.caption
                                  .copyWith(color: DsColors.neutral0),
                            ),
                            const SizedBox(width: DsSpacing.xs),
                            Text(
                              'Premium',
                              style: DsTypography.labelMedium.copyWith(
                                fontWeight: DsTypography.semiBold,
                                color: DsColors.neutral0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Menu card (Figma 78:456).
class _ProfileMenu extends StatelessWidget {
  const _ProfileMenu();

  @override
  Widget build(BuildContext context) {
    // Figma red/600 — the DS red ramp only ships 500.
    const Color logoutRed = Color(0xFFDC2626);

    return DsCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: <Widget>[
          _MenuItem(
            icon: Icons.person_outline,
            label: 'Dados pessoais',
            onTap: () => AnalyticsService.trackClick('Dados pessoais'),
          ),
          Divider(height: 1, color: DsColors.neutral100),
          _MenuItem(
            icon: Icons.settings_outlined,
            label: 'Configurações da conta',
            onTap: () =>
                AnalyticsService.trackClick('Configurações da conta'),
          ),
          Divider(height: 1, color: DsColors.neutral100),
          _MenuItem(
            icon: DsIcons.bell,
            label: 'Notificações',
            onTap: () => AnalyticsService.trackClick('Notificações'),
          ),
          Divider(height: 1, color: DsColors.neutral100),
          _MenuItem(
            icon: Icons.help_outline,
            label: 'Central de ajuda',
            onTap: () => AnalyticsService.trackClick('Central de ajuda'),
          ),
          Divider(height: 1, color: DsColors.neutral100),
          _MenuItem(
            icon: Icons.logout,
            label: 'Sair da conta',
            color: logoutRed,
            showChevron: false,
            onTap: () => AnalyticsService.trackClick('Sair da conta'),
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
    this.showChevron = true,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;
    final Color contentColor = color ?? ds.textPrimary;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(DsSpacing.lg),
        child: Row(
          children: <Widget>[
            Icon(icon, size: 22, color: color ?? ds.textSecondary),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: DsTypography.bodyLarge.copyWith(
                  fontSize: 15,
                  fontWeight: DsTypography.medium,
                  color: contentColor,
                ),
              ),
            ),
            if (showChevron)
              Icon(Icons.chevron_right, color: ds.textTertiary),
          ],
        ),
      ),
    );
  }
}
