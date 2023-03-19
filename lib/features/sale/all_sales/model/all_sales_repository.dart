import 'package:cashier/features/sale/data/currency.dart';
import 'package:cashier/features/sale/data/sale.dart';
import 'package:cashier/features/sale/data/sales_report.dart';
import 'package:cashier/features/sale/service/sale_service.dart';
import 'package:riverpod/riverpod.dart';

final Provider<AllSalesRepository> allSaleRepositoryProvider = Provider<AllSalesRepository>(
  (Ref ref) => AllSalesRepository(
    ref.read(saleServiceProvider),
  ),
);

class AllSalesRepository {
  AllSalesRepository(this._saleService);

  final SaleService _saleService;

  Stream<SalesReport> loadSales() {
    return _saleService.loadSales().map(_convertSalesToSalesReport);
  }
  
  SalesReport _convertSalesToSalesReport(List<Sale> sales) {
    final SalesReport salesReport = SalesReport(sales);
    return salesReport;
    
  }
}
