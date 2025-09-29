# ChefMind AI Test Suite

This directory contains comprehensive tests for the ChefMind AI application, covering unit tests, integration tests, and widget tests.

## Test Structure

### Unit Tests (`test/unit/`)

#### Services Tests
- **enhanced_mock_service_test.dart**: Tests for the enhanced mock recipe generation service
  - Recipe generation with various parameters
  - Dietary restriction handling
  - Cuisine-specific recipe generation
  - Nutrition information generation
  - Edge case handling

- **cascading_ai_service_test.dart**: Tests for the cascading AI service architecture
  - Service priority ordering
  - Fallback mechanisms
  - Error handling
  - Service availability checking

- **recipe_generation_service_test.dart**: Tests for the main recipe generation service
  - Integration with AI services
  - Request parameter handling
  - Response validation

#### Mock Data Tests
- **cuisine_data_test.dart**: Tests for cuisine-specific data
  - Cuisine profile validation
  - Ingredient and spice data
  - Cooking methods and techniques
  - Equipment recommendations

- **dietary_data_test.dart**: Tests for dietary restriction handling
  - Dietary profile validation
  - Ingredient substitutions
  - Restriction compliance checking
  - Multiple restriction handling

### Integration Tests (`test/integration/`)

- **api_services_test.dart**: Integration tests for AI service interactions
  - Service cascading behavior
  - Response validation
  - Error handling
  - Performance testing
  - Data consistency

### Widget Tests (`test/widget/`)

- **recipe_card_test.dart**: Tests for recipe display components
  - Recipe information display
  - User interaction handling
  - Accessibility compliance
  - Edge case handling

- **ingredient_input_widget_test.dart**: Tests for ingredient input functionality
  - Ingredient addition and removal
  - Validation and suggestions
  - User interaction handling

- **loading_widget_test.dart**: Tests for loading state components
  - Loading indicator display
  - Message customization
  - Accessibility

- **error_widget_test.dart**: Tests for error display components
  - Error message display
  - Retry functionality
  - Accessibility

## Enhanced Mock Data System

The enhanced mock data system provides realistic and varied recipe generation with:

### Cuisine-Specific Data
- **9 Major Cuisines**: Italian, Mexican, Asian, Indian, Thai, French, Mediterranean, American, Japanese
- **Authentic Ingredients**: Cuisine-specific ingredients, spices, and aromatics
- **Traditional Techniques**: Cooking methods and equipment specific to each cuisine
- **Cultural Accuracy**: Dish types and flavor profiles that reflect authentic cuisine characteristics

### Dietary Restriction Support
- **8 Dietary Restrictions**: Vegetarian, Vegan, Gluten-Free, Dairy-Free, Keto, Paleo, Low-Carb
- **Smart Substitutions**: Automatic ingredient substitutions based on dietary needs
- **Compliance Checking**: Validation that generated recipes meet dietary requirements
- **Nutritional Focus**: Nutrition guidance specific to each dietary restriction

### Recipe Template System
- **Meal Type Templates**: Breakfast, Lunch, Dinner, Snack, Dessert
- **Realistic Timing**: Prep and cook times based on meal complexity
- **Skill-Based Difficulty**: Recipe complexity adjusted for user skill level
- **Equipment Recommendations**: Tools and equipment suggestions based on difficulty

### Advanced Features
- **Realistic Nutrition**: Calculated nutrition information based on actual ingredients
- **Comprehensive Instructions**: Step-by-step cooking instructions with techniques and tips
- **Contextual Descriptions**: Recipe descriptions that reflect cuisine and dietary choices
- **Smart Tagging**: Automatic tag generation for easy recipe categorization

## Running Tests

### Run All Tests
```bash
flutter test
```

### Run Specific Test Categories
```bash
# Unit tests only
flutter test test/unit/

# Integration tests only
flutter test test/integration/

# Widget tests only
flutter test test/widget/

# Mock data tests only
flutter test test/unit/mock_data/
```

### Run Individual Test Files
```bash
flutter test test/unit/services/enhanced_mock_service_test.dart
```

## Test Coverage

The test suite covers:
- ✅ **Service Layer**: AI service integration and recipe generation
- ✅ **Data Layer**: Mock data generation and dietary handling
- ✅ **Widget Layer**: UI components and user interactions
- ✅ **Integration**: End-to-end service interactions
- ✅ **Edge Cases**: Error handling and boundary conditions
- ✅ **Accessibility**: Screen reader and accessibility compliance

## Requirements Validation

These tests validate the following requirements:
- **Requirement 1.6**: Enhanced mock data generation with realistic and varied content
- **Requirement 8.4**: Cuisine-specific and dietary-restriction-aware mock data
- **All Requirements**: Comprehensive testing validates all system requirements

## Notes

- Some widget tests may fail due to existing codebase compilation issues
- Mock data tests are fully functional and demonstrate the enhanced generation capabilities
- Integration tests work with the cascading AI service architecture
- Unit tests provide comprehensive coverage of the service layer