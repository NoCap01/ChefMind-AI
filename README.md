# ChefMind AI

A professional-grade Flutter application that transforms ingredients into culinary masterpieces using AI technology.

## Features

- **AI-Powered Recipe Generation**: Generate personalized recipes using OpenAI's GPT API
- **Smart Ingredient Input**: Voice and text input with auto-suggestions
- **Recipe Management**: Save, organize, and rate your favorite recipes
- **Meal Planning**: AI-powered weekly meal suggestions with nutritional balance
- **Shopping & Pantry**: Smart shopping lists and pantry inventory management
- **Social Features**: Share recipes and connect with cooking enthusiasts
- **Learning System**: Interactive tutorials and skill development
- **Kitchen Tools**: Timers, converters, and cooking utilities
- **Analytics**: Personal cooking insights and nutrition tracking

## Architecture

The app follows Clean Architecture principles with:
- **Presentation Layer**: Flutter widgets and UI components
- **Application Layer**: Business logic and state management (Riverpod)
- **Domain Layer**: Entities, use cases, and repository interfaces
- **Infrastructure Layer**: External services and data sources

## Tech Stack

- **Frontend**: Flutter with Material 3 design
- **State Management**: Riverpod
- **Backend**: Firebase (Firestore, Auth, Storage)
- **AI Integration**: OpenAI GPT API
- **Local Storage**: Hive for offline caching
- **Navigation**: GoRouter
- **Animations**: Flutter Animate & Lottie

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Firebase project setup
- OpenAI API key

### Installation

1. Clone the repository:
```bash
git clone https://github.com/your-username/chefmind-ai.git
cd chefmind-ai
```

2. Install dependencies:
```bash
flutter pub get
```

3. Generate code files:
```bash
flutter packages pub run build_runner build
```

4. Configure Firebase:
   - Create a Firebase project
   - Add your app to the project
   - Download and add configuration files
   - Update `firebase_options.dart` with your project details

5. Set up environment variables:
   - Add your OpenAI API key to your environment
   - Configure other API keys as needed

6. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── core/                   # Core functionality
│   ├── config/            # App configuration
│   ├── providers/         # Global providers
│   ├── router/            # Navigation setup
│   ├── services/          # Core services
│   └── theme/             # App theming
├── domain/                # Domain layer
│   └── entities/          # Data models
├── infrastructure/        # Infrastructure layer
│   └── repositories/      # Data repositories
├── features/              # Feature modules
│   ├── auth/             # Authentication
│   ├── home/             # Home screen
│   ├── recipe_book/      # Recipe management
│   ├── shopping/         # Shopping & pantry
│   ├── meal_planner/     # Meal planning
│   ├── profile/          # User profile
│   └── recipe/           # Recipe details
└── shared/               # Shared components
    └── presentation/     # Reusable widgets
```

## Configuration

### Firebase Setup

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Enable Authentication (Google, Email/Password)
3. Set up Firestore database
4. Configure security rules
5. Add your app and download configuration files

### OpenAI API Setup

1. Get an API key from [OpenAI](https://platform.openai.com/)
2. Add the key to your environment variables
3. Configure the API client in the app

## Development

### Running Tests

```bash
# Unit tests
flutter test

# Integration tests
flutter test integration_test/
```

### Code Generation

```bash
# Generate freezed and json_serializable code
flutter packages pub run build_runner build

# Watch for changes
flutter packages pub run build_runner watch
```

### Building for Release

```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- OpenAI for the GPT API
- Firebase for backend services
- Flutter team for the amazing framework
- All contributors and testers

## Support

For support, email support@chefmind-ai.com or create an issue in the repository.