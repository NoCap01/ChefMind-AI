import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  factory FirebaseService() => _instance;
  FirebaseService._internal();

  FirebaseFirestore? _firestore;
  FirebaseAuth? _auth;
  FirebaseStorage? _storage;
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    await Firebase.initializeApp();
    _firestore = FirebaseFirestore.instance;
    _auth = FirebaseAuth.instance;
    _storage = FirebaseStorage.instance;
    _initialized = true;
  }

  FirebaseFirestore get firestore {
    if (!_initialized) throw Exception('FirebaseService not initialized');
    return _firestore!;
  }

  FirebaseAuth get auth {
    if (!_initialized) throw Exception('FirebaseService not initialized');
    return _auth!;
  }

  FirebaseStorage get storage {
    if (!_initialized) throw Exception('FirebaseService not initialized');
    return _storage!;
  }

  // Common Firestore operations
  Future<void> setDocument(String collection, String documentId, Map<String, dynamic> data) async {
    await firestore.collection(collection).doc(documentId).set(data);
  }

  Future<DocumentSnapshot> getDocument(String collection, String documentId) async {
    return await firestore.collection(collection).doc(documentId).get();
  }

  Future<QuerySnapshot> getCollection(String collection) async {
    return await firestore.collection(collection).get();
  }

  Stream<DocumentSnapshot> watchDocument(String collection, String documentId) {
    return firestore.collection(collection).doc(documentId).snapshots();
  }

  Stream<QuerySnapshot> watchCollection(String collection) {
    return firestore.collection(collection).snapshots();
  }
}