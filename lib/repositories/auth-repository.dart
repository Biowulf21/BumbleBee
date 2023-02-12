import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  const AuthRepository(this._auth);

  final FirebaseAuth _auth;

  Future<User?> loginWithEmailandPassword(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    return result.user;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<User?> getCurrentUser() async {
    final currentUser = _auth.currentUser;
    return currentUser;
  }
}
