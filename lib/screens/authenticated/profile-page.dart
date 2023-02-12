import 'package:flutter/material.dart';
<<<<<<< HEAD

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('Profile'),
=======
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/auth-provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: TextButton(
        onPressed: () => ref.watch(authRepositoryProvider).logout(),
        child: const Text('Log out'),
      ),
>>>>>>> feature/home
    );
  }
}
