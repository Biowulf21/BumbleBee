import 'package:bumblebee/core/exceptions/failure.dart';
import 'package:bumblebee/feature/authentication/data/models/user.dart';
import 'package:bumblebee/screens/login-state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:bumblebee/repositories/auth-repository.dart';

class LoginStateController extends StateNotifier<LoginState> {
  LoginStateController(this._ref, this._firebaseAuth, this._firestore)
      : super(const LoginStateInitial());

  final Ref _ref;
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  void signUp({required User userObject, required String password}) async {
    state = const LoginStateInitial();
    try {
      state = const LoginStateLoading();
      final currentUser = await AuthRepository(_firebaseAuth)
          .createAccountWithEmailAndPassword(userObject.email, password);

      // await UserRepository(firestoreInstance: _firestore).createUserFromObject(
      //     userID: currentUser!.uid, userObject: userObject);

      state = const LoginStateSuccess();
    } on FirebaseException catch (e) {
      state = LoginStateFailure(e.message!);
    } on Failure catch (e) {
      state = LoginStateFailure(e.message);
    } on AuthException catch (e) {
      state = LoginStateFailure(e.errormessage);
    }
  }

  void loginWithEmailAndPass(String email, String password) async {
    state = const LoginStateInitial();
    try {
      state = const LoginStateLoading();

      final loggedIn = await AuthRepository(_firebaseAuth)
          .loginWithEmailandPassword(email, password);
      state = const LoginStateSuccess();
    } on FirebaseException catch (e) {
      state = LoginStateFailure(e.message!);
    } on Failure catch (e) {
      state = LoginStateFailure(e.message);
    } on AuthException catch (e) {
      state = LoginStateFailure(e.errormessage);
    }
  }
}

final loginControllerProvider =
    StateNotifierProvider<LoginStateController, LoginState>((ref) {
  return LoginStateController(
      ref, FirebaseAuth.instance, FirebaseFirestore.instance);
});
