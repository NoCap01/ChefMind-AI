import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../../core/config/app_config.dart';
import '../../domain/exceptions/app_exceptions.dart';

class FirebaseService {
  static FirebaseService? _instance;
  static FirebaseService get instance => _instance ??= FirebaseService._();
  
  FirebaseService._();

  // Firebase instances
  late final FirebaseAuth _auth;
  late final FirebaseFirestore _firestore;
  late final FirebaseStorage _storage;
  late final FirebaseAnalytics _analytics;
  late final FirebaseFunctions _functions;

  // Getters
  FirebaseAuth get auth => _auth;
  FirebaseFirestore get firestore => _firestore;
  FirebaseStorage get storage => _storage;
  FirebaseAnalytics get analytics => _analytics;
  FirebaseFunctions get functions => _functions;

  // Initialize Firebase services
  Future<void> initialize() async {
    try {
      // Initialize Firebase if not already initialized
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
      }

      // Initialize services
      _auth = FirebaseAuth.instance;
      _firestore = FirebaseFirestore.instance;
      _storage = FirebaseStorage.instance;
      _analytics = FirebaseAnalytics.instance;
      _functions = FirebaseFunctions.instance;

      // Configure Firestore settings
      await _configureFirestore();
      
      // Configure Functions region if needed
      if (!AppConfig.isDebug) {
        _functions.useFunctionsEmulator('localhost', 5001);
      }

      // Enable analytics
      await _analytics.setAnalyticsCollectionEnabled(true);
      
    } catch (e) {
      throw DatabaseException('Failed to initialize Firebase: $e');
    }
  }

  Future<void> _configureFirestore() async {
    try {
      // Enable offline persistence
      await _firestore.enablePersistence(
        const PersistenceSettings(synchronizeTabs: true),
      );
      
      // Configure cache settings
      _firestore.settings = const Settings(
        persistenceEnabled: true,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
      );
    } catch (e) {
      // Persistence might already be enabled
      if (!e.toString().contains('already enabled')) {
        throw DatabaseException('Failed to configure Firestore: $e');
      }
    }
  }

  // Authentication helpers
  bool get isAuthenticated => _auth.currentUser != null;
  
  User? get currentUser => _auth.currentUser;
  
  String? get currentUserId => _auth.currentUser?.uid;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Firestore helpers
  CollectionReference<Map<String, dynamic>> collection(String path) {
    return _firestore.collection(path);
  }

  DocumentReference<Map<String, dynamic>> doc(String path) {
    return _firestore.doc(path);
  }

  // User-specific collections
  CollectionReference<Map<String, dynamic>> userCollection(String userId, String subcollection) {
    return _firestore.collection('users').doc(userId).collection(subcollection);
  }

  DocumentReference<Map<String, dynamic>> userDoc(String userId) {
    return _firestore.collection('users').doc(userId);
  }

  // Community collections
  CollectionReference<Map<String, dynamic>> get communityRecipes =>
      _firestore.collection('community').doc('sharedRecipes').collection('recipes');

  CollectionReference<Map<String, dynamic>> get cookingGroups =>
      _firestore.collection('community').doc('cookingGroups').collection('groups');

  CollectionReference<Map<String, dynamic>> get challenges =>
      _firestore.collection('community').doc('challenges').collection('active');

  // Storage helpers
  Reference storageRef(String path) {
    return _storage.ref(path);
  }

  Reference userStorageRef(String userId, String path) {
    return _storage.ref('users/$userId/$path');
  }

  // Batch operations
  WriteBatch batch() => _firestore.batch();

  Transaction runTransaction<T>(
    TransactionHandler<T> updateFunction, {
    Duration timeout = const Duration(seconds: 30),
  }) {
    return _firestore.runTransaction(updateFunction, timeout: timeout);
  }

  // Error handling
  AppException handleFirebaseException(dynamic error) {
    if (error is FirebaseAuthException) {
      return _handleAuthException(error);
    } else if (error is FirebaseException) {
      return _handleFirestoreException(error);
    } else {
      return UnknownException(error.toString());
    }
  }

  AuthenticationException _handleAuthException(FirebaseAuthException error) {
    switch (error.code) {
      case 'user-not-found':
      case 'wrong-password':
        return const InvalidCredentialsException();
      case 'email-already-in-use':
        return const AuthenticationException('Email already in use');
      case 'weak-password':
        return const AuthenticationException('Password is too weak');
      case 'invalid-email':
        return const AuthenticationException('Invalid email address');
      case 'user-disabled':
        return const AuthenticationException('Account has been disabled');
      case 'too-many-requests':
        return const AuthenticationException('Too many failed attempts');
      case 'operation-not-allowed':
        return const AuthenticationException('Operation not allowed');
      default:
        return AuthenticationException(error.message ?? 'Authentication failed');
    }
  }

  DatabaseException _handleFirestoreException(FirebaseException error) {
    switch (error.code) {
      case 'permission-denied':
        return const PermissionException('Access denied');
      case 'not-found':
        return const NotFoundException('Document not found');
      case 'already-exists':
        return const ConflictException('Document already exists');
      case 'resource-exhausted':
        return const DatabaseException('Quota exceeded');
      case 'failed-precondition':
        return const DatabaseException('Operation failed precondition');
      case 'aborted':
        return const DatabaseException('Operation was aborted');
      case 'out-of-range':
        return const DatabaseException('Value out of range');
      case 'unimplemented':
        return const DatabaseException('Operation not implemented');
      case 'internal':
        return const DatabaseException('Internal server error');
      case 'unavailable':
        return const DatabaseException('Service unavailable');
      case 'data-loss':
        return const DatabaseException('Data loss occurred');
      case 'unauthenticated':
        return const UnauthorizedException();
      default:
        return DatabaseException(error.message ?? 'Database error occurred');
    }
  }

  // Analytics helpers
  Future<void> logEvent(String name, [Map<String, Object?>? parameters]) async {
    try {
      await _analytics.logEvent(name: name, parameters: parameters);
    } catch (e) {
      // Analytics errors shouldn't break the app
      if (AppConfig.isDebug) {
        print('Analytics error: $e');
      }
    }
  }

  Future<void> setUserId(String userId) async {
    try {
      await _analytics.setUserId(id: userId);
    } catch (e) {
      if (AppConfig.isDebug) {
        print('Analytics setUserId error: $e');
      }
    }
  }

  Future<void> setUserProperty(String name, String value) async {
    try {
      await _analytics.setUserProperty(name: name, value: value);
    } catch (e) {
      if (AppConfig.isDebug) {
        print('Analytics setUserProperty error: $e');
      }
    }
  }

  // Cloud Functions helpers
  HttpsCallable httpsCallable(String name) {
    return _functions.httpsCallable(name);
  }

  Future<T> callFunction<T>(String name, [dynamic parameters]) async {
    try {
      final callable = httpsCallable(name);
      final result = await callable.call(parameters);
      return result.data as T;
    } catch (e) {
      throw ServerException('Cloud function error: $e');
    }
  }

  // Cleanup
  Future<void> dispose() async {
    // Firebase services don't need explicit disposal
    // They're managed by the Firebase SDK
  }
}