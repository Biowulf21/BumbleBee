import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth authInstance = FirebaseAuth.instance;

final currentUserFutureProvider = FutureProvider.autoDispose((ref) => {});
