import 'package:bumblebee/screens/splash_screen.dart';
import 'package:bumblebee/feature/authentication/presentation/authenticated/home.dart';
import 'package:bumblebee/feature/authentication/presentation/unauthenticated/sign_up.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../providers/auth_provider.dart';

class SignUpAuthChecker extends ConsumerWidget {
  const SignUpAuthChecker({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user != null) return const HomePage();
        return const SignUpPage();
      },
      loading: () => const SplashScreen(),
      error: (e, trace) =>
          ScaffoldMessenger(child: SnackBar(content: Text(e.toString()))),
    );
  }
}
