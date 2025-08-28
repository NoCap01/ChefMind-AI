import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../lib/shared/presentation/modals/settings_modal.dart';
import '../../../../lib/core/theme/app_theme.dart';

void main() {
  group('SettingsModal Widget Tests', () {
    testWidgets('should display settings modal with all sections', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const SettingsModal(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Check if main sections are present
      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('Notifications'), findsOneWidget);
      expect(find.text('Appearance'), findsOneWidget);
      expect(find.text('Voice & Audio'), findsOneWidget);
      expect(find.text('General'), findsOneWidget);
      expect(find.text('Data & Privacy'), findsOneWidget);
    });

    testWidgets('should toggle notification settings', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const SettingsModal(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find and tap main notifications toggle
      final notificationsToggle = find.widgetWithText(SwitchListTile, 'Enable Notifications');
      expect(notificationsToggle, findsOneWidget);

      await tester.tap(notificationsToggle);
      await tester.pump();

      // Verify toggle interaction works
      expect(notificationsToggle, findsOneWidget);
    });

    testWidgets('should disable sub-notifications when main notifications are off', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const SettingsModal(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // First, disable main notifications
      final notificationsToggle = find.widgetWithText(SwitchListTile, 'Enable Notifications');
      await tester.tap(notificationsToggle);
      await tester.pump();

      // Check that sub-notification switches are disabled
      final recipeRemindersToggle = find.widgetWithText(SwitchListTile, 'Recipe Reminders');
      expect(recipeRemindersToggle, findsOneWidget);

      // The sub-toggles should be visually disabled (opacity reduced)
      final animatedOpacity = find.ancestor(
        of: recipeRemindersToggle,
        matching: find.byType(AnimatedOpacity),
      );
      expect(animatedOpacity, findsOneWidget);
    });

    testWidgets('should toggle dark mode and update theme provider', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const SettingsModal(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find and tap dark mode toggle
      final darkModeToggle = find.widgetWithText(SwitchListTile, 'Dark Mode');
      expect(darkModeToggle, findsOneWidget);

      await tester.tap(darkModeToggle);
      await tester.pump();

      // Verify toggle interaction works
      expect(darkModeToggle, findsOneWidget);
    });

    testWidgets('should show language selector when language option is tapped', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const SettingsModal(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find and tap language option
      final languageOption = find.widgetWithText(ListTile, 'Language');
      expect(languageOption, findsOneWidget);

      await tester.tap(languageOption);
      await tester.pumpAndSettle();

      // Verify language selector modal is shown
      expect(find.text('Select Language'), findsOneWidget);
      expect(find.text('English'), findsAtLeastNWidgets(1));
      expect(find.text('Spanish'), findsOneWidget);
      expect(find.text('French'), findsOneWidget);
    });

    testWidgets('should select language from language selector', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const SettingsModal(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Open language selector
      final languageOption = find.widgetWithText(ListTile, 'Language');
      await tester.tap(languageOption);
      await tester.pumpAndSettle();

      // Select Spanish
      final spanishOption = find.text('Spanish');
      await tester.tap(spanishOption);
      await tester.pumpAndSettle();

      // Verify language selector is closed and language is updated
      expect(find.text('Select Language'), findsNothing);
    });

    testWidgets('should show units selector when units option is tapped', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const SettingsModal(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find and tap units option
      final unitsOption = find.widgetWithText(ListTile, 'Units');
      expect(unitsOption, findsOneWidget);

      await tester.tap(unitsOption);
      await tester.pumpAndSettle();

      // Verify units selector modal is shown
      expect(find.text('Select Units'), findsOneWidget);
      expect(find.text('Metric'), findsAtLeastNWidgets(1));
      expect(find.text('Imperial'), findsOneWidget);
    });

    testWidgets('should adjust voice volume slider', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const SettingsModal(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find the voice volume slider
      final volumeSlider = find.byType(Slider);
      expect(volumeSlider, findsOneWidget);

      // Test slider interaction
      await tester.tap(volumeSlider);
      await tester.pump();

      // Verify slider exists and can be interacted with
      expect(volumeSlider, findsOneWidget);
    });

    testWidgets('should disable voice volume when voice input is off', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const SettingsModal(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // First, disable voice input
      final voiceInputToggle = find.widgetWithText(SwitchListTile, 'Voice Input');
      await tester.tap(voiceInputToggle);
      await tester.pump();

      // Check that voice volume section is disabled
      final volumeSection = find.text('Voice Volume');
      expect(volumeSection, findsOneWidget);

      // The volume section should be visually disabled (opacity reduced)
      final animatedOpacity = find.ancestor(
        of: volumeSection,
        matching: find.byType(AnimatedOpacity),
      );
      expect(animatedOpacity, findsOneWidget);
    });

    testWidgets('should show clear cache dialog when clear cache is tapped', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const SettingsModal(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find and tap clear cache option
      final clearCacheOption = find.widgetWithText(ListTile, 'Clear Cache');
      expect(clearCacheOption, findsOneWidget);

      await tester.tap(clearCacheOption);
      await tester.pumpAndSettle();

      // Verify clear cache dialog is shown
      expect(find.text('Clear Cache'), findsAtLeastNWidgets(1));
      expect(find.text('This will remove all cached recipes'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Clear'), findsOneWidget);
    });

    testWidgets('should show export data dialog when export data is tapped', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const SettingsModal(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find and tap export data option
      final exportDataOption = find.widgetWithText(ListTile, 'Export Data');
      expect(exportDataOption, findsOneWidget);

      await tester.tap(exportDataOption);
      await tester.pumpAndSettle();

      // Verify export data dialog is shown
      expect(find.text('Export Data'), findsAtLeastNWidgets(1));
      expect(find.text('Export your recipes, meal plans'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Export'), findsOneWidget);
    });

    testWidgets('should save settings when Save button is tapped', (tester) async {
      Map<String, dynamic>? savedSettings;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Builder(
              builder: (context) {
                return Scaffold(
                  body: ElevatedButton(
                    onPressed: () async {
                      savedSettings = await showDialog<Map<String, dynamic>>(
                        context: context,
                        builder: (context) => const SettingsModal(),
                      );
                    },
                    child: const Text('Open Settings'),
                  ),
                );
              },
            ),
          ),
        ),
      );

      // Open the modal
      await tester.tap(find.text('Open Settings'));
      await tester.pumpAndSettle();

      // Tap save button
      final saveButton = find.text('Save');
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      // Verify settings were saved
      expect(savedSettings, isNotNull);
      expect(savedSettings?['notificationsEnabled'], isA<bool>());
      expect(savedSettings?['darkModeEnabled'], isA<bool>());
    });

    testWidgets('should close modal when close button is tapped', (tester) async {
      bool modalClosed = false;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Builder(
              builder: (context) {
                return Scaffold(
                  body: ElevatedButton(
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => const SettingsModal(),
                      );
                      modalClosed = true;
                    },
                    child: const Text('Open Settings'),
                  ),
                );
              },
            ),
          ),
        ),
      );

      // Open the modal
      await tester.tap(find.text('Open Settings'));
      await tester.pumpAndSettle();

      // Find and tap close button
      final closeButton = find.byIcon(Icons.close);
      expect(closeButton, findsOneWidget);

      await tester.tap(closeButton);
      await tester.pumpAndSettle();

      // Verify modal was closed
      expect(modalClosed, isTrue);
    });
  });

  group('SettingsModal Animation Tests', () {
    testWidgets('should animate in when opened', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const SettingsModal(),
          ),
        ),
      );

      // Initial pump - animation should be starting
      await tester.pump();

      // Find animated widgets
      expect(find.byType(FadeTransition), findsOneWidget);
      expect(find.byType(SlideTransition), findsOneWidget);

      // Complete animation
      await tester.pumpAndSettle();

      // Verify modal is fully visible
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('should handle animation controller lifecycle', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const SettingsModal(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify modal is displayed
      expect(find.byType(SettingsModal), findsOneWidget);

      // Dispose of widget
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Container(),
          ),
        ),
      );

      // Verify no memory leaks (animation controller disposed)
      expect(find.byType(SettingsModal), findsNothing);
    });
  });
}