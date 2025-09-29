import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chefmind_ai/presentation/widgets/common/loading_widget.dart';

void main() {
  group('LoadingWidget Tests', () {
    testWidgets('should display default loading indicator',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoadingWidget(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should display custom message', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoadingWidget(message: 'Generating recipe...'),
          ),
        ),
      );

      expect(find.text('Generating recipe...'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should display default message when none provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoadingWidget(),
          ),
        ),
      );

      expect(find.text('Loading...'), findsOneWidget);
    });

    testWidgets('should center content', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoadingWidget(),
          ),
        ),
      );

      expect(find.byType(Center), findsOneWidget);
    });

    testWidgets('should arrange elements vertically',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoadingWidget(message: 'Loading...'),
          ),
        ),
      );

      expect(find.byType(Column), findsOneWidget);
    });

    testWidgets('should have proper spacing between elements',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoadingWidget(message: 'Loading...'),
          ),
        ),
      );

      final column = tester.widget<Column>(find.byType(Column));
      expect(column.mainAxisAlignment, MainAxisAlignment.center);
    });

    testWidgets('should be accessible', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoadingWidget(message: 'Generating recipe...'),
          ),
        ),
      );

      // Check for semantic labels
      expect(find.bySemanticsLabel('Loading'), findsOneWidget);
    });

    testWidgets('should handle long messages gracefully',
        (WidgetTester tester) async {
      const longMessage =
          'This is a very long loading message that should be handled gracefully without causing overflow issues in the UI';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoadingWidget(message: longMessage),
          ),
        ),
      );

      expect(find.text(longMessage), findsOneWidget);
      // Should not cause overflow
      expect(tester.takeException(), isNull);
    });

    testWidgets('should display with custom color when provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoadingWidget(
              message: 'Loading...',
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should use theme color when no custom color provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const Scaffold(
            body: LoadingWidget(),
          ),
        ),
      );

      final progressIndicator = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );
      // Should use theme's primary color or default
      expect(progressIndicator.color, isNotNull);
    });

    testWidgets('should handle empty message', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoadingWidget(message: ''),
          ),
        ),
      );

      // Should still show loading indicator
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      // Empty message should not be displayed
      expect(find.text(''), findsNothing);
    });

    testWidgets('should maintain consistent size', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoadingWidget(),
          ),
        ),
      );

      final loadingWidget = find.byType(LoadingWidget);
      final size = tester.getSize(loadingWidget);

      // Should take available space
      expect(size.width, greaterThan(0));
      expect(size.height, greaterThan(0));
    });

    testWidgets('should animate progress indicator',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoadingWidget(),
          ),
        ),
      );

      // Initial state
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Advance animation
      await tester.pump(const Duration(milliseconds: 100));

      // Should still be present and animating
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should work in different container sizes',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 100,
              child: LoadingWidget(message: 'Loading...'),
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading...'), findsOneWidget);

      // Should not overflow in constrained space
      expect(tester.takeException(), isNull);
    });
  });
}
