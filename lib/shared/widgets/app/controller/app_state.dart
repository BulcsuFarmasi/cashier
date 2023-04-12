import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState.signedIn() = _SignedIn;

  const factory AppState.signedOut() = _SignedOut;
}
