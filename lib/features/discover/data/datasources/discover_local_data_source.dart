import '../../domain/entities/discover_content.dart';

/// In-memory fixture source — exact content from Figma 09. Descobrir.
class DiscoverLocalDataSource {
  const DiscoverLocalDataSource();

  Future<List<DiscoverInsight>> fetchInsights() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return const <DiscoverInsight>[
      DiscoverInsight(
        title: 'Sua rentabilidade superou o CDI',
        subtitle:
            'Nos últimos 12 meses, você rendeu 16,75% vs 10,72% do CDI.',
        emoji: '🏆',
      ),
    ];
  }

  Future<List<DiscoverContent>> fetchRecommendedContent() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return const <DiscoverContent>[
      DiscoverContent(
        title: 'Como montar uma carteira diversificada',
        readMinutes: 7,
        tone: ContentTone.purple,
      ),
      DiscoverContent(
        title: 'Entenda os principais indicadores financeiros',
        readMinutes: 5,
        tone: ContentTone.blue,
      ),
      DiscoverContent(
        title: 'Guia completo sobre dividendos',
        readMinutes: 8,
        tone: ContentTone.green,
      ),
    ];
  }
}
