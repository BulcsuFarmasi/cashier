import 'package:riverpod/riverpod.dart';
import 'package:cash/features/sale/data/currency.dart';

final Provider<CurrencyService> currencyServiceProvider = Provider<CurrencyService>((_) => CurrencyService());

class CurrencyService {
  final List<Currency> _currencies = [
    const Currency("Forint", CurrencyCode.huf),
    const Currency("Euró",  CurrencyCode.eur),
  ];

  List<Currency> get currencies => _currencies;
}