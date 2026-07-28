import '../entities/chat_message.dart';

/// Domain contract for the AI assistant conversation.
abstract interface class AssistantRepository {
  Future<List<ChatMessage>> getConversation();

  Future<ChatMessage> sendMessage(String text);
}
