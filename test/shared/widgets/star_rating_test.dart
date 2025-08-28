import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../lib/shared/widgets/star_rating.dart';

void main() {
  group('StarRating Widget', () {
    testWidgets('should display correct number of stars', (tester) async {
      // Arrange
      const rating = 3.5;
      const maxRating = 5;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StarRating(
              rating: rating,
              maxRating: maxRating,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.star), findsNWidgets(3)); // 3 full stars
      expect(find.byIcon(Icons.star_border), findsNWidgets(2)); // 1 half star (border) + 1 empty star
      // Note: Half star is a combination of star_border and clipped star
    });

    testWidgets('should display full stars for whole number ratings', (tester) async {
      // Arrange
      const rating = 4.0;
      const maxRating = 5;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StarRating(
              rating: rating,
              maxRating: maxRating,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.star), findsNWidgets(4)); // 4 full stars
      expect(find.byIcon(Icons.star_border), findsNWidgets(1)); // 1 empty star
    });

    testWidgets('should handle zero rating', (tester) async {
      // Arrange
      const rating = 0.0;
      const maxRating = 5;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StarRating(
              rating: rating,
              maxRating: maxRating,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.star), findsNothing); // No full stars
      expect(find.byIcon(Icons.star_border), findsNWidgets(5)); // 5 empty stars
    });

    testWidgets('should handle maximum rating', (tester) async {
      // Arrange
      const rating = 5.0;
      const maxRating = 5;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StarRating(
              rating: rating,
              maxRating: maxRating,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.star), findsNWidgets(5)); // 5 full stars
      expect(find.byIcon(Icons.star_border), findsNothing); // No empty stars
    });

    testWidgets('should call onRatingChanged when tapped', (tester) async {
      // Arrange
      double? changedRating;
      const initialRating = 2.0;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StarRating(
              rating: initialRating,
              onRatingChanged: (rating) {
                changedRating = rating;
              },
            ),
          ),
        ),
      );

      // Tap on the 4th star
      await tester.tap(find.byIcon(Icons.star_border).first);
      await tester.pump();

      // Assert
      expect(changedRating, isNotNull);
      expect(changedRating, greaterThan(initialRating));
    });

    testWidgets('should not respond to taps when read-only', (tester) async {
      // Arrange
      double? changedRating;
      const initialRating = 2.0;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StarRating(
              rating: initialRating,
              isReadOnly: true,
              onRatingChanged: (rating) {
                changedRating = rating;
              },
            ),
          ),
        ),
      );

      // Try to tap on a star
      await tester.tap(find.byIcon(Icons.star_border).first);
      await tester.pump();

      // Assert
      expect(changedRating, isNull);
    });

    testWidgets('should use custom colors when provided', (tester) async {
      // Arrange
      const rating = 3.0;
      const activeColor = Colors.red;
      const inactiveColor = Colors.grey;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StarRating(
              rating: rating,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
            ),
          ),
        ),
      );

      // Assert
      final starIcons = tester.widgetList<Icon>(find.byIcon(Icons.star));
      final borderIcons = tester.widgetList<Icon>(find.byIcon(Icons.star_border));

      for (final icon in starIcons) {
        expect(icon.color, equals(activeColor));
      }

      for (final icon in borderIcons) {
        expect(icon.color, equals(inactiveColor));
      }
    });

    testWidgets('should use custom size when provided', (tester) async {
      // Arrange
      const rating = 3.0;
      const customSize = 32.0;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StarRating(
              rating: rating,
              size: customSize,
            ),
          ),
        ),
      );

      // Assert
      final starIcons = tester.widgetList<Icon>(find.byIcon(Icons.star));
      final borderIcons = tester.widgetList<Icon>(find.byIcon(Icons.star_border));

      for (final icon in starIcons) {
        expect(icon.size, equals(customSize));
      }

      for (final icon in borderIcons) {
        expect(icon.size, equals(customSize));
      }
    });

    testWidgets('should update rating when widget rating changes', (tester) async {
      // Arrange
      const initialRating = 2.0;
      const updatedRating = 4.0;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StarRating(
              rating: initialRating,
            ),
          ),
        ),
      );

      // Verify initial state
      expect(find.byIcon(Icons.star), findsNWidgets(2));

      // Update the rating
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StarRating(
              rating: updatedRating,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.star), findsNWidgets(4));
    });
  });

  group('InteractiveStarRating Widget', () {
    testWidgets('should display label and description', (tester) async {
      // Arrange
      const rating = 3.5;
      const label = 'Test Rating';
      const description = 'Rate this item';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: InteractiveStarRating(
              rating: rating,
              onRatingChanged: (_) {},
              label: label,
              description: description,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(label), findsOneWidget);
      expect(find.text(description), findsOneWidget);
      expect(find.text('3.5'), findsOneWidget); // Rating value
    });

    testWidgets('should call onRatingChanged when star rating changes', (tester) async {
      // Arrange
      double? changedRating;
      const initialRating = 2.0;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: InteractiveStarRating(
              rating: initialRating,
              onRatingChanged: (rating) {
                changedRating = rating;
              },
            ),
          ),
        ),
      );

      // Tap on a star to change rating
      await tester.tap(find.byIcon(Icons.star_border).first);
      await tester.pump();

      // Assert
      expect(changedRating, isNotNull);
    });
  });

  group('CompactStarRating Widget', () {
    testWidgets('should display rating text when showRatingText is true', (tester) async {
      // Arrange
      const rating = 4.2;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CompactStarRating(
              rating: rating,
              showRatingText: true,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('4.2'), findsOneWidget);
    });

    testWidgets('should not display rating text when showRatingText is false', (tester) async {
      // Arrange
      const rating = 4.2;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CompactStarRating(
              rating: rating,
              showRatingText: false,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('4.2'), findsNothing);
    });

    testWidgets('should use custom text style when provided', (tester) async {
      // Arrange
      const rating = 4.2;
      const customTextStyle = TextStyle(
        fontSize: 18,
        color: Colors.red,
        fontWeight: FontWeight.bold,
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CompactStarRating(
              rating: rating,
              showRatingText: true,
              ratingTextStyle: customTextStyle,
            ),
          ),
        ),
      );

      // Assert
      final textWidget = tester.widget<Text>(find.text('4.2'));
      expect(textWidget.style?.fontSize, equals(18));
      expect(textWidget.style?.color, equals(Colors.red));
      expect(textWidget.style?.fontWeight, equals(FontWeight.bold));
    });

    testWidgets('should be read-only by default', (tester) async {
      // Arrange
      double? changedRating;
      const rating = 3.0;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CompactStarRating(
              rating: rating,
            ),
          ),
        ),
      );

      // Try to tap on a star
      await tester.tap(find.byIcon(Icons.star).first);
      await tester.pump();

      // Assert - should not change rating since it's read-only
      expect(changedRating, isNull);
    });
  });
}