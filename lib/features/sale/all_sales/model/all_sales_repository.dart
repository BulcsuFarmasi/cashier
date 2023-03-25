import 'package:cashier/features/sale/data/currency_payment_method_tuple.dart';
import 'package:cashier/features/sale/data/sale.dart';
import 'package:cashier/features/sale/data/sales_report.dart';
import 'package:cashier/features/sale/data/sales_summary.dart';
import 'package:cashier/features/sale/service/currency_payment_method_service.dart';
import 'package:cashier/features/sale/service/sale_service.dart';
import 'package:riverpod/riverpod.dart';

final Provider<AllSalesRepository> allSaleRepositoryProvider = Provider<AllSalesRepository>(
  (Ref ref) => AllSalesRepository(
    ref.read(saleServiceProvider),
    ref.read(currencyPaymentMethodProvider),
  ),
);

class AllSalesRepository {
  AllSalesRepository(this._saleService, this._currencyPaymentMethodService);

  final SaleService _saleService;
  final CurrencyPaymentMethodService _currencyPaymentMethodService;

  Stream<SalesReport> loadSales() {
    return _saleService.loadSales().map(_convertSalesToSalesReport);
  }

  void deleteSales(List<String> saleIds) {
    _saleService.deleteSales(saleIds);
  }

  SalesReport _convertSalesToSalesReport(List<Sale> sales) {
    sales.sort((Sale aSale, Sale bSale) => aSale.date!.compareTo(bSale.date!));

    final List<CurrencyPaymentMethodTuple> currencyPaymentMethods = _currencyPaymentMethodService.currencyPaymentMethod;

    final SalesSummary salesSummary = _calculateSalesSummary(sales);

    final SalesReport salesReport = SalesReport(sales, salesSummary, currencyPaymentMethods);
    return salesReport;
  }

  SalesSummary _calculateSalesSummary(List<Sale> sales) {
    final Map<CurrencyPaymentMethodTuple, double> sums = {
      for (CurrencyPaymentMethodTuple currencyPaymentMethod in _currencyPaymentMethodService.currencyPaymentMethod)
        currencyPaymentMethod: 0
    };
    final Map<CurrencyPaymentMethodTuple, double> discounts = {
      for (CurrencyPaymentMethodTuple currencyPaymentMethod in _currencyPaymentMethodService.currencyPaymentMethod)
        currencyPaymentMethod: 0
    };
    final Map<CurrencyPaymentMethodTuple, int> amounts = {
      for (CurrencyPaymentMethodTuple currencyPaymentMethod in _currencyPaymentMethodService.currencyPaymentMethod)
        currencyPaymentMethod: 0
    };

    for (Sale sale in sales) {
      sums[CurrencyPaymentMethodTuple(sale.currency!, sale.paymentMethod!)] =
          sums[CurrencyPaymentMethodTuple(sale.currency!, sale.paymentMethod!)]! + sale.sums![sale.currency]!;
      discounts[CurrencyPaymentMethodTuple(sale.currency!, sale.paymentMethod!)] =
          discounts[CurrencyPaymentMethodTuple(sale.currency!, sale.paymentMethod!)]! + sale.discounts![sale.currency]!;
      amounts[CurrencyPaymentMethodTuple(sale.currency!, sale.paymentMethod!)] =
          amounts[CurrencyPaymentMethodTuple(sale.currency!, sale.paymentMethod!)]! + 1;
    }

    return SalesSummary(sums: sums, discounts: discounts, amounts: amounts);
  }
}
