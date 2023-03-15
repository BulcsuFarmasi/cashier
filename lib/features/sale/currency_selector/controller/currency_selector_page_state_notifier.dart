import 'package:exhibition_register/features/sale/currency_selector/controller/currency_selector_page_state.dart';
import 'package:exhibition_register/features/sale/currency_selector/model/currency_selector_repository.dart';
import 'package:exhibition_register/features/sale/data/currency.dart';
import 'package:riverpod/riverpod.dart';

final StateNotifierProvider<CurrencySelectorPageStateNotifier, CurrencySelectorPageState>
    currencySelectorPageStateNotifierProvider =
    StateNotifierProvider<CurrencySelectorPageStateNotifier, CurrencySelectorPageState>(
        (ref) => CurrencySelectorPageStateNotifier(ref.read(currencySelectorRepositoryProvider)));

class CurrencySelectorPageStateNotifier extends StateNotifier<CurrencySelectorPageState> {
  CurrencySelectorPageStateNotifier(this._currencySelectorRepository)
      : super(const CurrencySelectorPageState.initial());

  final CurrencySelectorRepository _currencySelectorRepository;

  void loadCurrencies() {
    final List<Currency> currencies = _currencySelectorRepository.loadCurrencies();

    state = CurrencySelectorPageState.successful(currencies);
  }
}
