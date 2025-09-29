import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../application/providers/pantry_provider.dart';
import '../../../domain/entities/pantry_item.dart';

class AddPantryItemDialog extends ConsumerStatefulWidget {
  final PantryItem? item;

  const AddPantryItemDialog({super.key, this.item});

  @override
  ConsumerState<AddPantryItemDialog> createState() =>
      _AddPantryItemDialogState();
}

class _AddPantryItemDialogState extends ConsumerState<AddPantryItemDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _unitController = TextEditingController();
  final _categoryController = TextEditingController();
  final _minStockController = TextEditingController();
  final _notesController = TextEditingController();
  final _locationController = TextEditingController();

  DateTime? _expirationDate;
  bool _isLoading = false;

  final List<String> _commonUnits = [
    'pieces',
    'kg',
    'g',
    'liters',
    'ml',
    'cups',
    'tbsp',
    'tsp',
    'cans',
    'bottles',
    'packages',
    'boxes',
    'dozen',
    'quintal',
    'seer',
    'maund',
    'packets',
    'sachets'
  ];

  final List<String> _commonCategories = [
    'Vegetables',
    'Fruits',
    'Meat & Fish',
    'Dairy',
    'Grains & Cereals',
    'Pulses & Lentils',
    'Spices & Masalas',
    'Condiments & Sauces',
    'Beverages',
    'Snacks',
    'Frozen',
    'Canned',
    'Baking',
    'Oil & Ghee',
    'Dry Fruits & Nuts'
  ];

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _populateFields(widget.item!);
    }
  }

  void _populateFields(PantryItem item) {
    _nameController.text = item.name;
    _quantityController.text = item.quantity.toString();
    _unitController.text = item.unit;
    _categoryController.text = item.category ?? '';
    _minStockController.text = item.minStockLevel?.toString() ?? '';
    _notesController.text = item.notes ?? '';
    _locationController.text = item.location ?? '';
    _expirationDate = item.expirationDate;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _unitController.dispose();
    _categoryController.dispose();
    _minStockController.dispose();
    _notesController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEditing = widget.item != null;

    return AlertDialog(
      title: Text(isEditing ? 'Edit Pantry Item' : 'Add Pantry Item'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Name field
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Item Name *',
                    hintText: 'e.g., Tomatoes, Milk, Rice',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter an item name';
                    }
                    return null;
                  },
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 16),

                // Quantity and Unit row
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: _quantityController,
                        decoration: const InputDecoration(
                          labelText: 'Quantity *',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*')),
                        ],
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Required';
                          }
                          final quantity = double.tryParse(value);
                          if (quantity == null || quantity <= 0) {
                            return 'Invalid quantity';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 3,
                      child: Autocomplete<String>(
                        optionsBuilder: (textEditingValue) {
                          if (textEditingValue.text.isEmpty) {
                            return _commonUnits;
                          }
                          return _commonUnits.where((unit) => unit
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase()));
                        },
                        onSelected: (selection) {
                          _unitController.text = selection;
                        },
                        fieldViewBuilder: (context, controller, focusNode,
                            onEditingComplete) {
                          _unitController.text = controller.text;
                          return TextFormField(
                            controller: controller,
                            focusNode: focusNode,
                            onEditingComplete: onEditingComplete,
                            decoration: const InputDecoration(
                              labelText: 'Unit *',
                              hintText: 'kg, pieces, etc.',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Category field
                Autocomplete<String>(
                  optionsBuilder: (textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return _commonCategories;
                    }
                    return _commonCategories.where((category) => category
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase()));
                  },
                  onSelected: (selection) {
                    _categoryController.text = selection;
                  },
                  fieldViewBuilder:
                      (context, controller, focusNode, onEditingComplete) {
                    _categoryController.text = controller.text;
                    return TextFormField(
                      controller: controller,
                      focusNode: focusNode,
                      onEditingComplete: onEditingComplete,
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        hintText: 'e.g., Vegetables, Dairy',
                        border: OutlineInputBorder(),
                      ),
                      textCapitalization: TextCapitalization.words,
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Expiration date field
                InkWell(
                  onTap: () => _selectExpirationDate(context),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Expiration Date',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    child: Text(
                      _expirationDate != null
                          ? '${_expirationDate!.day}/${_expirationDate!.month}/${_expirationDate!.year}'
                          : 'Select date (optional)',
                      style: _expirationDate != null
                          ? null
                          : TextStyle(color: theme.hintColor),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Min stock level field
                TextFormField(
                  controller: _minStockController,
                  decoration: InputDecoration(
                    labelText: 'Minimum Stock Level',
                    hintText: 'Alert when below this amount',
                    border: const OutlineInputBorder(),
                    suffixText: _unitController.text.isNotEmpty
                        ? _unitController.text
                        : null,
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  validator: (value) {
                    if (value != null && value.trim().isNotEmpty) {
                      final minStock = double.tryParse(value);
                      if (minStock == null || minStock < 0) {
                        return 'Invalid minimum stock level';
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Location field
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    labelText: 'Storage Location',
                    hintText: 'e.g., Fridge, Pantry, Freezer',
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 16),

                // Notes field
                TextFormField(
                  controller: _notesController,
                  decoration: const InputDecoration(
                    labelText: 'Notes',
                    hintText: 'Additional information (optional)',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                  textCapitalization: TextCapitalization.sentences,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        if (_expirationDate != null)
          TextButton(
            onPressed: _isLoading
                ? null
                : () {
                    setState(() {
                      _expirationDate = null;
                    });
                  },
            child: const Text('Clear Date'),
          ),
        ElevatedButton(
          onPressed: _isLoading ? null : _saveItem,
          child: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(isEditing ? 'Update' : 'Add'),
        ),
      ],
    );
  }

  Future<void> _selectExpirationDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate:
          _expirationDate ?? DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );

    if (date != null) {
      setState(() {
        _expirationDate = date;
      });
    }
  }

  Future<void> _saveItem() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final quantity = double.parse(_quantityController.text);
      final minStock = _minStockController.text.trim().isNotEmpty
          ? double.parse(_minStockController.text)
          : null;

      final pantryItem = widget.item?.copyWith(
            name: _nameController.text.trim(),
            quantity: quantity,
            unit: _unitController.text.trim(),
            category: _categoryController.text.trim().isNotEmpty
                ? _categoryController.text.trim()
                : null,
            expirationDate: _expirationDate,
            minStockLevel: minStock,
            notes: _notesController.text.trim().isNotEmpty
                ? _notesController.text.trim()
                : null,
            location: _locationController.text.trim().isNotEmpty
                ? _locationController.text.trim()
                : null,
            updatedAt: DateTime.now(),
            isLowStock: minStock != null ? quantity <= minStock : false,
          ) ??
          PantryItem.create(
            name: _nameController.text.trim(),
            quantity: quantity,
            unit: _unitController.text.trim(),
            category: _categoryController.text.trim().isNotEmpty
                ? _categoryController.text.trim()
                : null,
            expirationDate: _expirationDate,
            minStockLevel: minStock,
            notes: _notesController.text.trim().isNotEmpty
                ? _notesController.text.trim()
                : null,
            location: _locationController.text.trim().isNotEmpty
                ? _locationController.text.trim()
                : null,
          );

      if (widget.item != null) {
        await ref.read(pantryProvider.notifier).updateItem(pantryItem);
      } else {
        await ref.read(pantryProvider.notifier).addItem(pantryItem);
      }

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.item != null
                ? 'Item updated successfully'
                : 'Item added successfully'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
