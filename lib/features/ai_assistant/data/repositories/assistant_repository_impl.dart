import '../../domain/entities/chat_message.dart';
import '../../domain/repositories/assistant_repository.dart';
import '../datasources/assistant_local_data_source.dart';

/// Data-layer implementation of [AssistantRepository], backed by fixtures.
class AssistantRepositoryImpl implements AssistantRepository {
  const AssistantRepositoryImpl(this._dataSource);

  final AssistantLocalDataSource _dataSource;

  @override
  Future<List<ChatMessage>> getConversation() =>
      _dataSource.fetchConversation();

  @override
  Future<ChatMessage> sendMessage(String text) => _dataSource.reply(text);
}
