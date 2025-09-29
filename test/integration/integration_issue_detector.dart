import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chefmind_ai/main.dart';

/// Comprehensive integration issue detector that identifies common problems
/// across the app and provides detailed reports for fixing
class IntegrationIssueDetector {
  static List<IntegrationIssue> detectedIssues = [];

  static void detectIssues(WidgetTester tester) {
    detectedIssues.clear();
    
    _detectNavigationIssues(tester);
    _detectStateManagementIssues(tester);
    _detectUIConsistencyIssues(tester);
    _detectPerformanceIssues(tester);
    _detectAccessibilityIssues(tester);
  }

  static void _detectNavigationIssues(WidgetTester tester) {
    // Check for broken navigation routes
    final navigatorStates = find.byType(Navigator);
    if (navigatorStates.evaluate().isEmpty) {
      detectedIssues.add(IntegrationIssue(
        type: IssueType.navigation,
        severity: IssueSeverity.high,
        description: 'No Navigator found in widget tree',
        location: 'App root',
        suggestedFix: 'Ensure MaterialApp.router is properly configured',
      ));
    }

    // Check for missing back button handling
    final appBars = find.byType(AppBar);
    for (int i = 0; i < appBars.evaluate().length; i++) {
      final appBar = tester.widget<AppBar>(appBars.at(i));
      if (appBar.leading == null && appBar.automaticallyImplyLeading == false) {
        detectedIssues.add(IntegrationIssue(
          type: IssueType.navigation,
          severity: IssueSeverity.medium,
          description: 'AppBar missing back navigation',
          location: 'AppBar ${i + 1}',
          suggestedFix: 'Add proper leading widget or enable automaticallyImplyLeading',
        ));
      }
    }
  }

  static void _detectStateManagementIssues(WidgetTester tester) {
    // Check for missing ProviderScope
    final providerScopes = find.byType(ProviderScope);
    if (providerScopes.evaluate().isEmpty) {
      detectedIssues.add(IntegrationIssue(
        type: IssueType.stateManagement,
        severity: IssueSeverity.high,
        description: 'No ProviderScope found - Riverpod providers will not work',
        location: 'App root',
        suggestedFix: 'Wrap app with ProviderScope',
      ));
    }

    // Check for Consumer widgets without proper error handling
    final consumers = find.byType(Consumer);
    if (consumers.evaluate().length > 10) {
      detectedIssues.add(IntegrationIssue(
        type: IssueType.stateManagement,
        severity: IssueSeverity.low,
        description: 'High number of Consumer widgets detected',
        location: 'Multiple locations',
        suggestedFix: 'Consider using ConsumerWidget or ConsumerStatefulWidget for better performance',
      ));
    }
  }

  static void _detectUIConsistencyIssues(WidgetTester tester) {
    // Check for inconsistent button styles
    final elevatedButtons = find.byType(ElevatedButton);
    final buttonStyles = <ButtonStyle?>[];
    
    for (int i = 0; i < elevatedButtons.evaluate().length; i++) {
      final button = tester.widget<ElevatedButton>(elevatedButtons.at(i));
      buttonStyles.add(button.style);
    }

    if (buttonStyles.where((style) => style != null).toSet().length > 3) {
      detectedIssues.add(IntegrationIssue(
        type: IssueType.uiConsistency,
        severity: IssueSeverity.medium,
        description: 'Inconsistent button styles detected',
        location: 'Multiple ElevatedButtons',
        suggestedFix: 'Standardize button styles using theme or consistent styling',
      ));
    }

    // Check for missing loading states
    final circularProgressIndicators = find.byType(CircularProgressIndicator);
    if (circularProgressIndicators.evaluate().isEmpty) {
      detectedIssues.add(IntegrationIssue(
        type: IssueType.uiConsistency,
        severity: IssueSeverity.medium,
        description: 'No loading indicators found',
        location: 'App-wide',
        suggestedFix: 'Add loading states for async operations',
      ));
    }

    // Check for text overflow issues
    final texts = find.byType(Text);
    for (int i = 0; i < texts.evaluate().length && i < 20; i++) {
      final text = tester.widget<Text>(texts.at(i));
      if (text.overflow == null && text.maxLines == null) {
        detectedIssues.add(IntegrationIssue(
          type: IssueType.uiConsistency,
          severity: IssueSeverity.low,
          description: 'Text widget without overflow handling',
          location: 'Text widget ${i + 1}',
          suggestedFix: 'Add overflow: TextOverflow.ellipsis or maxLines property',
        ));
      }
    }
  }

  static void _detectPerformanceIssues(WidgetTester tester) {
    // Check for excessive widget rebuilds
    final scaffolds = find.byType(Scaffold);
    if (scaffolds.evaluate().length > 5) {
      detectedIssues.add(IntegrationIssue(
        type: IssueType.performance,
        severity: IssueSeverity.medium,
        description: 'Multiple Scaffold widgets in tree',
        location: 'Widget tree',
        suggestedFix: 'Consider using single Scaffold with body switching',
      ));
    }

    // Check for missing const constructors
    final containers = find.byType(Container);
    for (int i = 0; i < containers.evaluate().length && i < 10; i++) {
      final container = tester.widget<Container>(containers.at(i));
      if (container.child != null && container.decoration == null && 
          container.constraints == null && container.transform == null) {
        detectedIssues.add(IntegrationIssue(
          type: IssueType.performance,
          severity: IssueSeverity.low,
          description: 'Container used where Padding/SizedBox would be more efficient',
          location: 'Container ${i + 1}',
          suggestedFix: 'Replace with Padding or SizedBox for better performance',
        ));
      }
    }
  }

