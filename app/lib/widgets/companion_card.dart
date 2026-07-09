import 'package:flutter/material.dart';

class CompanionCard extends StatelessWidget {
  const CompanionCard({
    super.key,
    required this.name,
    required this.mood,
    this.placeholderChild,
    this.backgroundColor,
  });

  final String name;
  final String mood;
  final Widget? placeholderChild;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      color: backgroundColor ?? theme.colorScheme.secondaryContainer..withValues(alpha: 0.55),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final placeholderHeight = constraints.maxWidth > 280
                ? constraints.maxWidth * 0.38
                : 120.0;

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: placeholderHeight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface..withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: placeholderChild ??
                          Icon(
                            Icons.flutter_dash,
                            size: 44,
                            color: theme.colorScheme.primary,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  mood,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
