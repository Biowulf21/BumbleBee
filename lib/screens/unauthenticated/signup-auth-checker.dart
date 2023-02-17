import 'package:bumblebee/screens/unauthenticated/sign-up.dart';
import 'package:bumblebee/screens/unauthenticated/splash-screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../providers/auth-provider.dart';
import '../authenticated/landlord/landlord-home.dart';

class SignUpAuthChecker extends ConsumerWidget {
  const SignUpAuthChecker({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user != null) return const LandlordHomeWidget();
        return const SignUpPage();
      },
      loading: () => const SplashScreen(),
      error: (e, trace) =>
          ScaffoldMessenger(child: SnackBar(content: Text(e.toString()))),
    );
  }
}
