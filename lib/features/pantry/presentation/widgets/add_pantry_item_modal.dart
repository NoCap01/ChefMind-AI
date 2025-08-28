import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/providers/pantry_provider.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../domain/entities/pantry_item.dart';

class AddPantryItemModal extends ConsumerStatefulWidget {
  final PantryItem? existingItem;

  const AddPantryItemModal({
    Key? key,
    this.existingItem,
  }) : super(key: key);

  @override
  ConsumerState<AddPantryItemModal> createState() => _AddPantryItemModalState();
}

class _AddPantryItemModalState extends ConsumerState<AddPantryItemModal> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _unitController = TextEditingController();
  final _brandController = TextEditingController();
  final _notesController = TextEditingController();
  final _barcodeController = TextEditingController();
  final _minQuantityController = TextEditingController();

  PantryCategory _selectedCategory = PantryCategories.pantryStaples;
  String? _selectedLocation;
  DateTime? _expiryDate;
  DateTime? _purchaseDate;
  bool _isLoading = false;

  final List<String> _commonUnits = [
    'piece', 'pieces', 'kg', 'g', 'lb', 'oz', 'L', 'ml', 'cup', 'cups',
    'tbsp', 'tsp', 'can', 'bottle', 'box', 'bag', 'pack'
  ];

  final List<String> _storageLocations = [
    'Fridge', 'Freezer', 'Pantry', 'Cabinet', 'Counter', 'Spice Rack'
  ];

  @override
  void initState() {
    super.initState();
    if (widget.existingItem != null) {
      _populateExistingItem();
    } else {
      _quantityController.text = '1';
      _unitController.text = 'piece';
    }
  }

  void _populateExistingItem() {
    final item = widget.existingItem!;
    _nameController.text = item.name;
    _quantityController.text = item.quantity.toString();
    _unitController.text = item.unit;
    _brandController.text = item.brand ?? '';
    _notesController.text = item.notes ?? '';
    _barcodeController.text = item.barcode ?? '';
    _minQuantityController.text = item.minQuantity?.toString() ?? '';
    _selectedCategory = item.category;
    _selectedLocation = item.location;
    _expiryDate = item.expiryDate;
    _purchaseDate = item.purchaseDate;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _unitController.dispose();
    _brandController.dispose();
    _notesController.dispose();
    _barcodeController.dispose();
    _minQuantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEditing = widget.existingItem != null;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(DesignTokens.radiusLg),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: DesignTokens.spacingSm),
            decoration: BoxDecoration(
              color: theme.colorScheme.onSurface.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: DesignTokens.spacingMd),
            child: Row(
              children: [
                Text(
                  isEditing ? 'Edit Item' : 'Add New Item',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (!isEditing) ...[
                  IconButton(
                    onPressed: _scanBarcode,
                    icon: const Icon(Icons.qr_code_scanner),
                    tooltip: 'Scan Barcode',
                  ),
                ],
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),

          const Divider(),

          // Form
          Flexible(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(DesignTokens.spacingMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Basic Information
                    _buildBasicInfoSection(theme),
                    const SizedBox(height: DesignTokens.spacingLg),

                    // Category and Location
                    _buildCategoryLocationSection(theme),
                    const SizedBox(height: DesignTokens.spacingLg),

                    // Dates
                    _buildDatesSection(theme),
                    const SizedBox(height: DesignTokens.spacingLg),

                    // Additional Information
                    _buildAdditionalInfoSection(theme),
                    const SizedBox(height: DesignTokens.spacingXl),

                    // Action Buttons
                    _buildActionButtons(theme, isEditing),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Basic Information',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: DesignTokens.spacingMd),
        
        // Item Name
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Item Name *',
            hintText: 'e.g., Organic Milk',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter an item name';
            }
            return null;
          },
        ),
        
        const SizedBox(height: DesignTokens.spacingMd),
        
        // Quantity and Unit
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
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Required';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Invalid number';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: DesignTokens.spacingMd),
            Expanded(
              flex: 3,
              child: DropdownButtonFormField<String>(
                value: _unitController.text.isNotEmpty ? _unitController.text : null,
                decoration: const InputDecoration(
                  labelText: 'Unit *',
                  border: OutlineInputBorder(),
                ),
                items: _commonUnits.map((unit) {
                  return DropdownMenuItem(
                    value: unit,
                    child: Text(unit),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    _unitController.text = value;
                  }
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please select a unit';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        
        const SizedBox(height: DesignTokens.spacingMd),
        
        // Brand (optional)
        TextFormField(
          controller: _brandController,
          decoration: const InputDecoration(
            labelText: 'Brand (optional)',
            hintText: 'e.g., Organic Valley',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryLocationSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category & Storage',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: DesignTokens.spacingMd),
        
        // Category Selection
        Text(
          'Category *',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: DesignTokens.spacingSm),
        Wrap(
          spacing: DesignTokens.spacingSm,
          runSpacing: DesignTokens.spacingSm,
          children: PantryCategories.all.map((category) {
            final isSelected = _selectedCategory.id == category.id;
            return FilterChip(
              avatar: Text(category.icon),
              label: Text(category.name),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _selectedCategory = category;
                  });
                }
              },
            );
          }).toList(),
        ),
        
        const SizedBox(height: DesignTokens.spacingMd),
        
        // Storage Location
        DropdownButtonFormField<String>(
          value: _selectedLocation,
          decoration: const InputDecoration(
            labelText: 'Storage Location (optional)',
            border: OutlineInputBorder(),
          ),
          items: _storageLocations.map((location) {
            return DropdownMenuItem(
              value: location,
              child: Text(location),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedLocation = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDatesSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Important Dates',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: DesignTokens.spacingMd),
        
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _selectDate(true),
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  _purchaseDate != null
                      ? 'Purchased: ${_formatDate(_purchaseDate!)}'
                      : 'Purchase Date',
                ),
              ),
            ),
            const SizedBox(width: DesignTokens.spacingMd),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _selectDate(false),
                icon: const Icon(Icons.schedule),
                label: Text(
                  _expiryDate != null
                      ? 'Expires: ${_formatDate(_expiryDate!)}'
                      : 'Expiry Date',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAdditionalInfoSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Additional Information',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: DesignTokens.spacingMd),
        
        // Minimum Quantity
        TextFormField(
          controller: _minQuantityController,
          decoration: const InputDecoration(
            labelText: 'Low Stock Alert Threshold (optional)',
            hintText: 'Alert when quantity falls below this amount',
            border: OutlineInputBorder(),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: (value) {
            if (value != null && value.isNotEmpty && double.tryParse(value) == null) {
              return 'Please enter a valid number';
            }
            return null;
          },
        ),
        
        const SizedBox(height: DesignTokens.spacingMd),
        
        // Barcode
        TextFormField(
          controller: _barcodeController,
          decoration: InputDecoration(
            labelText: 'Barcode (optional)',
            hintText: 'Scan or enter manually',
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              onPressed: _scanBarcode,
              icon: const Icon(Icons.qr_code_scanner),
            ),
          ),
        ),
        
        const SizedBox(height: DesignTokens.spacingMd),
        
        // Notes
        TextFormField(
          controller: _notesController,
          decoration: const InputDecoration(
            labelText: 'Notes (optional)',
            hintText: 'Any additional information...',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildActionButtons(ThemeData theme, bool isEditing) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ),
        const SizedBox(width: DesignTokens.spacingMd),
        Expanded(
          child: ElevatedButton(
            onPressed: _isLoading ? null : _saveItem,
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(isEditing ? 'Update Item' : 'Add Item'),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _selectDate(bool isPurchaseDate) async {
    final initialDate = isPurchaseDate 
        ? _purchaseDate ?? DateTime.now()
        : _expiryDate ?? DateTime.now().add(const Duration(days: 7));

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 1095)), // 3 years
    );

    if (selectedDate != null) {
      setState(() {
        if (isPurchaseDate) {
          _purchaseDate = selectedDate;
        } else {
          _expiryDate = selectedDate;
        }
      });
    }
  }

  void _scanBarcode() {
    // TODO: Implement barcode scanning
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Barcode scanning will be implemented soon!'),
      ),
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
      final minQuantity = _minQuantityController.text.isNotEmpty 
          ? double.parse(_minQuantityController.text)
          : null;

      final item = PantryItem(
        id: widget.existingItem?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        quantity: quantity,
        unit: _unitController.text.trim(),
        category: _selectedCategory,
        expiryDate: _expiryDate,
        purchaseDate: _purchaseDate,
        brand: _brandController.text.trim().isNotEmpty ? _brandController.text.trim() : null,
        notes: _notesController.text.trim().isNotEmpty ? _notesController.text.trim() : null,
        barcode: _barcodeController.text.trim().isNotEmpty ? _barcodeController.text.trim() : null,
        location: _selectedLocation,
        minQuantity: minQuantity,
        isLowStock: minQuantity != null && quantity <= minQuantity,
        createdAt: widget.existingItem?.createdAt ?? DateTime.now(),
        updatedAt: widget.existingItem != null ? DateTime.now() : null,
      );

      if (widget.existingItem != null) {
        await ref.read(pantryStateProvider.notifier).updatePantryItem(item);
      } else {
        await ref.read(pantryStateProvider.notifier).addPantryItem(item);
      }

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.existingItem != null 
                  ? 'Item updated successfully!' 
                  : 'Item added to pantry!',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving item: $e'),
            backgroundColor: Colors.red,
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