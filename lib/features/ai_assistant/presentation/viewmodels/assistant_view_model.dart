import 'package:flutter/foundation.dart';

import '../../domain/entities/chat_message.dart';
import '../../domain/usecases/assistant_usecases.dart';

/// Presentation state for the Assistente IA chat (MVVM).
class AssistantViewModel extends ChangeNotifier {
  AssistantViewModel({
    required GetConversation getConversation,
    required SendAssistantMessage sendAssistantMessage,
  })  : _getConversation = getConversation,
        _sendAssistantMessage = sendAssistantMessage;

  final GetConversation _getConversation;
  final SendAssistantMessage _sendAssistantMessage;

  List<ChatMessage> _messages = const <ChatMessage>[];
  bool _isReplying = false;

  List<ChatMessage> get messages => _messages;
  bool get isReplying => _isReplying;

  Future<void> load() async {
    _messages = await _getConversation();
    notifyListeners();
  }

  Future<void> send(String text) async {
    final String trimmed = text.trim();
    if (trimmed.isEmpty || _isReplying) return;
    _messages = <ChatMessage>[
      ..._messages,
      ChatMessage(isUser: true, text: trimmed),
    ];
    _isReplying = true;
    notifyListeners();
    try {
      final ChatMessage reply = await _sendAssistantMessage(trimmed);
      _messages = <ChatMessage>[..._messages, reply];
    } finally {
      _isReplying = false;
      notifyListeners();
    }
  }
}
