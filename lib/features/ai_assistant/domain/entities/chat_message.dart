import 'package:flutter/foundation.dart';

/// One bubble in the assistant chat (Figma 08. Assistente IA).
@immutable
class ChatMessage {
  const ChatMessage({required this.isUser, required this.text});

  final bool isUser;
  final String text;
}
