import 'package:exhibition_register/features/sale/data/currency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_selector_page_state.freezed.dart';

@freezed
class CurrencySelectorPageState  with _$CurrencySelectorPageState {
  const factory CurrencySelectorPageState.initial() = _Initial;
  const factory CurrencySelectorPageState.successful(List<Currency> currencies) = _Successful;
}