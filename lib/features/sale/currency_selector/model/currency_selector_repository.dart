import 'package:exhibition_register/features/sale/data/currency.dart';
import 'package:exhibition_register/features/sale/service/currency_service.dart';
import 'package:exhibition_register/features/sale/service/sale_service.dart';
import 'package:riverpod/riverpod.dart';

final Provider<CurrencySelectorRepository> currencySelectorRepositoryProvider = Provider<CurrencySelectorRepository>((Ref ref) => CurrencySelectorRepository(ref.read(currencyServiceProvider), ref.read(saleServiceProvider)));

class CurrencySelectorRepository {
  final CurrencyService _currencyService;
  final SaleService _saleService;


  CurrencySelectorRepository(this._currencyService, this._saleService);

  List<Currency> loadCurrencies() {
    return _currencyService.currencies;
  }

  void createSale(Currency currency) {
    _saleService.createSale(currency);
  }
}