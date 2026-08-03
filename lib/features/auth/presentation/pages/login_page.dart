import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:invest_app/core/analytics/analytics_service.dart';
import 'package:design_system/design_system.dart';

import '../../../../core/format/cpf_input_formatter.dart';
import '../viewmodels/login_view_model.dart';
import '../widgets/investai_logo.dart';

/// 11. Login — Figma node 145:473.
class LoginPage extends StatefulWidget {
  const LoginPage({required this.viewModel, this.onLoggedIn, super.key});

  final LoginViewModel viewModel;

  /// Central navigation hook fired after a successful login.
  final VoidCallback? onLoggedIn;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    AnalyticsService.trackScreenView('Login');
  }

  @override
  void dispose() {
    _cpfController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    AnalyticsService.trackClick('Entrar');
    final bool ok = await widget.viewModel.submit();
    if (ok && mounted) widget.onLoggedIn?.call();
  }

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: DsColors.neutral50,
        body: SafeArea(
          child: ListenableBuilder(
            listenable: widget.viewModel,
            builder: (context, _) {
              final vm = widget.viewModel;
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  DsSpacing.lg,
                  DsSpacing.xl3,
                  DsSpacing.lg,
                  DsSpacing.xl,
                ),
                child: Column(
                  children: <Widget>[
                    const InvestaiLogo(),
                    const SizedBox(height: DsSpacing.lg),
                    Text(
                      'Sua inteligência para investir melhor',
                      textAlign: TextAlign.center,
                      style: DsTypography.bodyLarge
                          .copyWith(color: ds.textSecondary),
                    ),
                    const SizedBox(height: DsSpacing.xl2),
                    _LoginCard(
                      viewModel: vm,
                      cpfController: _cpfController,
                      passwordController: _passwordController,
                      onSubmit: _submit,
                    ),
                    const SizedBox(height: DsSpacing.xl2),
                    Text(
                      'Ainda não tem uma conta?',
                      textAlign: TextAlign.center,
                      style: DsTypography.bodyMedium
                          .copyWith(color: ds.textSecondary),
                    ),
                    const SizedBox(height: DsSpacing.xs),
                    _LinkText(
                      'Criar conta gratuita',
                      fontSize: 15,
                      onTap: () =>
                          AnalyticsService.trackClick('Criar conta gratuita'),
                    ),
                    const SizedBox(height: DsSpacing.xl),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.lock_outline,
                          size: 14,
                          color: ds.textSecondary,
                        ),
                        const SizedBox(width: DsSpacing.xs),
                        Text(
                          'Seus dados estão protegidos',
                          style: DsTypography.caption.copyWith(
                            fontSize: 13,
                            color: ds.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: DsSpacing.md),
                    _LinkText(
                      'Política de Privacidade',
                      onTap: () => AnalyticsService.trackClick(
                        'Política de Privacidade',
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _LoginCard extends StatelessWidget {
  const _LoginCard({
    required this.viewModel,
    required this.cpfController,
    required this.passwordController,
    required this.onSubmit,
  });

  final LoginViewModel viewModel;
  final TextEditingController cpfController;
  final TextEditingController passwordController;
  final Future<void> Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(DsSpacing.xl2),
      decoration: BoxDecoration(
        color: ds.surface,
        borderRadius: DsRadius.xlAll,
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x1A101828),
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Bem-vindo de volta! 👋',
            style: DsTypography.heading2,
          ),
          const SizedBox(height: 6),
          Text(
            'Faça login para acessar sua conta',
            style: DsTypography.bodyMedium.copyWith(color: ds.textSecondary),
          ),
          const SizedBox(height: DsSpacing.xl),
          DsTextField(
            label: 'CPF',
            controller: cpfController,
            hint: '000.000.000-00',
            helperText: 'Digite seu CPF para continuar',
            errorText: viewModel.cpfError,
            prefixIcon: Icons.person_outline,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            inputFormatters: const <TextInputFormatter>[CpfInputFormatter()],
            onChanged: viewModel.setCpf,
          ),
          const SizedBox(height: DsSpacing.xl),
          DsTextField(
            label: 'Senha',
            controller: passwordController,
            hint: 'Digite sua senha',
            errorText: viewModel.passwordError,
            prefixIcon: Icons.lock_outline,
            suffixIcon: viewModel.obscurePassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            onSuffixTap: viewModel.toggleObscurePassword,
            obscureText: viewModel.obscurePassword,
            textInputAction: TextInputAction.done,
            onChanged: viewModel.setPassword,
            onSubmitted: (_) => onSubmit(),
          ),
          const SizedBox(height: DsSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: DsCheckbox(
                  value: viewModel.rememberMe,
                  onChanged: viewModel.setRememberMe,
                  label: 'Lembrar meu acesso',
                ),
              ),
              _LinkText(
                'Esqueci minha senha',
                fontSize: 12.5,
                onTap: () =>
                    AnalyticsService.trackClick('Esqueci minha senha'),
              ),
            ],
          ),
          if (viewModel.formError != null) ...<Widget>[
            const SizedBox(height: DsSpacing.md),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: DsSpacing.md,
                vertical: DsSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: ds.dangerSubtle,
                borderRadius: DsRadius.smAll,
              ),
              child: Row(
                children: <Widget>[
                  Icon(Icons.error_outline, size: 18, color: ds.danger),
                  const SizedBox(width: DsSpacing.sm),
                  Expanded(
                    child: Text(
                      viewModel.formError!,
                      style: DsTypography.bodyMedium
                          .copyWith(fontSize: 13, color: ds.danger),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: DsSpacing.xl),
          DsButton(
            label: 'Entrar',
            trailingIcon: DsIcons.arrowRight,
            expanded: true,
            isLoading: viewModel.isSubmitting,
            onPressed: onSubmit,
          ),
        ],
      ),
    );
  }
}

/// Purple tappable link text (repeated across the login screen).
class _LinkText extends StatelessWidget {
  const _LinkText(this.label, {required this.onTap, this.fontSize = 14});

  final String label;
  final VoidCallback onTap;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: DsRadius.smAll,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
        child: Text(
          label,
          style: DsTypography.bodyMedium.copyWith(
            fontSize: fontSize,
            fontWeight: DsTypography.semiBold,
            color: DsColors.purple600,
          ),
        ),
      ),
    );
  }
}
