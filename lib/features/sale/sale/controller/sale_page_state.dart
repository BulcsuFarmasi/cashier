import 'package:cash/features/sale/data/sale.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sale_page_state.freezed.dart';

@freezed
class SalePageState with _$SalePageState {
  const factory SalePageState.initial() = _Initial;

  const factory SalePageState.saleLoadSuccessful(Sale sale) = _SaleLoadSuccessful;
}
