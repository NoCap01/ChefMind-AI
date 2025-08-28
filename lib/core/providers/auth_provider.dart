import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/user_profile.dart';
import '../../infrastructure/repositories/firebase_auth_repository.dart';
import '../../infrastructure/repositories/firebase_user_repository.dart';

// Auth State Provider
final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

// Current User Provider
final currentUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.when(
    data: (user) => user,
    loading: () => null,
    error: (_, __) => null,
  );
});

// User Profile Provider
final userProfileProvider = FutureProvider<UserProfile?>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return null;
  
  final userRepository = ref.read(userRepositoryProvider);
  try {
    return await userRepository.getUserProfile(user.uid);
  } catch (e) {
    return null;
  }
});

// Auth Repository Provider
final authRepositoryProvider = Provider<FirebaseAuthRepository>((ref) {
  return FirebaseAuthRepository();
});

// User Repository Provider
final userRepositoryProvider = Provider<FirebaseUserRepository>((ref) {
  return FirebaseUserRepository();
});

// Auth Controller
final authControllerProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(
    authRepository: ref.read(authRepositoryProvider),
    userRepository: ref.read(userRepositoryProvider),
  );
});

class AuthController extends StateNotifier<AuthState> {
  final FirebaseAuthRepository _authRepository;
  final FirebaseUserRepository _userRepository;

  AuthController({
    required FirebaseAuthRepository authRepository,
    required FirebaseUserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(const AuthState.initial());

  Future<void> signInWithGoogle() async {
    state = const AuthState.loading();
    try {
      final user = await _authRepository.signInWithGoogle();
      if (user != null) {
        // Check if user profile exists, create if not
        final profile = await _userRepository.getUserProfile(user.uid);
        if (profile == null) {
          await _createUserProfile(user);
        }
        state = AuthState.authenticated(user);
      } else {
        state = const AuthState.error('Google sign-in failed');
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    state = const AuthState.loading();
    try {
      final user = await _authRepository.signInWithEmail(email, password);
      if (user != null) {
        state = AuthState.authenticated(user);
      } else {
        state = const AuthState.error('Email sign-in failed');
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signUpWithEmail(String email, String password, String name) async {
    state = const AuthState.loading();
    try {
      final user = await _authRepository.signUpWithEmail(email, password);
      if (user != null) {
        await _createUserProfile(user, name: name);
        state = AuthState.authenticated(user);
      } else {
        state = const AuthState.error('Email sign-up failed');
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signOut() async {
    state = const AuthState.loading();
    try {
      await _authRepository.signOut();
      state = const AuthState.unauthenticated();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> _createUserProfile(User user, {String? name}) async {
    final profile = UserProfile(
      id: user.uid,
      name: name ?? user.displayName ?? 'User',
      email: user.email ?? '',
      preferences: const CookingPreferences(),
      createdAt: DateTime.now(),
      lastUpdated: DateTime.now(),
      profileImageUrl: user.photoURL,
    );
    
    await _userRepository.createUserProfile(profile);
  }
}

// Auth State
sealed class AuthState {
  const AuthState();
  
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.error(String message) = _Error;
}

class _Initial extends AuthState {
  const _Initial();
}

class _Loading extends AuthState {
  const _Loading();
}

class _Authenticated extends AuthState {
  final User user;
  const _Authenticated(this.user);
}

class _Unauthenticated extends AuthState {
  const _Unauthenticated();
}

class _Error extends AuthState {
  final String message;
  const _Error(this.message);
}