import 'package:cashier/features/auth/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<AuthRepository> authRepositoryProvider = Provider<AuthRepository>((Ref ref) => AuthRepository(ref.read(authServiceProvider)));

class AuthRepository {
  AuthRepository(this._authService);
  final AuthService _authService;

}