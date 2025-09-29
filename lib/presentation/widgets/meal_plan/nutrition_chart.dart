import 'package:flutter/material.dart';

class NutritionChart extends StatelessWidget {
  final Map<String, double> nutrition;
  final Map<String, double>? targets;
  final NutritionChartType type;
  final bool showLegend;
  final bool showValues;

  const NutritionChart({
    super.key,
    required this.nutrition,
    this.targets,
    this.type = NutritionChartType.pie,
    this.showLegend = true,
    this.showValues = true,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case NutritionChartType.pie:
        return _buildPieChart(context);
      case NutritionChartType.bar:
        return _buildBarChart(context);
      case NutritionChartType.progress:
        return _buildProgressChart(context);
    }
  }

  Widget _buildPieChart(BuildContext context) {
    final theme = Theme.of(context);
    final total = nutrition.values.fold(0.0, (sum, value) => sum + value);

    return Column(
      children: [
        // Pie chart representation
        SizedBox(
          height: 200,
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: theme.colorScheme.outline.withOpacity(0.3)),
                  ),
                  child: CustomPaint(
                    painter: PieChartPainter(
                      data: nutrition,
                      colors: _getNutritionColors(),
                    ),
                  ),
                ),
              ),

              // Center total
              if (showValues)
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        total.toInt().toString(),
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'calories',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),

        if (showLegend) ...[
          const SizedBox(height: 16),
          _buildLegend(context),
        ],
      ],
    );
  }

  Widget _buildBarChart(BuildContext context) {
    final theme = Theme.of(context);
    final maxValue = nutrition.values.fold(0.0, (max, value) => value > max ? value : max);

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: nutrition.entries.map((entry) {
              final percentage = maxValue > 0 ? entry.value / maxValue : 0.0;
              final color = _getNutritionColors()[entry.key] ?? Colors.grey;

              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (showValues)
                    Text(
                      entry.value.toInt().toString(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  const SizedBox(height: 4),
                  Container(
                    width: 40,
                    height: 150 * percentage,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _getNutrientLabel(entry.key),
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressChart(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: nutrition.entries.map((entry) {
        final nutrient = entry.key;
        final value = entry.value;
        final target = targets?[nutrient];
        final progress = target != null && target > 0 ? (value / target).clamp(0.0, 1.0) : 0.0;
        final color = _getNutritionColors()[nutrient] ?? Colors.grey;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _getNutrientLabel(nutrient),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    target != null 
                        ? '${value.toInt()} / ${target.toInt()} ${_getUnit(nutrient)}'
                        : '${value.toInt()} ${_getUnit(nutrient)}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),

              LinearProgressIndicator(
                value: target != null ? progress : null,
                backgroundColor: color.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 8,
              ),

              if (target != null && progress > 1.0) ...[
                const SizedBox(height: 4),
                Text(
                  '${((progress - 1.0) * 100).toInt()}% over target',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.orange,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLegend(BuildContext context) {
    final theme = Theme.of(context);
    final colors = _getNutritionColors();

    return Wrap(
      alignment: WrapAlignment.center,
      children: nutrition.entries.map((entry) {
        final color = colors[entry.key] ?? Colors.grey;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '${_getNutrientLabel(entry.key)} (${entry.value.toInt()}${_getUnit(entry.key)})',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Map<String, Color> _getNutritionColors() {
    return {
      'calories': Colors.orange,
      'protein': Colors.red,
      'carbs': Colors.blue,
      'fat': Colors.green,
      'fiber': Colors.brown,
      'sugar': Colors.purple,
      'sodium': Colors.teal,
    };
  }

  String _getNutrientLabel(String key) {
    switch (key.toLowerCase()) {
      case 'calories':
        return 'Calories';
      case 'protein':
        return 'Protein';
      case 'carbs':
        return 'Carbs';
      case 'fat':
        return 'Fat';
      case 'fiber':
        return 'Fiber';
      case 'sugar':
        return 'Sugar';
      case 'sodium':
        return 'Sodium';
      default:
        return key;
    }
  }

  String _getUnit(String nutrient) {
    switch (nutrient.toLowerCase()) {
      case 'calories':
        return 'kcal';
      case 'sodium':
        return 'mg';
      default:
        return 'g';
    }
  }
}

enum NutritionChartType { pie, bar, progress }

class PieChartPainter extends CustomPainter {
  final Map<String, double> data;
  final Map<String, Color> colors;

  PieChartPainter({required this.data, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final total = data.values.fold(0.0, (sum, value) => sum + value);

    double startAngle = -90 * (3.14159 / 180); // Start from top

    data.forEach((nutrient, value) {
      final sweepAngle = (value / total) * 2 * 3.14159;
      final paint = Paint()
        ..color = colors[nutrient] ?? Colors.grey
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      startAngle += sweepAngle;
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}