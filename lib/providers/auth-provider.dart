import 'package:bumblebee/repositories/auth-repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(FirebaseAuth.instance);
});

final authStateProvider = StreamProvider((ref) {
  return ref.read(authRepositoryProvider).authStateChange;
});
