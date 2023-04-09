import 'package:cashier/features/auth/data/auth_exception.dart';
import 'package:cashier/features/auth/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<SignInRepository> signInRepositoryProvider =
    Provider<SignInRepository>((Ref ref) => SignInRepository(ref.read(authServiceProvider)));

class SignInRepository {
  SignInRepository(this._authService);

  final AuthService _authService;

  Future<void> signIn(String email, String password) async {
    try {
      await _authService.signIn(email, password);
    } on AuthException {
      print('e');
      rethrow;
    }
  }
}
