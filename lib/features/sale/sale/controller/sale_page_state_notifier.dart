import 'package:cashier/features/sale/data/currency.dart';
import 'package:cashier/features/sale/data/payment_method.dart';
import 'package:cashier/features/sale/data/sale.dart';
import 'package:cashier/features/sale/data/sale_item.dart';
import 'package:cashier/features/sale/sale/controller/sale_page_state.dart';
import 'package:cashier/features/sale/sale/model/sale_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateNotifierProvider<SalePageStateNotifier, SalePageState> salePageStateNotifierProvider =
    StateNotifierProvider<SalePageStateNotifier, SalePageState>(
  (Ref ref) => SalePageStateNotifier(
    ref.read(saleRepositoryProvider),
  ),
);

class SalePageStateNotifier extends StateNotifier<SalePageState> {
  SalePageStateNotifier(this._saleRepository) : super(const SalePageState.initial());

  final SaleRepository _saleRepository;

  void createSale() async {
    final Sale sale = await _saleRepository.createSale();
    state = SalePageState.saleLoadSuccessful(sale);
  }

  void updateSale({
    PaymentMethod? paymentMethod,
    SaleItem? saleItem,
    Currency? currency,
    String? comment,
    Map<Currency, double>? discounts,

  }) {
    final Sale sale = _saleRepository.updateSale(
      paymentMethod: paymentMethod,
      saleItem: saleItem,
      currency: currency,
      comment: comment,
      discounts: discounts
    );
    state = SalePageState.saleLoadSuccessful(sale);
  }

  void saveSale() async {
    _saleRepository.saveSale();
    final Sale sale = await _saleRepository.createSale();
    state = SalePageState.saleLoadSuccessful(sale);
  }
}
