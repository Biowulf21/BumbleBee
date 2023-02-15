import 'package:bumblebee/errors/failure.dart';
import 'package:bumblebee/models/user.dart';
import 'package:bumblebee/screens/login-state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:bumblebee/repositories/auth-repository.dart';
import 'package:bumblebee/repositories/user-repository.dart';

class LoginStateController extends StateNotifier<LoginState> {
  LoginStateController(this._ref, this._firebaseAuth, this._firestore)
      : super(const LoginStateInitial());

  final Ref _ref;
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  void signUp(
      {required GlobalKey<FormState> key,
      required User userObject,
      required String password}) async {
    state = const LoginStateInitial();
    try {
      state = const LoginStateLoading();
      final currentUser = await AuthRepository(_firebaseAuth)
          .createAccountWithEmailAndPassword(userObject.email, password);

      if (key.currentState!.validate()) {
        await UserRepository(firestoreInstance: _firestore)
            .createUserFromObject(
                userID: currentUser!.uid, userObject: userObject);

        state = const LoginStateSuccess();
      }
    } on FirebaseException catch (e) {
      state = LoginStateFailure(e.message!);
    } on Failure catch (e) {
      state = LoginStateFailure(e.message);
    }
  }
}

final loginControllerProvider =
    StateNotifierProvider<LoginStateController, LoginState>((ref) {
  return LoginStateController(
      ref, FirebaseAuth.instance, FirebaseFirestore.instance);
});
