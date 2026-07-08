import 'package:flutter/material.dart';

class WaterProgressCard extends StatelessWidget {
  const WaterProgressCard({
    super.key,
    required this.currentGlasses,
    required this.goalGlasses,
    required this.progress,
  });

  final int currentGlasses;
  final int goalGlasses;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progressText = '$currentGlasses / $goalGlasses Glasses';

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '💧 $progressText',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 12,
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation<Color>(
                  theme.colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${(progress * 100).toStringAsFixed(0)}% of your goal reached',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
