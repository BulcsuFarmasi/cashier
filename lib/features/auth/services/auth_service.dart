import 'package:cashier/features/auth/services/auth_remote.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<AuthService> authServiceProvider = Provider<AuthService>(
  (Ref ref) => AuthService(
    ref.read(authRemoteProvider),
  ),
);

class AuthService {
  final AuthRemote _authRemote;

  AuthService(this._authRemote);

  Future<void> signIn(String email, String password) async {
    try {
      await _authRemote.signIn(email, password);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  bool get signedIn => _authRemote.signedIn;
}
