import 'package:cashier/features/sale/data/currency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_summary.freezed.dart';

@freezed
class ProductSummary with _$ProductSummary {
  const factory ProductSummary({
    required Map<Currency, double> prices,
    required int amount,
  }) = _ProductSummary;
}
