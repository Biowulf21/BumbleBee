import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginStateController extends StateNotifier {
  LoginStateController(this.ref) : super(const LoginStateInitial());
}
