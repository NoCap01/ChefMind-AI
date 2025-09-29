import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../application/providers/shopping_list_provider.dart';
import '../../../domain/entities/shopping_list_item.dart';

class AddShoppingItemDialog extends ConsumerStatefulWidget {
  final ShoppingListItem? item;

  const AddShoppingItemDialog({super.key, this.item});

  @override
  ConsumerState<AddShoppingItemDialog> createState() =>
      _AddShoppingItemDialogState();
}

class _AddShoppingItemDialogState extends ConsumerState<AddShoppingItemDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _unitController = TextEditingController();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  final _notesController = TextEditingController();

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
    'bunches',
    'heads',
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
    'Household',
    'Personal Care',
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

  void _populateFields(ShoppingListItem item) {
    _nameController.text = item.name;
    _quantityController.text = item.quantity.toString();
    _unitController.text = item.unit;
    _categoryController.text = item.category ?? '';
    _priceController.text = item.estimatedPrice?.toString() ?? '';
    _notesController.text = item.notes ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _unitController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.item != null;

    return AlertDialog(
      title: Text(isEditing ? 'Edit Shopping Item' : 'Add Shopping Item'),
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

                // Estimated price field
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Estimated Price',
                    hintText: 'Price per unit (optional)',
                    border: OutlineInputBorder(),
                    prefixText: '₹',
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  validator: (value) {
                    if (value != null && value.trim().isNotEmpty) {
                      final price = double.tryParse(value);
                      if (price == null || price < 0) {
                        return 'Invalid price';
                      }
                    }
                    return null;
                  },
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

  Future<void> _saveItem() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final quantity = double.parse(_quantityController.text);
      final price = _priceController.text.trim().isNotEmpty
          ? double.parse(_priceController.text)
          : null;

      final shoppingItem = widget.item?.copyWith(
            name: _nameController.text.trim(),
            quantity: quantity,
            unit: _unitController.text.trim(),
            category: _categoryController.text.trim().isNotEmpty
                ? _categoryController.text.trim()
                : null,
            estimatedPrice: price,
            notes: _notesController.text.trim().isNotEmpty
                ? _notesController.text.trim()
                : null,
            updatedAt: DateTime.now(),
          ) ??
          ShoppingListItem.create(
            name: _nameController.text.trim(),
            quantity: quantity,
            unit: _unitController.text.trim(),
            category: _categoryController.text.trim().isNotEmpty
                ? _categoryController.text.trim()
                : null,
            estimatedPrice: price,
            notes: _notesController.text.trim().isNotEmpty
                ? _notesController.text.trim()
                : null,
          );

      if (widget.item != null) {
        await ref.read(shoppingListProvider.notifier).updateItem(shoppingItem);
      } else {
        await ref.read(shoppingListProvider.notifier).addItem(shoppingItem);
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
