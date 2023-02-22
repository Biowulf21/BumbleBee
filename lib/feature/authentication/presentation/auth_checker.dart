import 'package:bumblebee/feature/authentication/presentation/splash_screen.dart';
import 'package:bumblebee/providers/auth_provider.dart';
import 'package:bumblebee/screens/authenticated/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'login_screen.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user != null) return const HomePage();
        return const LoginPage();
      },
      loading: () => const SplashScreen(),
      error: (e, trace) => const LoginPage(),
    );
  }
}
