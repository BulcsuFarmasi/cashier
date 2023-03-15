import 'package:exhibition_register/features/sale/data/currency.dart';
import 'package:exhibition_register/features/sale/service/currency_service.dart';
import 'package:riverpod/riverpod.dart';

final Provider<CurrencySelectorRepository> currencySelectorRepositoryProvider = Provider<CurrencySelectorRepository>((Ref ref) => CurrencySelectorRepository(ref.read(currencyServiceProvider)));

class CurrencySelectorRepository {
  final CurrencyService _currencyService;


  CurrencySelectorRepository(this._currencyService);

  List<Currency> loadCurrencies() {
    return _currencyService.currencies;
  }
}