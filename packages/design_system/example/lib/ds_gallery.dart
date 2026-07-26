import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Interactive showcase of the [design_system] components, grouped by the
/// atomic-design layers. Doubles as a smoke screen and living documentation.
class DsGallery extends StatefulWidget {
  const DsGallery({super.key});

  @override
  State<DsGallery> createState() => _DsGalleryState();
}

class _DsGalleryState extends State<DsGallery> {
  int _tab = 0;
  int _navIndex = 0;
  bool _checked = true;
  bool _switched = true;
  String _radio = 'a';
  final Set<String> _filters = <String>{'suv'};
  final TextEditingController _controller = TextEditingController();
  bool _obscure = true;

  static const List<String> _tabs = <String>['Átomos', 'Moléculas', 'Organismos'];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;

    return Scaffold(
      appBar: DsAppBar(
        title: 'Design System',
        actions: <Widget>[
          DsBadge.count(
            3,
            child: IconButton(
              icon: Icon(DsIcons.bell, color: ds.textSecondary),
              onPressed: () {},
            ),
          ),
        ],
      ),
      bottomNavigationBar: DsBottomNavigation(
        currentIndex: _navIndex,
        onChanged: (i) => setState(() => _navIndex = i),
        items: const <DsBottomNavItem>[
          DsBottomNavItem(icon: DsIcons.home, label: 'Início'),
          DsBottomNavItem(icon: DsIcons.search, label: 'Buscar'),
          DsBottomNavItem(icon: DsIcons.wallet, label: 'Carteira'),
          DsBottomNavItem(icon: DsIcons.chart, label: 'Relatórios'),
        ],
      ),
      body: Column(
        children: <Widget>[
          DsTabs(
            tabs: _tabs,
            selectedIndex: _tab,
            onChanged: (i) => setState(() => _tab = i),
          ),
          Expanded(
            child: switch (_tab) {
              0 => _atoms(),
              1 => _molecules(),
              _ => _organisms(),
            },
          ),
        ],
      ),
    );
  }

  Widget _atoms() => ListView(
        padding: const EdgeInsets.all(DsSpacing.lg),
        children: <Widget>[
          _section('Botões — estilos'),
          Wrap(
            spacing: DsSpacing.sm,
            runSpacing: DsSpacing.sm,
            children: <Widget>[
              DsButton(label: 'Primário', onPressed: () {}),
              DsButton(
                label: 'Secundário',
                variant: DsButtonVariant.secondary,
                onPressed: () {},
              ),
              DsButton(
                label: 'Outline',
                variant: DsButtonVariant.outline,
                onPressed: () {},
              ),
              DsButton(
                label: 'Texto',
                variant: DsButtonVariant.text,
                onPressed: () {},
              ),
              DsButton(
                label: 'Destrutivo',
                variant: DsButtonVariant.destructive,
                onPressed: () {},
              ),
            ],
          ),
          _section('Botões — estados & ícones'),
          Wrap(
            spacing: DsSpacing.sm,
            runSpacing: DsSpacing.sm,
            children: <Widget>[
              DsButton(
                label: 'Com ícone',
                icon: DsIcons.plus,
                onPressed: () {},
              ),
              const DsButton(label: 'Loading', onPressed: null, isLoading: true),
              const DsButton(label: 'Disabled', onPressed: null),
            ],
          ),
          const SizedBox(height: DsSpacing.md),
          DsButton(
            label: 'Largura total',
            icon: DsIcons.arrowRight,
            expanded: true,
            size: DsButtonSize.large,
            onPressed: () {},
          ),
          _section('Campos de texto'),
          DsTextField(
            controller: _controller,
            label: 'E-mail',
            hint: 'voce@email.com',
            prefixIcon: DsIcons.search,
            helperText: 'Usamos seu e-mail apenas para login.',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: DsSpacing.lg),
          DsTextField(
            label: 'Senha',
            hint: '••••••••',
            obscureText: _obscure,
            suffixIcon: _obscure ? DsIcons.eye : DsIcons.close,
            onSuffixTap: () => setState(() => _obscure = !_obscure),
            errorText: 'Senha muito curta',
          ),
          _section('Seleção'),
          DsCheckbox(
            value: _checked,
            label: 'Aceito os termos',
            onChanged: (v) => setState(() => _checked = v),
          ),
          DsRadio<String>(
            value: 'a',
            groupValue: _radio,
            label: 'Cartão de crédito',
            onChanged: (v) => setState(() => _radio = v),
          ),
          DsRadio<String>(
            value: 'b',
            groupValue: _radio,
            label: 'Pix',
            onChanged: (v) => setState(() => _radio = v),
          ),
          DsSwitch(
            value: _switched,
            label: 'Notificações push',
            onChanged: (v) => setState(() => _switched = v),
          ),
          _section('Chips (filtros)'),
          Wrap(
            spacing: DsSpacing.sm,
            children: <Widget>[
              for (final entry in const <String, String>{
                'suv': 'SUV',
                'hatch': 'Hatch',
                'sedan': 'Sedan',
              }.entries)
                DsChip(
                  label: entry.value,
                  selected: _filters.contains(entry.key),
                  onSelected: (sel) => setState(() {
                    if (sel) {
                      _filters.add(entry.key);
                    } else {
                      _filters.remove(entry.key);
                    }
                  }),
                ),
            ],
          ),
          _section('Tags & Status'),
          Wrap(
            spacing: DsSpacing.sm,
            runSpacing: DsSpacing.sm,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const <Widget>[
              DsTag(label: 'Novo', tone: DsTone.primary),
              DsTag(label: 'Ativo', tone: DsTone.success),
              DsTag(label: 'Atrasado', tone: DsTone.danger),
              DsTag(label: 'Pendente', tone: DsTone.warning),
              DsStatus(label: 'Disponível', tone: DsTone.success),
              DsStatus(label: 'Em viagem', tone: DsTone.info),
            ],
          ),
          _section('Avatares & Badges'),
          Row(
            children: <Widget>[
              const DsAvatar(initials: 'PF', showStatus: true),
              const SizedBox(width: DsSpacing.md),
              const DsAvatar(initials: 'AC', size: DsAvatarSize.lg),
              const SizedBox(width: DsSpacing.lg),
              DsBadge.count(12, child: const DsAvatar(initials: 'MK')),
            ],
          ),
          _section('Progress & Indicador'),
          const DsLinearProgress(value: 0.6),
          const SizedBox(height: DsSpacing.lg),
          Row(
            children: const <Widget>[
              DsCircularProgress(value: 0.7, size: 32),
              SizedBox(width: DsSpacing.lg),
              DsIndicator(count: 4, current: 1),
            ],
          ),
          const SizedBox(height: DsSpacing.xl4),
        ],
      );

  Widget _molecules() => ListView(
        padding: const EdgeInsets.all(DsSpacing.lg),
        children: <Widget>[
          _section('Card'),
          DsCard(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: const <Widget>[
                    DsAvatar(initials: 'AC'),
                    SizedBox(width: DsSpacing.md),
                    Expanded(
                      child: Text('Acme Inc.',
                          style: DsTypography.heading3),
                    ),
                    DsTag(label: 'Premium', tone: DsTone.primary),
                  ],
                ),
                const SizedBox(height: DsSpacing.md),
                Text(
                  'Cartão de superfície com raio, borda e sombra dos tokens.',
                  style: DsTypography.bodyMedium
                      .copyWith(color: context.dsColors.textSecondary),
                ),
              ],
            ),
          ),
          _section('List Item'),
          DsCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: <Widget>[
                DsListItem(
                  leading: const DsAvatar(initials: 'JS'),
                  title: 'João Silva',
                  subtitle: 'Reserva confirmada • Hoje 14h',
                  trailing: Icon(DsIcons.arrowRight,
                      color: context.dsColors.textTertiary),
                  onTap: () {},
                ),
                Divider(height: 1, color: context.dsColors.border),
                DsListItem(
                  leading: const DsAvatar(initials: 'AM', size: DsAvatarSize.sm),
                  title: 'Ana Martins',
                  subtitle: 'Viagem em andamento',
                  trailing: const DsStatus(
                      label: 'Ativa', tone: DsTone.success),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: DsSpacing.xl4),
        ],
      );

  Widget _organisms() => ListView(
        padding: const EdgeInsets.all(DsSpacing.lg),
        children: <Widget>[
          _section('Top App Bar'),
          DsCard(
            padding: EdgeInsets.zero,
            elevated: false,
            child: DsAppBar(
              title: 'Minhas viagens',
              leading: IconButton(
                icon: Icon(DsIcons.arrowRight,
                    color: context.dsColors.textSecondary),
                onPressed: () {},
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(DsIcons.search,
                      color: context.dsColors.textSecondary),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          _section('Tabs'),
          DsTabs(
            tabs: const <String>['Ativas', 'Histórico', 'Canceladas'],
            selectedIndex: _tab.clamp(0, 2),
            onChanged: (i) => setState(() => _tab = i),
          ),
          _section('Bottom Navigation'),
          DsCard(
            padding: EdgeInsets.zero,
            elevated: false,
            child: DsBottomNavigation(
              currentIndex: _navIndex,
              onChanged: (i) => setState(() => _navIndex = i),
              items: const <DsBottomNavItem>[
                DsBottomNavItem(icon: DsIcons.home, label: 'Início'),
                DsBottomNavItem(icon: DsIcons.wallet, label: 'Carteira'),
                DsBottomNavItem(icon: DsIcons.heart, label: 'Favoritos'),
                DsBottomNavItem(icon: DsIcons.star, label: 'Perfil'),
              ],
            ),
          ),
          const SizedBox(height: DsSpacing.xl4),
        ],
      );

  Widget _section(String title) => Padding(
        padding: const EdgeInsets.only(
          top: DsSpacing.xl,
          bottom: DsSpacing.md,
        ),
        child: Text(
          title,
          style: DsTypography.labelMedium.copyWith(
            color: context.dsColors.textTertiary,
            fontWeight: DsTypography.semiBold,
            letterSpacing: 0.5,
          ),
        ),
      );
}
