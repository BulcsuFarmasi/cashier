import 'package:cash/features/sale/data/payment_method.dart';
import 'package:cash/features/sale/data/sale.dart';
import 'package:cash/features/sale/data/sale_item.dart';
import 'package:cash/features/sale/sale/controller/sale_page_state.dart';
import 'package:cash/features/sale/sale/model/sale_repository.dart';
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

  void createSale() {
    final Sale sale = _saleRepository.createSale();
    state = SalePageState.saleLoadSuccessful(sale);
  }

  void updateSale({PaymentMethod? paymentMethod, SaleItem? saleItem}) {
    final Sale sale = _saleRepository.updateSale(paymentMethod: paymentMethod, saleItem: saleItem);
    state = SalePageState.saleLoadSuccessful(sale);
  }
}
