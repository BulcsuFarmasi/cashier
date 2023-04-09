import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_page_state.freezed.dart';

@freezed
class SignInPageState with _$SignInPageState {
  const factory SignInPageState.initial() = _Initial;

  const factory SignInPageState.inProgress(String email, String password) = _InProgress;

  const factory SignInPageState.successful() = _Successful;

  const factory SignInPageState.error(String email, String password) = _Error;
}
