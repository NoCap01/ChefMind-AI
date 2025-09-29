#!/usr/bin/env dart

import 'dart:io';
import 'dart:convert';

void main(List<String> args) async {
  print('🚀 Starting ChefMind Performance Tests...\n');

  // Check if Flutter is available
  final flutterResult = await Process.run('flutter', ['--version']);
  if (flutterResult.exitCode != 0) {
    print('❌ Flutter not found. Please install Flutter first.');
    exit(1);
  }

  // Run performance tests
  await runPerformanceTests();
  
  // Generate performance report
  await generatePerformanceReport();
  
  print('\n✅ Performance testing completed!');
  print('📊 Check test_results/performance_report.html for detailed results.');
}

Future<void> runPerformanceTests() async {
  print('📱 Running performance tests...');
  
  final result = await Process.run(
    'flutter',
    [
      'test',
      'integration_test/performance_test_runner.dart',
      '--reporter=json',
    ],
    workingDirectory: '.',
  );

  if (result.exitCode == 0) {
    print('✅ Performance tests passed');
  } else {
    print('⚠️  Some performance tests failed');
    print('Error output: ${result.stderr}');
  }

  // Save test results
  final resultsDir = Directory('test_results');
  if (!await resultsDir.exists()) {
    await resultsDir.create(recursive: true);
  }

  final resultsFile = File('test_results/performance_test_results.json');
  await resultsFile.writeAsString(result.stdout);
}

Future<void> generatePerformanceReport() async {
  print('📊 Generating performance report...');
  
  try {
    // Read performance metrics
    final metricsFile = File('test_results/performance_metrics.json');
    List<Map<String, dynamic>> metrics = [];
    
    if (await metricsFile.exists()) {
      final content = await metricsFile.readAsString();
      if (content.isNotEmpty) {
        metrics = List<Map<String, dynamic>>.from(json.decode(content));
      }
    }

    // Generate HTML report
    final htmlReport = generateHTMLReport(metrics);
    
    final reportFile = File('test_results/performance_report.html');
    await reportFile.writeAsString(htmlReport);
    
    print('✅ Performance report generated');
  } catch (e) {
    print('⚠️  Error generating report: $e');
  }
}

