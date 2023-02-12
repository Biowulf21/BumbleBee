import 'package:bumblebee/providers/auth-provider.dart';
import 'package:bumblebee/screens/authenticated/home.dart';
import 'package:bumblebee/screens/unauthenticated/login-screen.dart';
import 'package:bumblebee/screens/unauthenticated/splash-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user != null) return const HomeWidget();
      },
      loading: () => const SplashScreen(),
      error: (e, trace) => const Loginpage(),
    );
  }
}
