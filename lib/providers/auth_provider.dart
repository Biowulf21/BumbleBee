import 'package:bumblebee/feature/authentication/domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebaseAuthInstance = FirebaseAuth.instance;

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(_firebaseAuthInstance);
});

final authStateProvider = StreamProvider((ref) {
  return ref.read(authRepositoryProvider).authStateChange;
});
