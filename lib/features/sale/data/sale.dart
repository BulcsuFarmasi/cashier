import 'package:exhibition_register/features/sale/data/currency.dart';
import 'package:exhibition_register/features/sale/data/payment_method.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sale.freezed.dart';
part 'sale.g.dart';

@freezed
class Sale with _$Sale{
  const factory Sale({PaymentMethod? paymentMethod, DateTime? date, required Currency currency}) = _Sale;

  factory Sale.fromJson(Map<String, Object?> json) => _$SaleFromJson(json);
}