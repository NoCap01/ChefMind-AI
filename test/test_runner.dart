import 'package:flutter_test/flutter_test.dart';

// Import all test files
import 'unit/services/enhanced_mock_service_test.dart' as enhanced_mock_service_test;
import 'unit/services/cascading_ai_service_test.dart' as cascading_ai_service_test;
import 'unit/services/recipe_generation_service_test.dart' as recipe_generation_service_test;
import 'integration/api_services_test.dart' as api_services_test;
import 'widget/recipe_card_test.dart' as recipe_card_test;
import 'widget/ingredient_input_widget_test.dart' as ingredient_input_widget_test;
import 'widget/loading_widget_test.dart' as loading_widget_test;
import 'widget/error_widget_test.dart' as error_widget_test;
import 'widget_test.dart' as main_widget_test;

void main() {
  group('ChefMind AI Test Suite', () {
    group('Unit Tests', () {
      group('Services', () {
        enhanced_mock_service_test.main();
        cascading_ai_service_test.main();
        recipe_generation_service_test.main();
      });
    });

    group('Integration Tests', () {
      api_services_test.main();
    });

    group('Widget Tests', () {
      recipe_card_test.main();
      ingredient_input_widget_test.main();
      loading_widget_test.main();
      error_widget_test.main();
    });

    group('App Integration Tests', () {
      main_widget_test.main();
    });
  });
}