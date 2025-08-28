import 'package:flutter/material.dart';

import '../../../../domain/entities/nutrition_tracking.dart';

class MicronutrientAnalysisWidget extends StatelessWidget {
  final MicronutrientAnalysis analysis;

  const MicronutrientAnalysisWidget({
    super.key,
    required this.analysis,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Micronutrient Analysis',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getScoreColor(analysis.overallScore),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${analysis.overallScore.toStringAsFixed(0)}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Vitamins Section
            if (analysis.vitamins.isNotEmpty) ...[
              Text(
                'Vitamins',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              ...analysis.vitamins.entries.map((entry) => 
                _buildMicronutrientItem(entry.key, entry.value),
              ),
              const SizedBox(height: 16),
            ],

            // Minerals Section
            if (analysis.minerals.isNotEmpty) ...[
              Text(
                'Minerals',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              ...analysis.minerals.entries.map((entry) => 
                _buildMicronutrientItem(entry.key, entry.value),
              ),
              const SizedBox(height: 16),
            ],

            // Deficiencies and Excesses
            if (analysis.deficiencies.isNotEmpty || analysis.excesses.isNotEmpty) ...[
              const Divider(),
              const SizedBox(height: 8),
              
              if (analysis.deficiencies.isNotEmpty) ...[
                Row(
                  children: [
                    const Icon(Icons.warning, color: Colors.orange, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      'Deficiencies',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 4,
                  children: analysis.deficiencies.map((deficiency) => Chip(
                    label: Text(
                      deficiency,
                      style: const TextStyle(fontSize: 10),
                    ),
                    backgroundColor: Colors.orange[100],
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  )).toList(),
                ),
                const SizedBox(height: 8),
              ],
              
              if (analysis.excesses.isNotEmpty) ...[
                Row(
                  children: [
                    const Icon(Icons.error, color: Colors.red, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      'Excesses',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 4,
                  children: analysis.excesses.map((excess) => Chip(
                    label: Text(
                      excess,
                      style: const TextStyle(fontSize: 10),
                    ),
                    backgroundColor: Colors.red[100],
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  )).toList(),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMicronutrientItem(String name, MicronutrientStatus status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _getLevelColor(status.level),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _getLevelText(status.level),
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: (status.percentageOfRDA / 100).clamp(0.0, 1.0),
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(_getLevelColor(status.level)),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${status.percentageOfRDA.toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          if (status.level == MicronutrientLevel.deficient || 
              status.level == MicronutrientLevel.low) ...[
            const SizedBox(height: 2),
            Text(
              'Good sources: ${status.foodSources.take(3).join(', ')}',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getScoreColor(double score) {
    if (score >= 85) return Colors.green;
    if (score >= 70) return Colors.orange;
    return Colors.red;
  }

  Color _getLevelColor(MicronutrientLevel level) {
    switch (level) {
      case MicronutrientLevel.deficient:
        return Colors.red;
      case MicronutrientLevel.low:
        return Colors.orange;
      case MicronutrientLevel.adequate:
        return Colors.green;
      case MicronutrientLevel.high:
        return Colors.blue;
      case MicronutrientLevel.excessive:
        return Colors.purple;
    }
  }

  String _getLevelText(MicronutrientLevel level) {
    switch (level) {
      case MicronutrientLevel.deficient:
        return 'LOW';
      case MicronutrientLevel.low:
        return 'BELOW';
      case MicronutrientLevel.adequate:
        return 'GOOD';
      case MicronutrientLevel.high:
        return 'HIGH';
      case MicronutrientLevel.excessive:
        return 'EXCESS';
    }
  }
}