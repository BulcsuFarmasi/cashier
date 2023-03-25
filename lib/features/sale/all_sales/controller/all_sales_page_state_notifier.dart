import 'package:cashier/features/sale/all_sales/controller/all_sales_page_state.dart';
import 'package:cashier/features/sale/all_sales/model/all_sales_repository.dart';
import 'package:cashier/features/sale/data/sales_report.dart';
import 'package:riverpod/riverpod.dart';

final StateNotifierProvider<AllSalesPageStateNotifier, AllSalesPageState> allSalesPageNotifierProvider =
    StateNotifierProvider<AllSalesPageStateNotifier, AllSalesPageState>(
  (Ref ref) => AllSalesPageStateNotifier(
    ref.read(allSaleRepositoryProvider),
  ),
);

class AllSalesPageStateNotifier extends StateNotifier<AllSalesPageState> {
  AllSalesPageStateNotifier(this._allSalesRepository) : super(const AllSalesPageState.initial());

  final AllSalesRepository _allSalesRepository;

  void loadSales() {
    state = const AllSalesPageState.inProgress();
    _allSalesRepository.loadSales().listen((SalesReport salesReport) {
      state = AllSalesPageState.successful(salesReport);
    });
  }

  void deleteSales(List<String> saleIds) {
    _allSalesRepository.deleteSales(saleIds);
  }
}
