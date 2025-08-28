import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user_profile.dart';
import '../../domain/services/authentication_service.dart';
import '../../domain/exceptions/app_exceptions.dart';
import '../../infrastructure/services/firebase_authentication_service.dart';

// Authentication service provider
final authServiceProvider = Provider<IAuthenticationService>((ref) {
  return FirebaseAuthenticationService.instance;
});

// Current Firebase user stream provider
final firebaseUserProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges;
});

// Authentication state provider
final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthStateNotifier(authService);
});

// User profile provider
final userProfileProvider = StateNotifierProvider<UserProfileNotifier, AsyncValue<UserProfile?>>((ref) {
  final authService = ref.watch(authServiceProvider);
  final authState = ref.watch(authStateProvider);
  return UserProfileNotifier(authService, authState);
});

// Authentication loading state provider
final authLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.isLoading;
});

// Is authenticated provider
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.isAuthenticated;
});

// Current user ID provider
final currentUserIdProvider = Provider<String?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.user?.uid;
});

// Authentication error provider
final authErrorProvider = Provider<String?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.errorMessage;
});

/// Authentication state model
class AuthState {
  final User? user;
  final bool isLoading;
  final String? errorMessage;
  final AuthStatus status;

  const AuthState({
    this.user,
    this.isLoading = false,
    this.errorMessage,
    this.status = AuthStatus.unknown,
  });

  bool get isAuthenticated => user != null && status == AuthStatus.authenticated;
  bool get isUnauthenticated => user == null && status == AuthStatus.unauthenticated;

  AuthState copyWith({
    User? user,
    bool? isLoading,
    String? errorMessage,
    AuthStatus? status,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthState &&
        other.user?.uid == user?.uid &&
        other.isLoading == isLoading &&
        other.errorMessage == errorMessage &&
        other.status == status;
  }

  @override
  int get hashCode {
    return user?.uid.hashCode ?? 0 ^
        isLoading.hashCode ^
        errorMessage.hashCode ^
        status.hashCode;
  }
}

enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
  emailNotVerified,
}

/// Authentication state notifier
class AuthStateNotifier extends StateNotifier<AuthState> {
  final IAuthenticationService _authService;

  AuthStateNotifier(this._authService) : super(const AuthState()) {
    _init();
  }

  void _init() {
    // Listen to auth state changes
    _authService.authStateChanges.listen((user) {
      if (user != null) {
        state = state.copyWith(
          user: user,
          status: user.emailVerified ? AuthStatus.authenticated : AuthStatus.emailNotVerified,
          isLoading: false,
          errorMessage: null,
        );
      } else {
        state = state.copyWith(
          user: null,
          status: AuthStatus.unauthenticated,
          isLoading: false,
          errorMessage: null,
        );
      }
    });
  }

  /// Sign in with email and password
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      await _authService.signInWithEmailAndPassword(email, password);
      // State will be updated by the auth state listener
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _getErrorMessage(e),
      );
    }
  }

  /// Sign up with email and password
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      await _authService.signUpWithEmailAndPassword(email, password);
      // State will be updated by the auth state listener
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _getErrorMessage(e),
      );
    }
  }

  /// Sign in with Google
  Future<void> signInWithGoogle() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      await _authService.signInWithGoogle();
      // State will be updated by the auth state listener
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _getErrorMessage(e),
      );
    }
  }

  /// Sign out
  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      await _authService.signOut();
      // State will be updated by the auth state listener
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _getErrorMessage(e),
      );
    }
  }

  /// Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      await _authService.sendPasswordResetEmail(email);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _getErrorMessage(e),
      );
    }
  }

  /// Send email verification
  Future<void> sendEmailVerification() async {
    if (state.user == null) return;
    
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      await _authService.sendEmailVerification();
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _getErrorMessage(e),
      );
    }
  }

  /// Update password
  Future<void> updatePassword(String newPassword) async {
    if (state.user == null) return;
    
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      await _authService.updatePassword(newPassword);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _getErrorMessage(e),
      );
    }
  }

  /// Delete account
  Future<void> deleteAccount() async {
    if (state.user == null) return;
    
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      await _authService.deleteAccount();
      // State will be updated by the auth state listener
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _getErrorMessage(e),
      );
    }
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  /// Refresh current user
  Future<void> refreshUser() async {
    if (state.user == null) return;
    
    try {
      await state.user!.reload();
      final refreshedUser = _authService.currentUser;
      if (refreshedUser != null) {
        state = state.copyWith(
          user: refreshedUser,
          status: refreshedUser.emailVerified ? AuthStatus.authenticated : AuthStatus.emailNotVerified,
        );
      }
    } catch (e) {
      state = state.copyWith(errorMessage: _getErrorMessage(e));
    }
  }

  String _getErrorMessage(dynamic error) {
    if (error is AuthenticationException) {
      return error.message;
    } else if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          return 'No user found with this email address.';
        case 'wrong-password':
          return 'Incorrect password.';
        case 'email-already-in-use':
          return 'An account already exists with this email address.';
        case 'weak-password':
          return 'Password is too weak.';
        case 'invalid-email':
          return 'Invalid email address.';
        case 'user-disabled':
          return 'This account has been disabled.';
        case 'too-many-requests':
          return 'Too many failed attempts. Please try again later.';
        case 'operation-not-allowed':
          return 'This sign-in method is not enabled.';
        case 'requires-recent-login':
          return 'Please sign in again to complete this action.';
        default:
          return error.message ?? 'An authentication error occurred.';
      }
    } else {
      return 'An unexpected error occurred.';
    }
  }
}

