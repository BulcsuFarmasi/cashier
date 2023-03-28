import 'package:cashier/features/sale/data/currency.dart';
import 'package:cashier/features/sale/data/currency_payment_method_tuple.dart';
import 'package:cashier/features/sale/data/product.dart';
import 'package:cashier/features/sale/data/product_summary.dart';
import 'package:cashier/features/sale/data/sale.dart';
import 'package:cashier/features/sale/data/sale_item.dart';
import 'package:cashier/features/sale/data/sales_report.dart';
import 'package:cashier/features/sale/data/sales_summary.dart';
import 'package:cashier/features/sale/service/currency_payment_method_service.dart';
import 'package:cashier/features/sale/service/product_service.dart';
import 'package:cashier/features/sale/service/sale_service.dart';
import 'package:riverpod/riverpod.dart';

final Provider<AllSalesRepository> allSaleRepositoryProvider = Provider<AllSalesRepository>(
  (Ref ref) => AllSalesRepository(
    ref.read(saleServiceProvider),
    ref.read(productServiceProvider),
    ref.read(currencyPaymentMethodProvider),
  ),
);

class AllSalesRepository {
  AllSalesRepository(this._saleService, this._productService, this._currencyPaymentMethodService);

  final SaleService _saleService;
  final ProductService _productService;
  final CurrencyPaymentMethodService _currencyPaymentMethodService;

  Stream<SalesReport> loadSales() async* {
    await for (List<Sale> sales in _saleService.loadSales()) {
      yield await _convertSalesToSalesReport(sales);
    }
  }

  void deleteSales(List<String> saleIds) {
    _saleService.deleteSales(saleIds);
  }

  Future<SalesReport> _convertSalesToSalesReport(List<Sale> sales) async {
    sales.sort((Sale aSale, Sale bSale) => aSale.date!.compareTo(bSale.date!));

    final List<CurrencyPaymentMethodTuple> currencyPaymentMethods =
        _currencyPaymentMethodService.currencyPaymentMethods;

    sales = _createSaleItemByProductId(sales);

    final List<Product> products = await _productService.loadProducts();
    final SalesSummary salesSummary = _calculateSalesSummary(sales, products);

    final SalesReport salesReport = SalesReport(sales, products, salesSummary, currencyPaymentMethods);
    return salesReport;
  }

  SalesSummary _calculateSalesSummary(List<Sale> sales, List<Product> products) {
    final Map<CurrencyPaymentMethodTuple, double> sums = {
      for (CurrencyPaymentMethodTuple currencyPaymentMethod in _currencyPaymentMethodService.currencyPaymentMethods)
        currencyPaymentMethod: 0
    };
    final Map<CurrencyPaymentMethodTuple, double> discounts = {
      for (CurrencyPaymentMethodTuple currencyPaymentMethod in _currencyPaymentMethodService.currencyPaymentMethods)
        currencyPaymentMethod: 0
    };
    final Map<CurrencyPaymentMethodTuple, int> amounts = {
      for (CurrencyPaymentMethodTuple currencyPaymentMethod in _currencyPaymentMethodService.currencyPaymentMethods)
        currencyPaymentMethod: 0
    };
    final Map<Currency, double> prices = {for (Currency currency in Currency.values) currency: 0};
    Map<String, ProductSummary> productSummaries = {
      for (Product product in products) product.id!: ProductSummary(prices: prices, amount: 0)
    };

    for (Sale sale in sales) {
      final sum = sums[CurrencyPaymentMethodTuple(sale.currency!, sale.paymentMethod!)];
      sums[CurrencyPaymentMethodTuple(sale.currency!, sale.paymentMethod!)] = sum! + sale.sums![sale.currency]!;

      if (sale.discounts != null) {
        final discount = discounts[CurrencyPaymentMethodTuple(sale.currency!, sale.paymentMethod!)];
        discounts[CurrencyPaymentMethodTuple(sale.currency!, sale.paymentMethod!)] =
            discount! + sale.discounts![sale.currency]!;
      }

      final amount = amounts[CurrencyPaymentMethodTuple(sale.currency!, sale.paymentMethod!)];
      amounts[CurrencyPaymentMethodTuple(sale.currency!, sale.paymentMethod!)] = (amount ?? 0) + 1;

      for (SaleItem saleItem in sale.items!) {
          final ProductSummary? productSummary = productSummaries[saleItem.product.id!];
          final int amount = productSummary!.amount + saleItem.amount;
          final Map<Currency, double> prices = {...productSummary.prices};
          final double price = productSummary.prices[sale.currency]! + saleItem.prices[sale.currency]!;
          prices[sale.currency!] = price;
          productSummaries[saleItem.product.id!] = productSummary.copyWith(amount: amount, prices: prices);
      }

    }
      return SalesSummary(productSummaries: productSummaries, sums: sums, discounts: discounts, amounts: amounts);
  }

  List<Sale> _createSaleItemByProductId(List<Sale> sales) => sales
      .map((Sale sale) => sale.copyWith(itemsByProductId: {for (SaleItem item in sale.items!) item.product.id!: item}))
      .toList();
}
