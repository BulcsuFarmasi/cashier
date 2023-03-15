import 'package:riverpod/riverpod.dart';
import 'package:exhibition_register/features/sale/data/currency.dart';

final Provider<CurrencyService> currencyServiceProvider = Provider<CurrencyService>((_) => CurrencyService());

class CurrencyService {
  final List<Currency> _currencies = [
    Currency("Forint", "HUF"),
    Currency("Euró", "EUR"),
  ];

  List<Currency> get currencies => _currencies;
}