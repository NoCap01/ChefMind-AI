import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/services/authentication_service.dart';
import '../../infrastructure/services/firebase_auth_service.dart';
import '../../core/errors/app_exceptions.dart';

// Authentication service provider
final authServiceProvider = Provider<AuthenticationService>(
  (ref) => FirebaseAuthService(),
);

// Current user stream provider
final currentUserProvider = StreamProvider<UserProfile?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges;
});

// Authentication state provider
final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (ref) => AuthStateNotifier(ref.read(authServiceProvider)),
);

class AuthStateNotifier extends StateNotifier<AuthState> {
  final AuthenticationService _authService;

  AuthStateNotifier(this._authService) : super(const AuthState.initial()) {
    // Listen to auth state changes
    _authService.authStateChanges.listen((user) {
      if (user != null) {
        state = AuthState.authenticated(user);
      } else {
        state = const AuthState.unauthenticated();
      }
    });
  }

  Future<void> signInWithEmail(String email, String password) async {
    state = const AuthState.loading();
    try {
      final user = await _authService.signInWithEmail(email, password);
      if (user != null) {
        state = AuthState.authenticated(user);
      } else {
        state = const AuthState.error('Invalid credentials');
      }
    } on AuthenticationException catch (e) {
      state = AuthState.error(e.message);
    } catch (e) {
      state = const AuthState.error('An unexpected error occurred');
    }
  }

  Future<void> signInWithGoogle() async {
    state = const AuthState.loading();
    try {
      final user = await _authService.signInWithGoogle();
      if (user != null) {
        state = AuthState.authenticated(user);
      } else {
        state = const AuthState.error('Google sign-in was cancelled');
      }
    } on AuthenticationException catch (e) {
      state = AuthState.error(e.message);
    } catch (e) {
      state = const AuthState.error('Google sign-in failed');
    }
  }

  Future<void> createAccountWithEmail(
      String email, String password, String displayName) async {
    state = const AuthState.loading();
    try {
      final user = await _authService.createAccountWithEmail(
          email, password, displayName);
      if (user != null) {
        state = AuthState.authenticated(user);
      } else {
        state = const AuthState.error('Account creation failed');
      }
    } on AuthenticationException catch (e) {
      state = AuthState.error(e.message);
    } catch (e) {
      state = const AuthState.error('Failed to create account');
    }
  }

  Future<void> resetPassword(String email) async {
    state = const AuthState.loading();
    try {
      await _authService.resetPassword(email);
      state = const AuthState.passwordResetSent();
    } on AuthenticationException catch (e) {
      state = AuthState.error(e.message);
    } catch (e) {
      state = const AuthState.error('Failed to send password reset email');
    }
  }

  Future<void> signOut() async {
    state = const AuthState.loading();
    try {
      await _authService.signOut();
      state = const AuthState.unauthenticated();
    } catch (e) {
      state = const AuthState.error('Failed to sign out');
    }
  }

  Future<void> deleteAccount() async {
    state = const AuthState.loading();
    try {
      await _authService.deleteAccount();
      state = const AuthState.unauthenticated();
    } on AuthenticationException catch (e) {
      state = AuthState.error(e.message);
    } catch (e) {
      state = const AuthState.error('Failed to delete account');
    }
  }

  void clearError() {
    if (state is AuthStateError) {
      state = const AuthState.initial();
    }
  }
}

// Auth state sealed class with pattern matching
sealed class AuthState {
  const AuthState();

  const factory AuthState.initial() = AuthStateInitial;
  const factory AuthState.loading() = AuthStateLoading;
  const factory AuthState.authenticated(UserProfile user) =
      AuthStateAuthenticated;
  const factory AuthState.unauthenticated() = AuthStateUnauthenticated;
  const factory AuthState.error(String message) = AuthStateError;
  const factory AuthState.passwordResetSent() = AuthStatePasswordResetSent;

  // Helper methods
  bool get isAuthenticated => this is AuthStateAuthenticated;
  bool get isLoading => this is AuthStateLoading;
  bool get hasError => this is AuthStateError;

  @override
  UserProfile? get user => switch (this) {
        AuthStateAuthenticated(user: final user) => user,
        _ => null,
      };

  String? get errorMessage => switch (this) {
        AuthStateError(message: final message) => message,
        _ => null,
      };
}

class AuthStateInitial extends AuthState {
  const AuthStateInitial();
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading();
}

class AuthStateAuthenticated extends AuthState {
  @override
  final UserProfile user;
  const AuthStateAuthenticated(this.user);
}

class AuthStateUnauthenticated extends AuthState {
  const AuthStateUnauthenticated();
}

class AuthStateError extends AuthState {
  final String message;
  const AuthStateError(this.message);
}

class AuthStatePasswordResetSent extends AuthState {
  const AuthStatePasswordResetSent();
}

// Helper providers
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.isAuthenticated;
});

final currentUserIdProvider = Provider<String?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.user?.userId; // Changed from 'id' to 'userId'
});
