import 'package:cash/features/sale/data/currency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product{
  const factory Product(String id, String name, Map<Currency, double> prices) = _Product;

  factory Product.fromJson(Map<String, Object?> json) => _$ProductFromJson(json);
}