import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/providers/pantry_provider.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../domain/entities/pantry_item.dart';
import '../../../../shared/widgets/ingredient_chip.dart';

class PantryItemCard extends ConsumerWidget {
  final PantryItem item;
  final bool isCompact;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const PantryItemCard({
    Key? key,
    required this.item,
    this.isCompact = false,
    this.onTap,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isExpiring = _isExpiring();
    final isLowStock = item.isLowStock;
    
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        child: Container(
          padding: const EdgeInsets.all(DesignTokens.spacingMd),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
            border: Border.all(
              color: _getBorderColor(isExpiring, isLowStock),
              width: 1.5,
            ),
          ),
          child: isCompact ? _buildCompactLayout(theme) : _buildFullLayout(theme),
        ),
      ),
    );
  }

  Widget _buildFullLayout(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with category icon and actions
        Row(
          children: [
            Text(
              item.category.icon,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: DesignTokens.spacingSm),
            Expanded(
              child: Text(
                item.name,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            PopupMenuButton<String>(
              onSelected: _handleMenuAction,
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Edit'),
                  ),
                ),
                const PopupMenuItem(
                  value: 'use',
                  child: ListTile(
                    leading: Icon(Icons.remove_circle),
                    title: Text('Mark as Used'),
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: ListTile(
                    leading: Icon(Icons.delete, color: Colors.red),
                    title: Text('Delete'),
                  ),
                ),
              ],
            ),
          ],
        ),
        
        const SizedBox(height: DesignTokens.spacingSm),
        
        // Quantity and unit
        Row(
          children: [
            Icon(
              Icons.inventory_2,
              size: 16,
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
            const SizedBox(width: DesignTokens.spacingXs),
            Text(
              '${item.quantity} ${item.unit}',
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            if (item.isLowStock) ...[
              const SizedBox(width: DesignTokens.spacingSm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: DesignTokens.spacingXs,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusXs),
                  border: Border.all(color: Colors.red.withOpacity(0.3)),
                ),
                child: Text(
                  'LOW',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        
        // Expiry date
        if (item.expiryDate != null) ...[
          const SizedBox(height: DesignTokens.spacingXs),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 16,
                color: _getExpiryColor(),
              ),
              const SizedBox(width: DesignTokens.spacingXs),
              Text(
                _getExpiryText(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: _getExpiryColor(),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
        
        // Location
        if (item.location != null) ...[
          const SizedBox(height: DesignTokens.spacingXs),
          Row(
            children: [
              Icon(
                Icons.place,
                size: 16,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
              const SizedBox(width: DesignTokens.spacingXs),
              Text(
                item.location!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ],
        
        // Brand
        if (item.brand != null) ...[
          const SizedBox(height: DesignTokens.spacingXs),
          Text(
            item.brand!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
        
        const Spacer(),
        
        // Action buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _showQuantityDialog(),
                icon: const Icon(Icons.edit, size: 16),
                label: const Text('Update'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ),
            const SizedBox(width: DesignTokens.spacingSm),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _showUseDialog(),
                icon: const Icon(Icons.remove_circle, size: 16),
                label: const Text('Use'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCompactLayout(ThemeData theme) {
    return Row(
      children: [
        // Category icon
        Text(
          item.category.icon,
          style: const TextStyle(fontSize: 20),
        ),
        
        const SizedBox(width: DesignTokens.spacingSm),
        
        // Item info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Text(
                    '${item.quantity} ${item.unit}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (item.location != null) ...[
                    const SizedBox(width: DesignTokens.spacingSm),
                    Text(
                      '• ${item.location}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ],
              ),
              if (item.expiryDate != null) ...[
                const SizedBox(height: 2),
                Text(
                  _getExpiryText(),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: _getExpiryColor(),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),
        
        // Status indicators
        Column(
          children: [
            if (item.isLowStock)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red.withOpacity(0.3)),
                ),
                child: const Icon(
                  Icons.warning,
                  size: 16,
                  color: Colors.red,
                ),
              ),
            if (_isExpiring()) ...[
              if (item.isLowStock) const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.orange.withOpacity(0.3)),
                ),
                child: const Icon(
                  Icons.schedule,
                  size: 16,
                  color: Colors.orange,
                ),
              ),
            ],
          ],
        ),
        
        const SizedBox(width: DesignTokens.spacingSm),
        
        // Actions menu
        PopupMenuButton<String>(
          onSelected: _handleMenuAction,
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit'),
              ),
            ),
            const PopupMenuItem(
              value: 'use',
              child: ListTile(
                leading: Icon(Icons.remove_circle),
                title: Text('Mark as Used'),
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text('Delete'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  bool _isExpiring() {
    if (item.expiryDate == null) return false;
    final daysUntilExpiry = item.expiryDate!.difference(DateTime.now()).inDays;
    return daysUntilExpiry <= 7 && daysUntilExpiry >= 0;
  }

  Color _getBorderColor(bool isExpiring, bool isLowStock) {
    if (isLowStock) return Colors.red.withOpacity(0.3);
    if (isExpiring) return Colors.orange.withOpacity(0.3);
    return Colors.transparent;
  }

  Color _getExpiryColor() {
    if (item.expiryDate == null) return Colors.grey;
    
    final daysUntilExpiry = item.expiryDate!.difference(DateTime.now()).inDays;
    
    if (daysUntilExpiry < 0) return Colors.red;
    if (daysUntilExpiry <= 1) return Colors.red;
    if (daysUntilExpiry <= 3) return Colors.orange;
    if (daysUntilExpiry <= 7) return Colors.amber;
    
    return Colors.green;
  }

  String _getExpiryText() {
    if (item.expiryDate == null) return 'No expiry date';
    
    final now = DateTime.now();
    final expiry = item.expiryDate!;
    final difference = expiry.difference(now);
    
    if (difference.isNegative) {
      final daysExpired = now.difference(expiry).inDays;
      return 'Expired ${daysExpired} day${daysExpired == 1 ? '' : 's'} ago';
    }
    
    final daysUntilExpiry = difference.inDays;
    
    if (daysUntilExpiry == 0) {
      return 'Expires today';
    } else if (daysUntilExpiry == 1) {
      return 'Expires tomorrow';
    } else if (daysUntilExpiry <= 7) {
      return 'Expires in $daysUntilExpiry days';
    } else {
      return 'Expires ${expiry.day}/${expiry.month}/${expiry.year}';
    }
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'edit':
        onEdit?.call();
        break;
      case 'use':
        _showUseDialog();
        break;
      case 'delete':
        onDelete?.call();
        break;
    }
  }

  void _showQuantityDialog() {
    // TODO: Implement quantity update dialog
  }

  void _showUseDialog() {
    // TODO: Implement use item dialog
  }
}