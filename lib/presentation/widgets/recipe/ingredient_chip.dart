import 'package:flutter/material.dart';

class IngredientChip extends StatelessWidget {
  final String name;
  final String? quantity;
  final String? unit;
  final bool isAvailable;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onToggle;
  final Color? color;
  final bool showQuantity;

  const IngredientChip({
    super.key,
    required this.name,
    this.quantity,
    this.unit,
    this.isAvailable = true,
    this.isSelected = false,
    this.onTap,
    this.onToggle,
    this.color,
    this.showQuantity = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chipColor = color ?? (isAvailable ? Colors.green : Colors.orange);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8, bottom: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? chipColor.withOpacity(0.2)
              : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? chipColor : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Availability indicator
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: chipColor,
                  shape: BoxShape.circle,
                ),
              ),

              const SizedBox(width: 8),

              // Ingredient text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isSelected ? chipColor : null,
                    ),
                  ),
                  if (showQuantity && quantity != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      '$quantity${unit != null ? ' $unit' : ''}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ],
              ),

              // Toggle button
              if (onToggle != null) ...[
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onToggle,
                  child: Icon(
                    isSelected ? Icons.check_circle : Icons.circle_outlined,
                    size: 16,
                    color: isSelected
                        ? chipColor
                        : theme.colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class EditableIngredientChip extends StatefulWidget {
  final String initialName;
  final String? initialQuantity;
  final String? initialUnit;
  final ValueChanged<Map<String, String>>? onChanged;
  final VoidCallback? onDelete;

  const EditableIngredientChip({
    super.key,
    required this.initialName,
    this.initialQuantity,
    this.initialUnit,
    this.onChanged,
    this.onDelete,
  });

  @override
  State<EditableIngredientChip> createState() => _EditableIngredientChipState();
}

class _EditableIngredientChipState extends State<EditableIngredientChip> {
  late TextEditingController _nameController;
  late TextEditingController _quantityController;
  late TextEditingController _unitController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _quantityController =
        TextEditingController(text: widget.initialQuantity ?? '');
    _unitController = TextEditingController(text: widget.initialUnit ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_isEditing) {
      return Container(
        margin: const EdgeInsets.only(right: 8, bottom: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: theme.colorScheme.primary),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Ingredient',
                isDense: true,
              ),
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _quantityController,
                    decoration: const InputDecoration(
                      labelText: 'Quantity',
                      isDense: true,
                    ),
                    style: theme.textTheme.bodySmall,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _unitController,
                    decoration: const InputDecoration(
                      labelText: 'Unit',
                      isDense: true,
                    ),
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => setState(() => _isEditing = false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: _saveChanges,
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () => setState(() => _isEditing = true),
      child: Container(
        margin: const EdgeInsets.only(right: 8, bottom: 8),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _nameController.text,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (_quantityController.text.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      '${_quantityController.text}${_unitController.text.isNotEmpty ? ' ${_unitController.text}' : ''}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ],
              ),
              if (widget.onDelete != null) ...[
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: widget.onDelete,
                  child: Icon(
                    Icons.close,
                    size: 16,
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _saveChanges() {
    widget.onChanged?.call({
      'name': _nameController.text,
      'quantity': _quantityController.text,
      'unit': _unitController.text,
    });
    setState(() => _isEditing = false);
  }
}

class IngredientChipList extends StatelessWidget {
  final List<Map<String, dynamic>> ingredients;
  final Function(int)? onIngredientToggle;
  final Function(int)? onIngredientTap;
  final bool showAvailability;
  final bool allowSelection;
  final ScrollPhysics? scrollPhysics;

  const IngredientChipList({
    super.key,
    required this.ingredients,
    this.onIngredientToggle,
    this.onIngredientTap,
    this.showAvailability = true,
    this.allowSelection = false,
    this.scrollPhysics,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: ingredients.asMap().entries.map((entry) {
        final index = entry.key;
        final ingredient = entry.value;

        return IngredientChip(
          name: ingredient['name'] ?? '',
          quantity: ingredient['quantity']?.toString(),
          unit: ingredient['unit'],
          isAvailable:
              showAvailability ? (ingredient['isAvailable'] ?? true) : true,
          isSelected:
              allowSelection ? (ingredient['isSelected'] ?? false) : false,
          onTap: onIngredientTap != null ? () => onIngredientTap!(index) : null,
          onToggle: onIngredientToggle != null
              ? () => onIngredientToggle!(index)
              : null,
        );
      }).toList(),
    );
  }
}