/// User profile state notifier
class UserProfileNotifier extends StateNotifier<AsyncValue<UserProfile?>> {
  final IAuthenticationService _authService;
  final AuthState _authState;

  UserProfileNotifier(this._authService, this._authState) 
      : super(const AsyncValue.loading()) {
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    if (_authState.user == null) {
      state = const AsyncValue.data(null);
      return;
    }

    try {
      final profile = await _authService.getUserProfile(_authState.user!.uid);
      state = AsyncValue.data(profile);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Update user profile
  Future<void> updateProfile(UserProfile profile) async {
    if (_authState.user == null) return;

    state = const AsyncValue.loading();
    
    try {
      await _authService.updateUserProfile(profile);
      state = AsyncValue.data(profile);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Update user preferences
  Future<void> updatePreferences(UserPreferences preferences) async {
    final currentProfile = state.value;
    if (currentProfile == null) return;

    final updatedProfile = currentProfile.copyWith(preferences: preferences);
    await updateProfile(updatedProfile);
  }

  /// Update dietary restrictions
  Future<void> updateDietaryRestrictions(List<DietaryRestriction> restrictions) async {
    final currentProfile = state.value;
    if (currentProfile == null) return;

    final updatedPreferences = currentProfile.preferences.copyWith(
      dietaryRestrictions: restrictions,
    );
    await updatePreferences(updatedPreferences);
  }

  /// Update skill level
  Future<void> updateSkillLevel(SkillLevel skillLevel) async {
    final currentProfile = state.value;
    if (currentProfile == null) return;

    final updatedPreferences = currentProfile.preferences.copyWith(
      skillLevel: skillLevel,
    );
    await updatePreferences(updatedPreferences);
  }

  /// Add favorite cuisine
  Future<void> addFavoriteCuisine(String cuisine) async {
    final currentProfile = state.value;
    if (currentProfile == null) return;

    final currentCuisines = List<String>.from(currentProfile.preferences.favoriteCuisines);
    if (!currentCuisines.contains(cuisine)) {
      currentCuisines.add(cuisine);
      final updatedPreferences = currentProfile.preferences.copyWith(
        favoriteCuisines: currentCuisines,
      );
      await updatePreferences(updatedPreferences);
    }
  }

  /// Remove favorite cuisine
  Future<void> removeFavoriteCuisine(String cuisine) async {
    final currentProfile = state.value;
    if (currentProfile == null) return;

    final currentCuisines = List<String>.from(currentProfile.preferences.favoriteCuisines);
    if (currentCuisines.remove(cuisine)) {
      final updatedPreferences = currentProfile.preferences.copyWith(
        favoriteCuisines: currentCuisines,
      );
      await updatePreferences(updatedPreferences);
    }
  }

  /// Add disliked ingredient
  Future<void> addDislikedIngredient(String ingredient) async {
    final currentProfile = state.value;
    if (currentProfile == null) return;

    final currentIngredients = List<String>.from(currentProfile.preferences.dislikedIngredients);
    if (!currentIngredients.contains(ingredient)) {
      currentIngredients.add(ingredient);
      final updatedPreferences = currentProfile.preferences.copyWith(
        dislikedIngredients: currentIngredients,
      );
      await updatePreferences(updatedPreferences);
    }
  }

  /// Remove disliked ingredient
  Future<void> removeDislikedIngredient(String ingredient) async {
    final currentProfile = state.value;
    if (currentProfile == null) return;

    final currentIngredients = List<String>.from(currentProfile.preferences.dislikedIngredients);
    if (currentIngredients.remove(ingredient)) {
      final updatedPreferences = currentProfile.preferences.copyWith(
        dislikedIngredients: currentIngredients,
      );
      await updatePreferences(updatedPreferences);
    }
  }

  /// Update nutrition goals
  Future<void> updateNutritionGoals(NutritionGoals goals) async {
    final currentProfile = state.value;
    if (currentProfile == null) return;

    final updatedProfile = currentProfile.copyWith(nutritionGoals: goals);
    await updateProfile(updatedProfile);
  }

  /// Refresh user profile from server
  Future<void> refresh() async {
    await _loadUserProfile();
  }
}

// Convenience providers for specific user profile data
final userPreferencesProvider = Provider<UserPreferences?>((ref) {
  final profileAsync = ref.watch(userProfileProvider);
  return profileAsync.value?.preferences;
});

final userDietaryRestrictionsProvider = Provider<List<DietaryRestriction>>((ref) {
  final preferences = ref.watch(userPreferencesProvider);
  return preferences?.dietaryRestrictions ?? [];
});

final userSkillLevelProvider = Provider<SkillLevel>((ref) {
  final preferences = ref.watch(userPreferencesProvider);
  return preferences?.skillLevel ?? SkillLevel.beginner;
});

final userFavoriteCuisinesProvider = Provider<List<String>>((ref) {
  final preferences = ref.watch(userPreferencesProvider);
  return preferences?.favoriteCuisines ?? [];
});

final userDislikedIngredientsProvider = Provider<List<String>>((ref) {
  final preferences = ref.watch(userPreferencesProvider);
  return preferences?.dislikedIngredients ?? [];
});

final userNutritionGoalsProvider = Provider<NutritionGoals?>((ref) {
  final profileAsync = ref.watch(userProfileProvider);
  return profileAsync.value?.nutritionGoals;
});

final userKitchenEquipmentProvider = Provider<List<KitchenEquipment>>((ref) {
  final profileAsync = ref.watch(userProfileProvider);
  return profileAsync.value?.kitchenEquipment ?? [];
});

// Authentication form providers for UI state management
final emailProvider = StateProvider<String>((ref) => '');
final passwordProvider = StateProvider<String>((ref) => '');
final confirmPasswordProvider = StateProvider<String>((ref) => '');
final rememberMeProvider = StateProvider<bool>((ref) => false);

// Form validation providers
final isEmailValidProvider = Provider<bool>((ref) {
  final email = ref.watch(emailProvider);
  return _isValidEmail(email);
});

final isPasswordValidProvider = Provider<bool>((ref) {
  final password = ref.watch(passwordProvider);
  return password.length >= 6;
});

final doPasswordsMatchProvider = Provider<bool>((ref) {
  final password = ref.watch(passwordProvider);
  final confirmPassword = ref.watch(confirmPasswordProvider);
  return password == confirmPassword && password.isNotEmpty;
});

final canSignInProvider = Provider<bool>((ref) {
  final isEmailValid = ref.watch(isEmailValidProvider);
  final isPasswordValid = ref.watch(isPasswordValidProvider);
  final isLoading = ref.watch(authLoadingProvider);
  return isEmailValid && isPasswordValid && !isLoading;
});

final canSignUpProvider = Provider<bool>((ref) {
  final isEmailValid = ref.watch(isEmailValidProvider);
  final isPasswordValid = ref.watch(isPasswordValidProvider);
  final doPasswordsMatch = ref.watch(doPasswordsMatchProvider);
  final isLoading = ref.watch(authLoadingProvider);
  return isEmailValid && isPasswordValid && doPasswordsMatch && !isLoading;
});

// Helper functions
bool _isValidEmail(String email) {
  return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email);
}