String generateHTMLReport(List<Map<String, dynamic>> metrics) {
  final now = DateTime.now();
  
  // Group metrics by type
  final groupedMetrics = <String, List<Map<String, dynamic>>>{};
  for (final metric in metrics) {
    final metricName = metric['metric'] as String;
    groupedMetrics.putIfAbsent(metricName, () => []).add(metric);
  }

  // Calculate statistics
  final stats = <String, Map<String, dynamic>>{};
  for (final entry in groupedMetrics.entries) {
    final values = entry.value.map((m) => m['value'] as num).toList();
    values.sort();
    
    if (values.isNotEmpty) {
      stats[entry.key] = {
        'count': values.length,
        'average': values.reduce((a, b) => a + b) / values.length,
        'min': values.first,
        'max': values.last,
        'median': values[values.length ~/ 2],
        'p95': values[(values.length * 0.95).floor()],
      };
    }
  }

  return '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ChefMind Performance Report</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }
        .content {
            padding: 30px;
        }
        .metric-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .metric-card {
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 20px;
            background: #fafafa;
        }
        .metric-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 15px;
            color: #333;
        }
        .metric-stats {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 10px;
        }
        .stat-item {
            text-align: center;
            padding: 10px;
            background: white;
            border-radius: 4px;
        }
        .stat-value {
            font-size: 20px;
            font-weight: bold;
            color: #667eea;
        }
        .stat-label {
            font-size: 12px;
            color: #666;
            margin-top: 5px;
        }
        .summary {
            background: #e8f4fd;
            border-left: 4px solid #2196f3;
            padding: 20px;
            margin-bottom: 30px;
        }
        .warning {
            background: #fff3cd;
            border-left: 4px solid #ffc107;
            padding: 15px;
            margin: 10px 0;
        }
        .success {
            background: #d4edda;
            border-left: 4px solid #28a745;
            padding: 15px;
            margin: 10px 0;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f8f9fa;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>ChefMind Performance Report</h1>
            <p>Generated on ${now.toString()}</p>
        </div>
        
        <div class="content">
            <div class="summary">
                <h2>Summary</h2>
                <p><strong>Total Metrics:</strong> ${metrics.length}</p>
                <p><strong>Metric Types:</strong> ${stats.length}</p>
                <p><strong>Test Duration:</strong> ${_calculateTestDuration(metrics)}</p>
            </div>

            ${_generatePerformanceAlerts(stats)}

            <h2>Performance Metrics</h2>
            <div class="metric-grid">
                ${stats.entries.map((entry) => _generateMetricCard(entry.key, entry.value)).join('')}
            </div>

            <h2>Detailed Results</h2>
            <table>
                <thead>
                    <tr>
                        <th>Metric</th>
                        <th>Count</th>
                        <th>Average (ms)</th>
                        <th>Min (ms)</th>
                        <th>Max (ms)</th>
                        <th>P95 (ms)</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    ${stats.entries.map((entry) => _generateTableRow(entry.key, entry.value)).join('')}
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
''';
}

String _calculateTestDuration(List<Map<String, dynamic>> metrics) {
  if (metrics.isEmpty) return 'N/A';
  
  final timestamps = metrics
      .map((m) => DateTime.parse(m['timestamp'] as String))
      .toList();
  
  timestamps.sort();
  
  final duration = timestamps.last.difference(timestamps.first);
  return '${duration.inSeconds} seconds';
}

String _generatePerformanceAlerts(Map<String, Map<String, dynamic>> stats) {
  final alerts = <String>[];
  
  for (final entry in stats.entries) {
    final metricName = entry.key;
    final average = entry.value['average'] as num;
    
    if (metricName.contains('startup') && average > 3000) {
      alerts.add('App startup time is slow (${average.toStringAsFixed(0)}ms > 3000ms)');
    } else if (metricName.contains('navigation') && average > 500) {
      alerts.add('Navigation is slow (${average.toStringAsFixed(0)}ms > 500ms)');
    } else if (metricName.contains('recipe_generation') && average > 10000) {
      alerts.add('Recipe generation is slow (${average.toStringAsFixed(0)}ms > 10000ms)');
    }
  }
  
  if (alerts.isEmpty) {
    return '<div class="success"><h3>✅ All Performance Metrics Within Acceptable Ranges</h3></div>';
  }
  
  return '''
    <div class="warning">
        <h3>⚠️ Performance Alerts</h3>
        ${alerts.map((alert) => '<p>• $alert</p>').join('')}
    </div>
  ''';
}

String _generateMetricCard(String metricName, Map<String, dynamic> stats) {
  final average = stats['average'] as num;
  final count = stats['count'] as num;
  final min = stats['min'] as num;
  final max = stats['max'] as num;
  final p95 = stats['p95'] as num;
  
  return '''
    <div class="metric-card">
        <div class="metric-title">${_formatMetricName(metricName)}</div>
        <div class="metric-stats">
            <div class="stat-item">
                <div class="stat-value">${average.toStringAsFixed(1)}</div>
                <div class="stat-label">Average (ms)</div>
            </div>
            <div class="stat-item">
                <div class="stat-value">$count</div>
                <div class="stat-label">Count</div>
            </div>
            <div class="stat-item">
                <div class="stat-value">$min</div>
                <div class="stat-label">Min (ms)</div>
            </div>
            <div class="stat-item">
                <div class="stat-value">$max</div>
                <div class="stat-label">Max (ms)</div>
            </div>
            <div class="stat-item">
                <div class="stat-value">$p95</div>
                <div class="stat-label">P95 (ms)</div>
            </div>
        </div>
    </div>
  ''';
}

String _generateTableRow(String metricName, Map<String, dynamic> stats) {
  final average = stats['average'] as num;
  final count = stats['count'] as num;
  final min = stats['min'] as num;
  final max = stats['max'] as num;
  final p95 = stats['p95'] as num;
  
  String getStatus(String metric, num avgValue) {
    if (metric.contains('startup') && avgValue > 3000) return '🔴 Slow';
    if (metric.contains('navigation') && avgValue > 500) return '🟡 Warning';
    if (metric.contains('recipe_generation') && avgValue > 10000) return '🔴 Slow';
    return '🟢 Good';
  }
  
  return '''
    <tr>
        <td>${_formatMetricName(metricName)}</td>
        <td>$count</td>
        <td>${average.toStringAsFixed(1)}</td>
        <td>$min</td>
        <td>$max</td>
        <td>$p95</td>
        <td>${getStatus(metricName, average)}</td>
    </tr>
  ''';
}

String _formatMetricName(String metricName) {
  return metricName
      .split('_')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');
}