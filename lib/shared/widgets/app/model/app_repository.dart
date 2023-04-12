import 'package:cashier/features/auth/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<AppRepository> appRepositoryProvider = Provider<AppRepository>(
  (Ref ref) => AppRepository(
    ref.read(authServiceProvider),
  ),
);

class AppRepository {
  AppRepository(this._authService);

  final AuthService _authService;

  bool checkUser() => _authService.signedIn;
}
