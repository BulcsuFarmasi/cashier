import 'package:cash/features/sale/data/currency.dart';
import 'package:cash/features/sale/data/payment_method.dart';
import 'package:cash/features/sale/data/product.dart';
import 'package:cash/features/sale/data/sale.dart';
import 'package:cash/features/sale/data/sale_item.dart';
import 'package:cash/features/sale/service/product_service.dart';
import 'package:cash/features/sale/service/sale_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<SaleRepository> saleRepositoryProvider = Provider<SaleRepository>(
  (Ref ref) => SaleRepository(ref.read(productServiceProvider), ref.read(saleServiceProvider)),
);

class SaleRepository {
  SaleRepository(this._productService, this._saleService);

  final ProductService _productService;
  final SaleService _saleService;

  Sale createSale() {
    _saleService.createSale();
    final List<SaleItem> saleItems = _productService.products
        .map((Product product) =>
            SaleItem(product: product, amount: 0, prices: {for (Currency currency in Currency.values) currency: 0}))
        .toList();
    _saleService.updateSale(saleItems: saleItems, sums: {for (Currency currency in Currency.values) currency: 0});
    return _saleService.loadSale();
  }

  Sale updateSale({PaymentMethod? paymentMethod, SaleItem? saleItem}) {
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
    } else {
      _saleService.updateSale(paymentMethod: paymentMethod);
    }
    return _saleService.loadSale();
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

    return sums;
  }
}
