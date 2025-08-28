import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/providers/pantry_provider.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../domain/services/pantry_service.dart';

class ExpiryNotificationsWidget extends ConsumerWidget {
  const ExpiryNotificationsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(expiryNotificationsProvider);
    final theme = Theme.of(context);

    return notificationsAsync.when(
      data: (notifications) {
        if (notifications.isEmpty) return const SizedBox.shrink();

        // Group notifications by priority
        final urgentNotifications = notifications
            .where((n) => n.priority == NotificationPriority.urgent)
            .toList();
        final highNotifications = notifications
            .where((n) => n.priority == NotificationPriority.high)
            .toList();
        final mediumNotifications = notifications
            .where((n) => n.priority == NotificationPriority.medium)
            .toList();

        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: DesignTokens.spacingMd,
            vertical: DesignTokens.spacingSm,
          ),
          child: Column(
            children: [
              // Urgent notifications (expired items)
              if (urgentNotifications.isNotEmpty)
                _buildNotificationCard(
                  context,
                  theme,
                  'Expired Items',
                  urgentNotifications,
                  Colors.red,
                  Icons.error,
                ),

              // High priority notifications (expiring today/tomorrow)
              if (highNotifications.isNotEmpty) ...[
                if (urgentNotifications.isNotEmpty)
                  const SizedBox(height: DesignTokens.spacingSm),
                _buildNotificationCard(
                  context,
                  theme,
                  'Expiring Soon',
                  highNotifications,
                  Colors.orange,
                  Icons.warning,
                ),
              ],

              // Medium priority notifications (expiring this week)
              if (mediumNotifications.isNotEmpty) ...[
                if (urgentNotifications.isNotEmpty || highNotifications.isNotEmpty)
                  const SizedBox(height: DesignTokens.spacingSm),
                _buildNotificationCard(
                  context,
                  theme,
                  'Expiring This Week',
                  mediumNotifications,
                  Colors.amber,
                  Icons.schedule,
                ),
              ],
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => const SizedBox.shrink(),
    );
  }

  Widget _buildNotificationCard(
    BuildContext context,
    ThemeData theme,
    String title,
    List<ExpiryNotification> notifications,
    Color color,
    IconData icon,
  ) {
    return Card(
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: ExpansionTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          title: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          subtitle: Text(
            '${notifications.length} item${notifications.length == 1 ? '' : 's'}',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: color.withOpacity(0.8),
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () => _showRecipeSuggestions(context, notifications),
                child: const Text('Recipes'),
              ),
              const Icon(Icons.expand_more),
            ],
          ),
          children: notifications.map((notification) {
            return _buildNotificationItem(context, theme, notification, color);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildNotificationItem(
    BuildContext context,
    ThemeData theme,
    ExpiryNotification notification,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacingMd,
        vertical: DesignTokens.spacingSm,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        border: Border(
          top: BorderSide(color: color.withOpacity(0.1)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.itemName,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _getExpiryMessage(notification),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (notification.suggestedRecipes.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Suggested: ${notification.suggestedRecipes.take(2).join(', ')}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: () => _showItemActions(context, notification),
                icon: const Icon(Icons.more_vert),
                iconSize: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getExpiryMessage(ExpiryNotification notification) {
    final days = notification.daysUntilExpiry;
    
    if (days < 0) {
      final daysExpired = -days;
      return 'Expired ${daysExpired} day${daysExpired == 1 ? '' : 's'} ago';
    } else if (days == 0) {
      return 'Expires today';
    } else if (days == 1) {
      return 'Expires tomorrow';
    } else {
      return 'Expires in $days days';
    }
  }

  void _showRecipeSuggestions(BuildContext context, List<ExpiryNotification> notifications) {
    final allRecipes = notifications
        .expand((n) => n.suggestedRecipes)
        .toSet()
        .toList();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Recipe Suggestions'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Use your expiring items with these recipes:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: DesignTokens.spacingMd),
            ...allRecipes.take(8).map((recipe) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  const Icon(Icons.restaurant, size: 16),
                  const SizedBox(width: DesignTokens.spacingSm),
                  Expanded(child: Text(recipe)),
                ],
              ),
            )),
            if (allRecipes.length > 8)
              Text(
                '... and ${allRecipes.length - 8} more recipes',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Navigate to recipe generation with ingredients
            },
            child: const Text('Generate Recipe'),
          ),
        ],
      ),
    );
  }

  void _showItemActions(BuildContext context, ExpiryNotification notification) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(DesignTokens.spacingMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.restaurant),
              title: const Text('Find Recipes'),
              subtitle: const Text('Get recipes using this ingredient'),
              onTap: () {
                Navigator.of(context).pop();
                _showRecipeSuggestions(context, [notification]);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Update Item'),
              subtitle: const Text('Edit quantity or expiry date'),
              onTap: () {
                Navigator.of(context).pop();
                // TODO: Open edit item modal
              },
            ),
            ListTile(
              leading: const Icon(Icons.remove_circle),
              title: const Text('Mark as Used'),
              subtitle: const Text('Remove from pantry'),
              onTap: () {
                Navigator.of(context).pop();
                // TODO: Show use item dialog
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications_off),
              title: const Text('Dismiss Notification'),
              subtitle: const Text('Hide this notification'),
              onTap: () {
                Navigator.of(context).pop();
                // TODO: Dismiss notification
              },
            ),
          ],
        ),
      ),
    );
  }
}