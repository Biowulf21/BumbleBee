import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  const AuthRepository(this._auth);

  final FirebaseAuth _auth;

  Stream<User?> get authStateChange => _auth.idTokenChanges();

  Future<User?> loginWithEmailandPassword(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('User not found');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Wrong password');
      } else {
        throw AuthException('An exception occured. Please try again later.');
      }
    }
  }

  /* This function will get the current user's firebase document through getting the user's UID */

  // Future<User> getUserInformation(){
  //   return
  //
  // }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<User?> getCurrentUser() async {
    final currentUser = _auth.currentUser;
    return currentUser;
  }
}

class AuthException implements Exception {
  AuthException(this._errormessage);

  final String _errormessage;
}
