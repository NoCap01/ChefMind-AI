import 'package:flutter/material.dart';

class QuantitySelector extends StatefulWidget {
  final double initialValue;
  final String? unit;
  final double min;
  final double max;
  final double step;
  final ValueChanged<double>? onChanged;
  final bool showUnit;
  final List<String>? unitOptions;
  final String? selectedUnit;
  final ValueChanged<String>? onUnitChanged;

  const QuantitySelector({
    super.key,
    this.initialValue = 1.0,
    this.unit,
    this.min = 0.0,
    this.max = 999.0,
    this.step = 1.0,
    this.onChanged,
    this.showUnit = true,
    this.unitOptions,
    this.selectedUnit,
    this.onUnitChanged,
  });

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  late double _currentValue;
  late String _currentUnit;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
    _currentUnit = widget.selectedUnit ?? widget.unit ?? '';
    _controller = TextEditingController(text: _formatValue(_currentValue));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Decrease button
        IconButton(
          onPressed: _currentValue > widget.min ? _decrease : null,
          icon: const Icon(Icons.remove_circle_outline),
          style: IconButton.styleFrom(
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
          ),
        ),

        const SizedBox(width: 8),

        // Value input
        SizedBox(
          width: 80,
          child: TextField(
            controller: _controller,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 8),
            ),
            onSubmitted: _onValueSubmitted,
            onChanged: _onValueChanged,
          ),
        ),

        const SizedBox(width: 8),

        // Increase button
        IconButton(
          onPressed: _currentValue < widget.max ? _increase : null,
          icon: const Icon(Icons.add_circle_outline),
          style: IconButton.styleFrom(
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
          ),
        ),

        // Unit selector
        if (widget.showUnit && (widget.unitOptions?.isNotEmpty ?? false)) ...[
          const SizedBox(width: 16),
          DropdownButton<String>(
            value: _currentUnit.isNotEmpty ? _currentUnit : null,
            hint: const Text('Unit'),
            items: widget.unitOptions
                ?.map((unit) => DropdownMenuItem(
                      value: unit,
                      child: Text(unit),
                    ))
                .toList(),
            onChanged: (newUnit) {
              if (newUnit != null) {
                setState(() => _currentUnit = newUnit);
                widget.onUnitChanged?.call(newUnit);
              }
            },
          ),
        ] else if (widget.showUnit && _currentUnit.isNotEmpty) ...[
          const SizedBox(width: 8),
          Text(
            _currentUnit,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ],
    );
  }

  void _increase() {
    final newValue =
        (_currentValue + widget.step).clamp(widget.min, widget.max);
    _updateValue(newValue);
  }

  void _decrease() {
    final newValue =
        (_currentValue - widget.step).clamp(widget.min, widget.max);
    _updateValue(newValue);
  }

  void _onValueSubmitted(String value) {
    final newValue = double.tryParse(value);
    if (newValue != null) {
      _updateValue(newValue.clamp(widget.min, widget.max));
    } else {
      _controller.text = _formatValue(_currentValue);
    }
  }

  void _onValueChanged(String value) {
    final newValue = double.tryParse(value);
    if (newValue != null && newValue >= widget.min && newValue <= widget.max) {
      _currentValue = newValue;
      widget.onChanged?.call(_currentValue);
    }
  }

  void _updateValue(double newValue) {
    setState(() {
      _currentValue = newValue;
      _controller.text = _formatValue(_currentValue);
    });
    widget.onChanged?.call(_currentValue);
  }

  String _formatValue(double value) {
    return value == value.toInt() ? value.toInt().toString() : value.toString();
  }
}

class CompactQuantitySelector extends StatelessWidget {
  final double value;
  final String? unit;
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;
  final bool canDecrease;
  final bool canIncrease;

  const CompactQuantitySelector({
    super.key,
    required this.value,
    this.unit,
    this.onIncrease,
    this.onDecrease,
    this.canDecrease = true,
    this.canIncrease = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: canDecrease ? onDecrease : null,
            child: Icon(
              Icons.remove,
              size: 16,
              color: canDecrease
                  ? theme.colorScheme.onSurface
                  : theme.colorScheme.onSurface.withOpacity(0.3),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${value == value.toInt() ? value.toInt() : value}${unit ?? ''}',
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: canIncrease ? onIncrease : null,
            child: Icon(
              Icons.add,
              size: 16,
              color: canIncrease
                  ? theme.colorScheme.onSurface
                  : theme.colorScheme.onSurface.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}
