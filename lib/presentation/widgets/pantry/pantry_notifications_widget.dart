import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../application/providers/pantry_provider.dart';

class PantryNotificationsWidget extends ConsumerWidget {
  const PantryNotificationsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(pantryNotificationsProvider);
    final theme = Theme.of(context);

    final expiredCount = notifications['expired']?.length ?? 0;
    final expiringSoonCount = notifications['expiringSoon']?.length ?? 0;
    final lowStockCount = notifications['lowStock']?.length ?? 0;

    if (expiredCount == 0 && expiringSoonCount == 0 && lowStockCount == 0) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.error.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.notifications_active,
                color: theme.colorScheme.error,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Pantry Alerts',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.error,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              if (expiredCount > 0)
                _NotificationChip(
                  label: '$expiredCount expired',
                  color: Colors.red,
                  icon: Icons.warning,
                ),
              if (expiringSoonCount > 0)
                _NotificationChip(
                  label: '$expiringSoonCount expiring soon',
                  color: Colors.orange,
                  icon: Icons.schedule,
                ),
              if (lowStockCount > 0)
                _NotificationChip(
                  label: '$lowStockCount low stock',
                  color: Colors.blue,
                  icon: Icons.inventory_2,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NotificationChip extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;

  const _NotificationChip({
    required this.label,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}