import 'package:cashier/features/sale/data/currency.dart';
import 'package:cashier/features/sale/data/payment_method.dart';
import 'package:cashier/features/sale/data/product.dart';
import 'package:cashier/features/sale/data/sale.dart';
import 'package:cashier/features/sale/data/sale_item.dart';
import 'package:cashier/features/sale/service/product_service.dart';
import 'package:cashier/features/sale/service/sale_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<SaleRepository> saleRepositoryProvider = Provider<SaleRepository>(
  (Ref ref) => SaleRepository(ref.read(productServiceProvider), ref.read(saleServiceProvider)),
);

class SaleRepository {
  SaleRepository(this._productService, this._saleService);

  final ProductService _productService;
  final SaleService _saleService;

  Future<Sale> createSale() async {
    _saleService.createSale();
    final List<SaleItem> saleItems = (await _productService.loadProducts()).map((Product product) {
      product = product.copyWith(
        prices: Map.fromEntries(
          product.prices.entries.toList()
            ..sort(
              (e1, e2) => e1.key.index.compareTo(e2.key.index),
            ),
        ),
      );
      SaleItem saleItem =
          SaleItem(product: product, amount: 0, prices: {for (Currency currency in Currency.values) currency: 0});
      return saleItem;
    }).toList();
    _saleService.updateSale(saleItems: saleItems, sums: {for (Currency currency in Currency.values) currency: 0});
    return _saleService.loadSale();
  }

  Sale updateSale({
    PaymentMethod? paymentMethod,
    SaleItem? saleItem,
    Currency? currency,
    String? comment,
    Map<Currency, double>? discounts,
  }) {
    if (saleItem != null) {
      Sale sale = _saleService.loadSale();
      final int saleItemIndex = sale.items!.indexWhere((SaleItem item) => saleItem!.product.id == item.product.id);
      final Map<Currency, double> prices = _calculateItemPrice(saleItem);
      saleItem = saleItem.copyWith(prices: prices);
      final List<SaleItem> saleItems = [
        ...sale.items!.sublist(0, saleItemIndex),
        saleItem,
        ...sale.items!.sublist(saleItemIndex + 1)
      ];
      _saleService.updateSale(saleItems: saleItems);
      sale = _saleService.loadSale();
      final Map<Currency, double> sums = _calculateSums(sale);
      _saleService.updateSale(sums: sums);
    } else if (discounts != null) {
      _saleService.updateSale(discounts: discounts);
      Sale sale = _saleService.loadSale();
      final Map<Currency, double> sums = _calculateSums(sale);
      _saleService.updateSale(sums: sums);
    } else {
      _saleService.updateSale(
        paymentMethod: paymentMethod,
        currency: currency,
        comment: comment,
      );
    }
    return _saleService.loadSale();
  }

  void saveSale() {
    _saleService.saveSale();
  }

  Map<Currency, double> _calculateItemPrice(SaleItem saleItem) {
    return saleItem.product.prices.map((Currency currency, double sum) => MapEntry(currency, sum * saleItem.amount));
  }

  Map<Currency, double> _calculateSums(Sale sale) {
    final Map<Currency, double> sums = {for (Currency currency in Currency.values) currency: 0};

    for (SaleItem saleItem in sale.items!) {
      for (MapEntry<Currency, double> price in saleItem.prices.entries) {
        sums[price.key] = sums[price.key] != null ? sums[price.key]! + price.value : price.value;
      }
    }

    sale.discounts?.forEach((Currency currency, double amount) {
      sums[currency] = sums[currency]! + sale.discounts![currency]!;
    });

    return sums;
  }
}
