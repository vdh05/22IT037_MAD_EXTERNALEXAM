import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/app_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Sign in with email and password
  Future<User?> signIn(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      print('Sign in error: $e');
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  // Get user with role
  Future<AppUser?> getUserWithRole(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return AppUser.fromMap(doc.data() as Map<String, dynamic>, uid);
      }
      return null;
    } catch (e) {
      print('Get user error: $e');
      return null;
    }
  }

  // Check if user has admin permissions
  Future<bool> isAdmin() async {
    User? user = currentUser;
    if (user == null) return false;
    
    AppUser? appUser = await getUserWithRole(user.uid);
    return appUser?.role == UserRole.admin;
  }
  
  // Register new user
  Future<User?> register(String email, String password, String name, UserRole role) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (credential.user != null) {
        // Create user document in Firestore
        await _firestore.collection('users').doc(credential.user!.uid).set({
          'email': email,
          'name': name,
          'role': role == UserRole.admin ? 'admin' : 'operator',
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      
      return credential.user;
    } catch (e) {
      print('Register error: $e');
      return null;
    }
  }
}
