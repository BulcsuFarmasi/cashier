import 'package:cashier/features/sale/data/currency.dart';
import 'package:cashier/features/sale/data/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sale_item.freezed.dart';
part 'sale_item.g.dart';

@freezed
class SaleItem with _$SaleItem {
  const factory SaleItem({required Product product, required int amount, required Map<Currency, double> prices}) =
      _SaleItem;

  factory SaleItem.fromJson(Map<String, Object?> json) => _$SaleItemFromJson(json);
}
