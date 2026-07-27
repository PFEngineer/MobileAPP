import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Showcase of the [design_system] components.
///
/// Each atomic-design tab (Átomos / Moléculas / Organismos) is a **list** of
/// [DsButton] entries; tapping one opens a detail page with that component
/// group in isolation.
class DsGallery extends StatefulWidget {
  const DsGallery({super.key});

  @override
  State<DsGallery> createState() => _DsGalleryState();
}

class _DsGalleryState extends State<DsGallery> {
  int _tab = 0;

  static const List<String> _tabs = <String>['Átomos', 'Moléculas', 'Organismos'];

  List<_Entry> _entriesFor(int tab) => switch (tab) {
        0 => _atoms,
        1 => _molecules,
        _ => _organisms,
      };

  static const List<_Entry> _atoms = <_Entry>[
    _Entry('Botões — estilos', _ButtonStylesDemo()),
    _Entry('Botões — estados & ícones', _ButtonStatesDemo()),
    _Entry('Campos de texto', _TextFieldsDemo()),
    _Entry('Seleção', _SelectionDemo()),
    _Entry('Chips (filtros)', _ChipsDemo()),
    _Entry('Tags & Status', _TagsStatusDemo()),
    _Entry('Avatares & Badges', _AvatarsBadgesDemo()),
    _Entry('Progress & Indicador', _ProgressDemo()),
  ];

  static const List<_Entry> _molecules = <_Entry>[
    _Entry('Card', _CardDemo()),
    _Entry('List Item', _ListItemDemo()),
  ];

  static const List<_Entry> _organisms = <_Entry>[
    _Entry('Top App Bar', _AppBarDemo()),
    _Entry('Tabs', _TabsDemo()),
    _Entry('Bottom Navigation', _BottomNavDemo()),
  ];

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;
    final List<_Entry> entries = _entriesFor(_tab);

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
      body: Column(
        children: <Widget>[
          DsTabs(
            tabs: _tabs,
            selectedIndex: _tab,
            onChanged: (i) => setState(() => _tab = i),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(DsSpacing.lg),
              itemCount: entries.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(height: DsSpacing.sm),
              itemBuilder: (context, i) {
                final _Entry entry = entries[i];
                return DsButton(
                  label: entry.title,
                  variant: DsButtonVariant.outline,
                  size: DsButtonSize.large,
                  expanded: true,
                  trailingIcon: DsIcons.arrowRight,
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) =>
                          _DetailPage(title: entry.title, child: entry.demo),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// A single showcase entry: a title (used as the list label and the detail
/// page title) and the widget demonstrating that component group.
class _Entry {
  const _Entry(this.title, this.demo);

  final String title;
  final Widget demo;
}

/// Detail page that renders one component group under a [DsAppBar].
class _DetailPage extends StatelessWidget {
  const _DetailPage({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DsAppBar(
        title: title,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: context.dsColors.textSecondary),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DsSpacing.lg),
        child: Align(
          alignment: Alignment.topLeft,
          child: child,
        ),
      ),
    );
  }
}

// ===========================================================================
// Atoms
// ===========================================================================

class _ButtonStylesDemo extends StatelessWidget {
  const _ButtonStylesDemo();

  @override
  Widget build(BuildContext context) {
    return Wrap(
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
    );
  }
}

class _ButtonStatesDemo extends StatelessWidget {
  const _ButtonStatesDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          spacing: DsSpacing.sm,
          runSpacing: DsSpacing.sm,
          children: <Widget>[
            DsButton(label: 'Com ícone', icon: DsIcons.plus, onPressed: () {}),
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
      ],
    );
  }
}

class _TextFieldsDemo extends StatefulWidget {
  const _TextFieldsDemo();

  @override
  State<_TextFieldsDemo> createState() => _TextFieldsDemoState();
}

class _TextFieldsDemoState extends State<_TextFieldsDemo> {
  final TextEditingController _controller = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
      ],
    );
  }
}

class _SelectionDemo extends StatefulWidget {
  const _SelectionDemo();

  @override
  State<_SelectionDemo> createState() => _SelectionDemoState();
}

class _SelectionDemoState extends State<_SelectionDemo> {
  bool _checked = true;
  bool _switched = true;
  String _radio = 'a';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
      ],
    );
  }
}

class _ChipsDemo extends StatefulWidget {
  const _ChipsDemo();

  @override
  State<_ChipsDemo> createState() => _ChipsDemoState();
}

