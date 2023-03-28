import 'package:cashier/features/sale/data/currency.dart';
import 'package:cashier/features/sale/data/payment_method.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_payment_method_tuple.freezed.dart';

@freezed
class CurrencyPaymentMethodTuple with _$CurrencyPaymentMethodTuple {
  const factory CurrencyPaymentMethodTuple(Currency currency, PaymentMethod paymentMethod) =
      _CurrencyPaymentMethodTuple;
}
