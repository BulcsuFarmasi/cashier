import 'package:cashier/features/sale/data/currency.dart';
import 'package:cashier/features/sale/data/currency_payment_method_tuple.dart';
import 'package:cashier/features/sale/data/payment_method.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<CurrencyPaymentMethodService> currencyPaymentMethodProvider =
    Provider<CurrencyPaymentMethodService>((_) => CurrencyPaymentMethodService());

class CurrencyPaymentMethodService {
  List<CurrencyPaymentMethodTuple>? _currencyPaymentMethods;

  List<CurrencyPaymentMethodTuple> get currencyPaymentMethods {
    if (_currencyPaymentMethods == null) {
      _currencyPaymentMethods = [];
      for (Currency currency in Currency.values) {
        for (PaymentMethod paymentMethod in PaymentMethod.values) {
          _currencyPaymentMethods!.add(CurrencyPaymentMethodTuple(currency, paymentMethod));
        }
      }
    }
    return _currencyPaymentMethods!;
  }
}
