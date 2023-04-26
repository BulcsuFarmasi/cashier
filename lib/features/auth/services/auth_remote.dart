import 'package:cashier/shared/providers/firebase_auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<AuthRemote> authRemoteProvider =
    Provider<AuthRemote>((Ref ref) => AuthRemote(ref.read(firebaseAuthProvider)));

class AuthRemote {
  final FirebaseAuth _firebaseAuth;

  AuthRemote(this._firebaseAuth);

  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  bool get signedIn => _firebaseAuth.currentUser != null;
}
