import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/providers/pantry_provider.dart';
import '../../../../core/theme/design_tokens.dart';

class PantryStatsWidget extends ConsumerWidget {
  const PantryStatsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(pantryStatsProvider);
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(DesignTokens.spacingMd),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.spacingMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pantry Overview',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: DesignTokens.spacingMd),
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.inventory,
                      label: 'Total Items',
                      value: stats.totalItems.toString(),
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: DesignTokens.spacingSm),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.schedule,
                      label: 'Expiring Soon',
                      value: stats.expiringItems.toString(),
                      color: stats.expiringItems > 0 ? Colors.orange : Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: DesignTokens.spacingSm),
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.warning,
                      label: 'Low Stock',
                      value: stats.lowStockItems.toString(),
                      color: stats.lowStockItems > 0 ? Colors.red : Colors.green,
                    ),
                  ),
                  const SizedBox(width: DesignTokens.spacingSm),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.attach_money,
                      label: 'Est. Value',
                      value: '\$${stats.totalValue.toStringAsFixed(0)}',
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              if (stats.itemsAddedThisWeek > 0 || stats.itemsUsedThisWeek > 0) ...[
                const SizedBox(height: DesignTokens.spacingMd),
                const Divider(),
                const SizedBox(height: DesignTokens.spacingSm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          stats.itemsAddedThisWeek.toString(),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          'Added this week',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          stats.itemsUsedThisWeek.toString(),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          'Used this week',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacingSm),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: DesignTokens.spacingXs),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}