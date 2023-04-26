import 'package:cashier/features/auth/data/auth_exception.dart';
import 'package:cashier/features/auth/sign_in/controller/sign_in_page_state.dart';
import 'package:cashier/features/auth/sign_in/model/sign_in_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateNotifierProvider<SignInPageStateNotifier, SignInPageState> signInPageStateNotifierProvider =
    StateNotifierProvider<SignInPageStateNotifier, SignInPageState>(
  (Ref ref) => SignInPageStateNotifier(
    ref.read(signInRepositoryProvider),
  ),
);

class SignInPageStateNotifier extends StateNotifier<SignInPageState> {
  SignInPageStateNotifier(this._signInRepository) : super(const SignInPageState.initial());

  final SignInRepository _signInRepository;

  void signIn(String email, String password) async {
    state = SignInPageState.inProgress(email, password);
    try {
      await _signInRepository.signIn(email, password);

      state = const SignInPageState.successful();
    } on AuthException {
      state = SignInPageState.error(email, password);
    }
  }
}
