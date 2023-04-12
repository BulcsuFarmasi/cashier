import 'package:cashier/shared/widgets/app/controller/app_state.dart';
import 'package:cashier/shared/widgets/app/model/app_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateNotifierProvider<AppStateNotifier, AppState> appStateNotifierProvider =
    StateNotifierProvider<AppStateNotifier, AppState>(
  (Ref ref) => AppStateNotifier(
    ref.read(appRepositoryProvider),
  ),
);

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier(this._appRepository) : super(const AppState.signedOut()) {
    checkUser();
  }

  final AppRepository _appRepository;

  void checkUser() {
    state = _appRepository.checkUser() ? const AppState.signedIn() : const AppState.signedOut();
  }
}
