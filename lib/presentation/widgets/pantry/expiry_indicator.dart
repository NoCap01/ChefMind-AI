import 'package:flutter/material.dart';

class ExpiryIndicator extends StatelessWidget {
  final DateTime? expiryDate;
  final ExpiryIndicatorStyle style;
  final bool showLabel;

  const ExpiryIndicator({
    super.key,
    required this.expiryDate,
    this.style = ExpiryIndicatorStyle.badge,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    if (expiryDate == null) return const SizedBox.shrink();

    final status = _getExpiryStatus();

    switch (style) {
      case ExpiryIndicatorStyle.badge:
        return _buildBadge(context, status);
      case ExpiryIndicatorStyle.dot:
        return _buildDot(context, status);
      case ExpiryIndicatorStyle.bar:
        return _buildBar(context, status);
    }
  }

  Widget _buildBadge(BuildContext context, ExpiryStatus status) {
    if (!status.showWarning) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: status.color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDot(BuildContext context, ExpiryStatus status) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: status.color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildBar(BuildContext context, ExpiryStatus status) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) ...[
          Text(
            'Freshness',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 4),
        ],
        Container(
          height: 4,
          decoration: BoxDecoration(
            color: status.color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        if (showLabel) ...[
          const SizedBox(height: 4),
          Text(
            status.text,
            style: theme.textTheme.bodySmall?.copyWith(
              color: status.color,
            ),
          ),
        ],
      ],
    );
  }

  ExpiryStatus _getExpiryStatus() {
    final now = DateTime.now();
    final difference = expiryDate!.difference(now).inDays;

    if (difference < 0) {
      return ExpiryStatus(
        showWarning: true,
        text: 'Expired',
        color: Colors.red,
      );
    } else if (difference <= 1) {
      return ExpiryStatus(
        showWarning: true,
        text: 'Expires today',
        color: Colors.red,
      );
    } else if (difference <= 3) {
      return ExpiryStatus(
        showWarning: true,
        text: 'Expires soon',
        color: Colors.orange,
      );
    } else if (difference <= 7) {
      return ExpiryStatus(
        showWarning: true,
        text: 'Use soon',
        color: Colors.yellow.shade700,
      );
    } else {
      return ExpiryStatus(
        showWarning: false,
        text: 'Fresh',
        color: Colors.green,
      );
    }
  }
}

enum ExpiryIndicatorStyle { badge, dot, bar }

class ExpiryStatus {
  final bool showWarning;
  final String text;
  final Color color;

  ExpiryStatus({
    required this.showWarning,
    required this.text,
    required this.color,
  });
}