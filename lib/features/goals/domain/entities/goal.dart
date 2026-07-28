import 'package:flutter/foundation.dart';

/// A savings goal (Figma 06. Metas cards).
@immutable
class Goal {
  const Goal({
    required this.name,
    required this.target,
    required this.saved,
    required this.deadlineLabel,
    this.suggestedMonthlyContribution,
    this.projectedReturnLabel,
  });

  final String name;
  final double target;
  final double saved;
  final String deadlineLabel;
  final double? suggestedMonthlyContribution;
  final String? projectedReturnLabel;

  double get progress => target == 0 ? 0 : (saved / target).clamp(0, 1);
  double get remaining => (target - saved).clamp(0, double.infinity);
}
