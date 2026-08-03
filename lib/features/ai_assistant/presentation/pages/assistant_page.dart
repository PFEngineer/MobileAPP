import 'package:flutter/material.dart';

import 'package:invest_app/core/analytics/analytics_service.dart';
import 'package:design_system/design_system.dart';

import '../../domain/entities/chat_message.dart';
import '../viewmodels/assistant_view_model.dart';

/// 08. Assistente IA — Figma node 76:384. Fullscreen chat.
class AssistantPage extends StatefulWidget {
  const AssistantPage({required this.viewModel, super.key});

  final AssistantViewModel viewModel;

  @override
  State<AssistantPage> createState() => _AssistantPageState();
}

class _AssistantPageState extends State<AssistantPage> {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    AnalyticsService.trackScreenView('Assistente IA');
    widget.viewModel.load();
    widget.viewModel.addListener(_scrollToBottom);
  }

  @override
  void dispose() {
    widget.viewModel.removeListener(_scrollToBottom);
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  void _send() {
    AnalyticsService.trackClick('Enviar pergunta');
    widget.viewModel.send(_inputController.text);
    _inputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;

    return Scaffold(
      backgroundColor: ds.surface,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DsSpacing.lg,
                vertical: DsSpacing.sm,
              ),
              child: Row(
                children: <Widget>[
                  InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () => Navigator.of(context).maybePop(),
                    child: Padding(
                      padding: const EdgeInsets.all(DsSpacing.xs),
                      child: Icon(
                        Icons.chevron_left,
                        size: 28,
                        color: ds.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: DsSpacing.xs),
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: ds.primary,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '✦',
                      style: DsTypography.bodyMedium
                          .copyWith(color: DsColors.neutral0),
                    ),
                  ),
                  const SizedBox(width: DsSpacing.sm),
                  Expanded(
                    child: Text(
                      'Assistente IA',
                      style: DsTypography.heading3.copyWith(fontSize: 18),
                    ),
                  ),
                  IconButton(
                    icon: Icon(DsIcons.moreVertical, color: ds.textSecondary),
                    onPressed: () =>
                        AnalyticsService.trackClick('Opções do assistente'),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: DsColors.neutral100),
            Expanded(
              child: ListenableBuilder(
                listenable: widget.viewModel,
                builder: (context, _) {
                  final List<ChatMessage> messages =
                      widget.viewModel.messages;
                  return ListView.separated(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(DsSpacing.lg),
                    itemCount: messages.length,
                    separatorBuilder: (_, int index) =>
                        const SizedBox(height: DsSpacing.md),
                    itemBuilder: (context, int index) =>
                        _ChatBubble(message: messages[index]),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DsSpacing.xl,
                vertical: DsSpacing.md,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(
                        horizontal: DsSpacing.lg,
                      ),
                      decoration: BoxDecoration(
                        color: DsColors.neutral100,
                        borderRadius: DsRadius.fullAll,
                      ),
                      alignment: Alignment.center,
                      child: TextField(
                        controller: _inputController,
                        onSubmitted: (_) => _send(),
                        textInputAction: TextInputAction.send,
                        style: DsTypography.bodyMedium,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          border: InputBorder.none,
                          hintText: 'Pergunte sobre seus investimentos…',
                          hintStyle: DsTypography.bodyMedium.copyWith(
                            color: ds.textTertiary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: DsSpacing.sm),
                  Material(
                    color: ds.primary,
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: _send,
                      child: const SizedBox(
                        width: 44,
                        height: 44,
                        child: Icon(
                          Icons.arrow_upward,
                          color: DsColors.neutral0,
                        ),
                      ),
                    ),
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

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;
    final bool isUser = message.isUser;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 258),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isUser ? ds.primary : DsColors.neutral100,
          borderRadius: DsRadius.lgAll,
        ),
        child: Text(
          message.text,
          style: DsTypography.bodyMedium.copyWith(
            color: isUser ? DsColors.neutral0 : DsColors.neutral800,
          ),
        ),
      ),
    );
  }
}
