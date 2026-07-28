import '../../domain/entities/chat_message.dart';

/// Fixture conversation from Figma 08. Assistente IA plus a canned reply
/// until a real assistant backend exists.
class AssistantLocalDataSource {
  const AssistantLocalDataSource();

  Future<List<ChatMessage>> fetchConversation() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return const <ChatMessage>[
      ChatMessage(isUser: true, text: 'Como está minha carteira?'),
      ChatMessage(
        isUser: false,
        text: 'Sua carteira está bem diversificada 👍 Você possui exposição '
            'a diferentes classes de ativos. Seu maior peso está em Ações '
            '(55,6%), com concentração em Petrobras. Quer que eu faça uma '
            'análise de risco?',
      ),
      ChatMessage(isUser: true, text: 'Estou muito exposto a bancos?'),
      ChatMessage(
        isUser: false,
        text: 'Você possui 18,2% em ativos do setor financeiro. Isso está '
            'dentro de um nível moderado de risco. Posso sugerir '
            'rebalanceamentos se quiser.',
      ),
    ];
  }

  Future<ChatMessage> reply(String text) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    return const ChatMessage(
      isUser: false,
      text: 'Ainda estou aprendendo sobre sua carteira — em breve terei uma '
          'resposta completa para essa pergunta. 😉',
    );
  }
}