  static void _detectAccessibilityIssues(WidgetTester tester) {
    // Check for buttons without semantic labels
    final iconButtons = find.byType(IconButton);
    for (int i = 0; i < iconButtons.evaluate().length; i++) {
      final iconButton = tester.widget<IconButton>(iconButtons.at(i));
      if (iconButton.tooltip == null) {
        detectedIssues.add(IntegrationIssue(
          type: IssueType.accessibility,
          severity: IssueSeverity.medium,
          description: 'IconButton without tooltip',
          location: 'IconButton ${i + 1}',
          suggestedFix: 'Add tooltip property for accessibility',
        ));
      }
    }

    // Check for images without semantic labels
    final images = find.byType(Image);
    for (int i = 0; i < images.evaluate().length; i++) {
      final image = tester.widget<Image>(images.at(i));
      if (image.semanticLabel == null) {
        detectedIssues.add(IntegrationIssue(
          type: IssueType.accessibility,
          severity: IssueSeverity.medium,
          description: 'Image without semantic label',
          location: 'Image ${i + 1}',
          suggestedFix: 'Add semanticLabel property for screen readers',
        ));
      }
    }
  }

  static String generateReport() {
    if (detectedIssues.isEmpty) {
      return 'No integration issues detected. Great job!';
    }

    final buffer = StringBuffer();
    buffer.writeln('Integration Issues Report');
    buffer.writeln('=' * 50);
    buffer.writeln();

    final groupedIssues = <IssueType, List<IntegrationIssue>>{};
    for (final issue in detectedIssues) {
      groupedIssues.putIfAbsent(issue.type, () => []).add(issue);
    }

    for (final type in IssueType.values) {
      final issues = groupedIssues[type] ?? [];
      if (issues.isEmpty) continue;

      buffer.writeln('${type.name.toUpperCase()} ISSUES (${issues.length})');
      buffer.writeln('-' * 30);

      for (final issue in issues) {
        buffer.writeln('• ${issue.description}');
        buffer.writeln('  Location: ${issue.location}');
        buffer.writeln('  Severity: ${issue.severity.name}');
        buffer.writeln('  Fix: ${issue.suggestedFix}');
        buffer.writeln();
      }
    }

    // Summary
    final highSeverity = detectedIssues.where((i) => i.severity == IssueSeverity.high).length;
    final mediumSeverity = detectedIssues.where((i) => i.severity == IssueSeverity.medium).length;
    final lowSeverity = detectedIssues.where((i) => i.severity == IssueSeverity.low).length;

    buffer.writeln('SUMMARY');
    buffer.writeln('-' * 20);
    buffer.writeln('Total Issues: ${detectedIssues.length}');
    buffer.writeln('High Severity: $highSeverity');
    buffer.writeln('Medium Severity: $mediumSeverity');
    buffer.writeln('Low Severity: $lowSeverity');

    return buffer.toString();
  }
}

class IntegrationIssue {
  final IssueType type;
  final IssueSeverity severity;
  final String description;
  final String location;
  final String suggestedFix;

  IntegrationIssue({
    required this.type,
    required this.severity,
    required this.description,
    required this.location,
    required this.suggestedFix,
  });
}

enum IssueType {
  navigation,
  stateManagement,
  uiConsistency,
  performance,
  accessibility,
}

enum IssueSeverity {
  high,
  medium,
  low,
}

void main() {
  group('Integration Issue Detection Tests', () {
    testWidgets('Detect and Report Integration Issues', (WidgetTester tester) async {
      const testApp = ProviderScope(child: ChefMindApp());
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();

      // Run issue detection
      IntegrationIssueDetector.detectIssues(tester);

      // Generate and print report
      final report = IntegrationIssueDetector.generateReport();
      print('\n$report');

      // Navigate through all screens to detect issues
      final screens = ['Generate Recipe', 'Recipe Book', 'Shopping', 'Meal Planner', 'Profile'];
      
      for (final screenName in screens) {
        final screenTab = find.text(screenName);
        if (screenTab.evaluate().isNotEmpty) {
          await tester.tap(screenTab);
          await tester.pumpAndSettle();
          
          // Re-run detection for each screen
          IntegrationIssueDetector.detectIssues(tester);
        }
      }

      // Final report
      final finalReport = IntegrationIssueDetector.generateReport();
      print('\nFinal Integration Report:');
      print(finalReport);

      // Ensure no high-severity issues
      final highSeverityIssues = IntegrationIssueDetector.detectedIssues
          .where((issue) => issue.severity == IssueSeverity.high)
          .toList();

      if (highSeverityIssues.isNotEmpty) {
        fail('High severity integration issues detected:\n${highSeverityIssues.map((i) => '- ${i.description}').join('\n')}');
      }
    });
  });
}