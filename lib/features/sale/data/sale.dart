import 'package:cash/features/sale/data/currency.dart';
import 'package:cash/features/sale/data/payment_method.dart';
import 'package:cash/features/sale/data/sale_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sale.freezed.dart';
part 'sale.g.dart';

@freezed
class Sale with _$Sale{
  const factory Sale({PaymentMethod? paymentMethod, DateTime? date, Currency? currency, List<SaleItem>? items, double? sum}) = _Sale;

  factory Sale.fromJson(Map<String, Object?> json) => _$SaleFromJson(json);
}