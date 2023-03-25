import 'package:cashier/features/sale/data/currency_payment_method_tuple.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sales_summary.freezed.dart';

@freezed
class SalesSummary with _$SalesSummary {
  const factory SalesSummary(
      {required Map<CurrencyPaymentMethodTuple, double> sums,
      required Map<CurrencyPaymentMethodTuple, int> amounts}) = _SalesSummary;
}