class _ChipsDemoState extends State<_ChipsDemo> {
  final Set<String> _filters = <String>{'suv'};

  static const Map<String, String> _options = <String, String>{
    'suv': 'SUV',
    'hatch': 'Hatch',
    'sedan': 'Sedan',
  };

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: DsSpacing.sm,
      runSpacing: DsSpacing.sm,
      children: <Widget>[
        for (final MapEntry<String, String> entry in _options.entries)
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
    );
  }
}

class _TagsStatusDemo extends StatelessWidget {
  const _TagsStatusDemo();

  @override
  Widget build(BuildContext context) {
    return Wrap(
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
    );
  }
}

class _AvatarsBadgesDemo extends StatelessWidget {
  const _AvatarsBadgesDemo();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const DsAvatar(initials: 'PF', showStatus: true),
        const SizedBox(width: DsSpacing.md),
        const DsAvatar(initials: 'AC', size: DsAvatarSize.lg),
        const SizedBox(width: DsSpacing.lg),
        DsBadge.count(12, child: const DsAvatar(initials: 'MK')),
      ],
    );
  }
}

class _ProgressDemo extends StatelessWidget {
  const _ProgressDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        DsLinearProgress(value: 0.6),
        SizedBox(height: DsSpacing.lg),
        Row(
          children: <Widget>[
            DsCircularProgress(value: 0.7, size: 32),
            SizedBox(width: DsSpacing.lg),
            DsIndicator(count: 4, current: 1),
          ],
        ),
      ],
    );
  }
}

// ===========================================================================
// Molecules
// ===========================================================================

class _CardDemo extends StatelessWidget {
  const _CardDemo();

  @override
  Widget build(BuildContext context) {
    return DsCard(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              DsAvatar(initials: 'AC'),
              SizedBox(width: DsSpacing.md),
              Expanded(child: Text('Acme Inc.', style: DsTypography.heading3)),
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
    );
  }
}

class _ListItemDemo extends StatelessWidget {
  const _ListItemDemo();

  @override
  Widget build(BuildContext context) {
    return DsCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: <Widget>[
          DsListItem(
            leading: const DsAvatar(initials: 'JS'),
            title: 'João Silva',
            subtitle: 'Reserva confirmada • Hoje 14h',
            trailing:
                Icon(DsIcons.arrowRight, color: context.dsColors.textTertiary),
            onTap: () {},
          ),
          Divider(height: 1, color: context.dsColors.border),
          DsListItem(
            leading: const DsAvatar(initials: 'AM', size: DsAvatarSize.sm),
            title: 'Ana Martins',
            subtitle: 'Viagem em andamento',
            trailing: const DsStatus(label: 'Ativa', tone: DsTone.success),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// Organisms
// ===========================================================================

class _AppBarDemo extends StatelessWidget {
  const _AppBarDemo();

  @override
  Widget build(BuildContext context) {
    // Zero the top safe-area inset so the preview isn't pushed down inside the
    // detail page.
    return DsCard(
      padding: EdgeInsets.zero,
      elevated: false,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: DsAppBar(
          title: 'Minhas viagens',
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: context.dsColors.textSecondary),
            onPressed: () {},
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(DsIcons.search, color: context.dsColors.textSecondary),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _TabsDemo extends StatefulWidget {
  const _TabsDemo();

  @override
  State<_TabsDemo> createState() => _TabsDemoState();
}

class _TabsDemoState extends State<_TabsDemo> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return DsTabs(
      tabs: const <String>['Ativas', 'Histórico', 'Canceladas'],
      selectedIndex: _index,
      onChanged: (i) => setState(() => _index = i),
    );
  }
}

class _BottomNavDemo extends StatefulWidget {
  const _BottomNavDemo();

  @override
  State<_BottomNavDemo> createState() => _BottomNavDemoState();
}

class _BottomNavDemoState extends State<_BottomNavDemo> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return DsCard(
      padding: EdgeInsets.zero,
      elevated: false,
      child: DsBottomNavigation(
        currentIndex: _index,
        onChanged: (i) => setState(() => _index = i),
        items: const <DsBottomNavItem>[
          DsBottomNavItem(icon: DsIcons.home, label: 'Início'),
          DsBottomNavItem(icon: DsIcons.wallet, label: 'Carteira'),
          DsBottomNavItem(icon: DsIcons.heart, label: 'Favoritos'),
          DsBottomNavItem(icon: DsIcons.star, label: 'Perfil'),
        ],
      ),
    );
  }
}
