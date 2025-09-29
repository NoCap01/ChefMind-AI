# ChefMind AI

An AI-powered cooking assistant app built with Flutter that helps you create delicious recipes from available ingredients.

## Features

- 🤖 **AI Recipe Generation**: Generate custom recipes from your available ingredients
- 📱 **Cross-Platform**: Works on iOS, Android, and Web
- 🔥 **Firebase Integration**: User authentication and data storage
- 🍽️ **Meal Planning**: Plan your meals for the week
- 🛒 **Shopping Lists**: Generate shopping lists from recipes
- 📊 **Nutrition Tracking**: Track nutritional information
- 👥 **Social Features**: Share recipes with the community

## Getting Started

### Prerequisites

- Flutter SDK (>=3.10.0)
- Dart SDK (>=3.0.0)
- Firebase project (optional, for full functionality)
- OpenAI API key (optional, for AI recipe generation)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/chefmind_ai.git
   cd chefmind_ai
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up environment variables** (Optional)
   ```bash
   cp .env.example .env
   ```
   Edit `.env` file with your API keys:
   ```
   OPENAI_API_KEY=your-openai-api-key-here
   FIREBASE_PROJECT_ID=your-firebase-project-id
   ```

4. **Configure Firebase** (Optional)
   - Create a new Firebase project
   - Add your app to the project
   - Download configuration files:
     - `google-services.json` for Android (place in `android/app/`)
     - `GoogleService-Info.plist` for iOS (place in `ios/Runner/`)
   - Update `lib/core/config/firebase_options.dart` with your project details

5. **Run the app**
   ```bash
   flutter run
   ```

## Configuration

### Mock Data Mode

By default, the app runs in mock data mode, which means:
- Recipe generation uses mock data instead of OpenAI API
- Firebase authentication is optional
- All features work without external dependencies

To enable real API calls:
1. Set up your OpenAI API key in the environment
2. Set `ENABLE_MOCK_DATA=false` in your `.env` file
3. Configure Firebase for authentication

### OpenAI API Setup

1. Get an API key from [OpenAI](https://platform.openai.com/api-keys)
2. Add it to your `.env` file:
   ```
   OPENAI_API_KEY=sk-your-actual-api-key-here
   ```
3. Set `ENABLE_MOCK_DATA=false` to use real AI generation

### Firebase Setup

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Enable Authentication with Email/Password
3. Enable Firestore Database
4. Download configuration files and place them in the correct directories
5. Update `firebase_options.dart` with your project configuration

## Project Structure

```
lib/
├── application/          # Business logic and providers
│   ├── providers/       # Riverpod providers
│   └── usecases/       # Use cases
├── core/               # Core functionality
│   ├── config/         # Configuration files
│   ├── errors/         # Error handling
│   ├── router/         # Navigation
│   ├── services/       # Core services
│   ├── theme/          # App theming
│   └── utils/          # Utilities
├── domain/             # Domain layer
│   ├── entities/       # Domain entities
│   ├── enums/          # Enumerations
│   ├── repositories/   # Repository interfaces
│   └── services/       # Service interfaces
├── infrastructure/     # Infrastructure layer
│   ├── models/         # Data models
│   ├── repositories/   # Repository implementations
│   └── services/       # Service implementations
└── presentation/       # UI layer
    ├── screens/        # App screens
    └── widgets/        # Reusable widgets
```

## Features Overview

### Recipe Generation
- Input available ingredients
- Select cuisine type and meal preferences
- AI generates custom recipes with instructions
- Nutritional information included

### Meal Planning
- Weekly meal calendar
- Drag and drop meal planning
- Nutrition tracking
- Shopping list generation

### User Management
- Firebase authentication
- User preferences and dietary restrictions
- Cooking skill level tracking
- Recipe favorites and collections

### Social Features
- Share recipes with community
- Rate and review recipes
- Cooking challenges
- User groups

## Development

### Running Tests
```bash
flutter test
```

### Code Generation
```bash
flutter packages pub run build_runner build
```

### Linting
```bash
flutter analyze
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you encounter any issues or have questions:
1. Check the [Issues](https://github.com/yourusername/chefmind_ai/issues) page
2. Create a new issue if your problem isn't already reported
3. Provide detailed information about your environment and the issue

## Acknowledgments

- Flutter team for the amazing framework
- OpenAI for the GPT API
- Firebase for backend services
- The Flutter community for packages and inspiration