import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:chefmind_ai/application/providers/auth_provider.dart';
import 'package:chefmind_ai/domain/services/authentication_service.dart';
import 'package:chefmind_ai/domain/entities/user_profile.dart';
import 'package:chefmind_ai/domain/exceptions/app_exceptions.dart';

import 'auth_provider_test.mocks.dart';

@GenerateMocks([
  IAuthenticationService,
  User,
  UserCredential,
])
void main() {
  group('AuthStateNotifier', () {
    late MockIAuthenticationService mockAuthService;
    late ProviderContainer container;
    late AuthStateNotifier authNotifier;

    setUp(() {
      mockAuthService = MockIAuthenticationService();
      container = ProviderContainer(
        overrides: [
          authServiceProvider.overrideWithValue(mockAuthService),
        ],
      );
      
      // Setup default auth state stream
      when(mockAuthService.authStateChanges).thenAnswer((_) => Stream.value(null));
      
      authNotifier = container.read(authStateProvider.notifier);
    });

    tearDown(() {
      container.dispose();
    });

    group('initialization', () {
      test('should start with unknown auth state', () {
        final state = container.read(authStateProvider);
        expect(state.status, equals(AuthStatus.unknown));
        expect(state.user, isNull);
        expect(state.isLoading, isFalse);
      });

      test('should update state when user signs in', () async {
        final mockUser = MockUser();
        when(mockUser.uid).thenReturn('test-uid');
        when(mockUser.email).thenReturn('test@example.com');
        when(mockUser.emailVerified).thenReturn(true);
        
        when(mockAuthService.authStateChanges).thenAnswer((_) => Stream.value(mockUser));
        
        // Create new notifier to trigger initialization
        final newContainer = ProviderContainer(
          overrides: [
            authServiceProvider.overrideWithValue(mockAuthService),
          ],
        );
        
        await Future.delayed(Duration.zero); // Allow stream to emit
        
        final state = newContainer.read(authStateProvider);
        expect(state.status, equals(AuthStatus.authenticated));
        expect(state.user, equals(mockUser));
        expect(state.isAuthenticated, isTrue);
        
        newContainer.dispose();
      });

      test('should handle email not verified state', () async {
        final mockUser = MockUser();
        when(mockUser.uid).thenReturn('test-uid');
        when(mockUser.email).thenReturn('test@example.com');
        when(mockUser.emailVerified).thenReturn(false);
        
        when(mockAuthService.authStateChanges).thenAnswer((_) => Stream.value(mockUser));
        
        final newContainer = ProviderContainer(
          overrides: [
            authServiceProvider.overrideWithValue(mockAuthService),
          ],
        );
        
        await Future.delayed(Duration.zero);
        
        final state = newContainer.read(authStateProvider);
        expect(state.status, equals(AuthStatus.emailNotVerified));
        expect(state.isAuthenticated, isFalse);
        
        newContainer.dispose();
      });
    });

    group('signInWithEmailAndPassword', () {
      test('should set loading state and clear errors', () async {
        when(mockAuthService.signInWithEmailAndPassword(any, any))
            .thenAnswer((_) async => MockUserCredential());
        
        final future = authNotifier.signInWithEmailAndPassword('test@example.com', 'password');
        
        // Check loading state
        expect(container.read(authStateProvider).isLoading, isTrue);
        expect(container.read(authStateProvider).errorMessage, isNull);
        
        await future;
        
        verify(mockAuthService.signInWithEmailAndPassword('test@example.com', 'password')).called(1);
      });

      test('should handle authentication errors', () async {
        const errorMessage = 'Invalid credentials';
        when(mockAuthService.signInWithEmailAndPassword(any, any))
            .thenThrow(const AuthenticationException(errorMessage));
        
        await authNotifier.signInWithEmailAndPassword('test@example.com', 'wrong-password');
        
        final state = container.read(authStateProvider);
        expect(state.isLoading, isFalse);
        expect(state.errorMessage, equals(errorMessage));
      });

      test('should handle FirebaseAuth errors', () async {
        when(mockAuthService.signInWithEmailAndPassword(any, any))
            .thenThrow(FirebaseAuthException(code: 'user-not-found'));
        
        await authNotifier.signInWithEmailAndPassword('test@example.com', 'password');
        
        final state = container.read(authStateProvider);
        expect(state.isLoading, isFalse);
        expect(state.errorMessage, equals('No user found with this email address.'));
      });
    });

    group('signUpWithEmailAndPassword', () {
      test('should call auth service with correct parameters', () async {
        when(mockAuthService.signUpWithEmailAndPassword(any, any))
            .thenAnswer((_) async => MockUserCredential());
        
        await authNotifier.signUpWithEmailAndPassword('test@example.com', 'password');
        
        verify(mockAuthService.signUpWithEmailAndPassword('test@example.com', 'password')).called(1);
      });

      test('should handle sign up errors', () async {
        when(mockAuthService.signUpWithEmailAndPassword(any, any))
            .thenThrow(FirebaseAuthException(code: 'email-already-in-use'));
        
        await authNotifier.signUpWithEmailAndPassword('test@example.com', 'password');
        
        final state = container.read(authStateProvider);
        expect(state.errorMessage, equals('An account already exists with this email address.'));
      });
    });

    group('signInWithGoogle', () {
      test('should call auth service', () async {
        when(mockAuthService.signInWithGoogle())
            .thenAnswer((_) async => MockUserCredential());
        
        await authNotifier.signInWithGoogle();
        
        verify(mockAuthService.signInWithGoogle()).called(1);
      });

      test('should handle Google sign in errors', () async {
        when(mockAuthService.signInWithGoogle())
            .thenThrow(const AuthenticationException('Google sign in failed'));
        
        await authNotifier.signInWithGoogle();
        
        final state = container.read(authStateProvider);
        expect(state.errorMessage, equals('Google sign in failed'));
      });
    });

    group('signOut', () {
      test('should call auth service', () async {
        when(mockAuthService.signOut()).thenAnswer((_) async {});
        
        await authNotifier.signOut();
        
        verify(mockAuthService.signOut()).called(1);
      });

      test('should handle sign out errors', () async {
        when(mockAuthService.signOut())
            .thenThrow(const AuthenticationException('Sign out failed'));
        
        await authNotifier.signOut();
        
        final state = container.read(authStateProvider);
        expect(state.errorMessage, equals('Sign out failed'));
      });
    });

    group('sendPasswordResetEmail', () {
      test('should call auth service with email', () async {
        when(mockAuthService.sendPasswordResetEmail(any)).thenAnswer((_) async {});
        
        await authNotifier.sendPasswordResetEmail('test@example.com');
        
        verify(mockAuthService.sendPasswordResetEmail('test@example.com')).called(1);
      });
    });

    group('clearError', () {
      test('should clear error message', () async {
        // Set an error first
        when(mockAuthService.signInWithEmailAndPassword(any, any))
            .thenThrow(const AuthenticationException('Test error'));
        
        await authNotifier.signInWithEmailAndPassword('test@example.com', 'password');
        expect(container.read(authStateProvider).errorMessage, isNotNull);
        
        // Clear the error
        authNotifier.clearError();
        expect(container.read(authStateProvider).errorMessage, isNull);
      });
    });
  });

  group('UserProfileNotifier', () {
    late MockIAuthenticationService mockAuthService;
    late ProviderContainer container;
    late UserProfile testProfile;

    setUp(() {
      mockAuthService = MockIAuthenticationService();
      
      testProfile = UserProfile(
        uid: 'test-uid',
        email: 'test@example.com',
        displayName: 'Test User',
        preferences: UserPreferences(
          dietaryRestrictions: [DietaryRestriction.vegetarian],
          favoriteCuisines: ['Italian', 'Mexican'],
          dislikedIngredients: ['mushrooms'],
          skillLevel: SkillLevel.intermediate,
          spicePreference: SpicePreference.medium,
          preferQuickMeals: true,
          preferHealthyOptions: true,
        ),
        createdAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
      );

      final mockUser = MockUser();
      when(mockUser.uid).thenReturn('test-uid');
      when(mockUser.email).thenReturn('test@example.com');
      when(mockUser.emailVerified).thenReturn(true);

      when(mockAuthService.authStateChanges).thenAnswer((_) => Stream.value(mockUser));
      when(mockAuthService.getUserProfile('test-uid')).thenAnswer((_) async => testProfile);

      container = ProviderContainer(
        overrides: [
          authServiceProvider.overrideWithValue(mockAuthService),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('should load user profile on initialization', () async {
      await Future.delayed(Duration.zero); // Allow async operations to complete
      
      final profileState = container.read(userProfileProvider);
      expect(profileState.value, equals(testProfile));
    });

    test('should update user profile', () async {
      final notifier = container.read(userProfileProvider.notifier);
      final updatedProfile = testProfile.copyWith(displayName: 'Updated Name');
      
      when(mockAuthService.updateUserProfile(updatedProfile)).thenAnswer((_) async {});
      
      await notifier.updateProfile(updatedProfile);
      
      final profileState = container.read(userProfileProvider);
      expect(profileState.value?.displayName, equals('Updated Name'));
      verify(mockAuthService.updateUserProfile(updatedProfile)).called(1);
    });

    test('should update dietary restrictions', () async {
      final notifier = container.read(userProfileProvider.notifier);
      final newRestrictions = [DietaryRestriction.vegan, DietaryRestriction.glutenFree];
      
      when(mockAuthService.updateUserProfile(any)).thenAnswer((_) async {});
      
      await notifier.updateDietaryRestrictions(newRestrictions);
      
      final profileState = container.read(userProfileProvider);
      expect(profileState.value?.preferences.dietaryRestrictions, equals(newRestrictions));
    });

    test('should add favorite cuisine', () async {
      final notifier = container.read(userProfileProvider.notifier);
      
      when(mockAuthService.updateUserProfile(any)).thenAnswer((_) async {});
      
      await notifier.addFavoriteCuisine('Japanese');
      
      final profileState = container.read(userProfileProvider);
      expect(profileState.value?.preferences.favoriteCuisines, contains('Japanese'));
    });

    test('should not add duplicate favorite cuisine', () async {
      final notifier = container.read(userProfileProvider.notifier);
      
      when(mockAuthService.updateUserProfile(any)).thenAnswer((_) async {});
      
      await notifier.addFavoriteCuisine('Italian'); // Already exists
      
      final profileState = container.read(userProfileProvider);
      final italianCount = profileState.value?.preferences.favoriteCuisines
          .where((cuisine) => cuisine == 'Italian').length;
      expect(italianCount, equals(1));
    });

    test('should remove favorite cuisine', () async {
      final notifier = container.read(userProfileProvider.notifier);
      
      when(mockAuthService.updateUserProfile(any)).thenAnswer((_) async {});
      
      await notifier.removeFavoriteCuisine('Italian');
      
      final profileState = container.read(userProfileProvider);
      expect(profileState.value?.preferences.favoriteCuisines, isNot(contains('Italian')));
    });
  });

  group('Form validation providers', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should validate email correctly', () {
      container.read(emailProvider.notifier).state = 'invalid-email';
      expect(container.read(isEmailValidProvider), isFalse);
      
      container.read(emailProvider.notifier).state = 'valid@example.com';
      expect(container.read(isEmailValidProvider), isTrue);
    });

    test('should validate password length', () {
      container.read(passwordProvider.notifier).state = '123';
      expect(container.read(isPasswordValidProvider), isFalse);
      
      container.read(passwordProvider.notifier).state = '123456';
      expect(container.read(isPasswordValidProvider), isTrue);
    });

    test('should check password confirmation match', () {
      container.read(passwordProvider.notifier).state = 'password123';
      container.read(confirmPasswordProvider.notifier).state = 'different';
      expect(container.read(doPasswordsMatchProvider), isFalse);
      
      container.read(confirmPasswordProvider.notifier).state = 'password123';
      expect(container.read(doPasswordsMatchProvider), isTrue);
    });

    test('should determine if user can sign in', () {
      // Invalid email
      container.read(emailProvider.notifier).state = 'invalid';
      container.read(passwordProvider.notifier).state = 'password123';
      expect(container.read(canSignInProvider), isFalse);
      
      // Valid credentials
      container.read(emailProvider.notifier).state = 'test@example.com';
      expect(container.read(canSignInProvider), isTrue);
    });

    test('should determine if user can sign up', () {
      // Set valid email and password
      container.read(emailProvider.notifier).state = 'test@example.com';
      container.read(passwordProvider.notifier).state = 'password123';
      
      // Passwords don't match
      container.read(confirmPasswordProvider.notifier).state = 'different';
      expect(container.read(canSignUpProvider), isFalse);
      
      // Passwords match
      container.read(confirmPasswordProvider.notifier).state = 'password123';
      expect(container.read(canSignUpProvider), isTrue);
    });
  });

  group('Convenience providers', () {
    late ProviderContainer container;
    late UserProfile testProfile;

    setUp(() {
      testProfile = UserProfile(
        uid: 'test-uid',
        email: 'test@example.com',
        displayName: 'Test User',
        preferences: UserPreferences(
          dietaryRestrictions: [DietaryRestriction.vegetarian],
          favoriteCuisines: ['Italian', 'Mexican'],
          dislikedIngredients: ['mushrooms'],
          skillLevel: SkillLevel.intermediate,
          spicePreference: SpicePreference.medium,
          preferQuickMeals: true,
          preferHealthyOptions: true,
        ),
        nutritionGoals: NutritionGoals(
          dailyCalories: 2000,
          dailyProtein: 150,
          dailyCarbs: 250,
          dailyFat: 65,
        ),
        kitchenEquipment: [
          KitchenEquipment(name: 'Oven', category: 'Cooking'),
          KitchenEquipment(name: 'Blender', category: 'Preparation'),
        ],
        createdAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
      );

      container = ProviderContainer(
        overrides: [
          userProfileProvider.overrideWith((ref) => 
            AsyncValue.data(testProfile)),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('should provide user preferences', () {
      final preferences = container.read(userPreferencesProvider);
      expect(preferences, equals(testProfile.preferences));
    });

    test('should provide dietary restrictions', () {
      final restrictions = container.read(userDietaryRestrictionsProvider);
      expect(restrictions, equals([DietaryRestriction.vegetarian]));
    });

    test('should provide skill level', () {
      final skillLevel = container.read(userSkillLevelProvider);
      expect(skillLevel, equals(SkillLevel.intermediate));
    });

    test('should provide favorite cuisines', () {
      final cuisines = container.read(userFavoriteCuisinesProvider);
      expect(cuisines, equals(['Italian', 'Mexican']));
    });

    test('should provide disliked ingredients', () {
      final ingredients = container.read(userDislikedIngredientsProvider);
      expect(ingredients, equals(['mushrooms']));
    });

    test('should provide nutrition goals', () {
      final goals = container.read(userNutritionGoalsProvider);
      expect(goals?.dailyCalories, equals(2000));
    });

    test('should provide kitchen equipment', () {
      final equipment = container.read(userKitchenEquipmentProvider);
      expect(equipment, hasLength(2));
      expect(equipment.first.name, equals('Oven'));
    });
  });
}