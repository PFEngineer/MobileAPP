import '../entities/chat_message.dart';
import '../repositories/assistant_repository.dart';

/// Loads the existing conversation.
class GetConversation {
  const GetConversation(this._repository);

  final AssistantRepository _repository;

  Future<List<ChatMessage>> call() => _repository.getConversation();
}

/// Sends a user message and returns the assistant's reply.
class SendAssistantMessage {
  const SendAssistantMessage(this._repository);

  final AssistantRepository _repository;

  Future<ChatMessage> call(String text) => _repository.sendMessage(text);
}
