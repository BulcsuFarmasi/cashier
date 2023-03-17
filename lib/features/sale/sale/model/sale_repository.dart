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
    final List<SaleItem> saleItems = _productService.products.map((Product product) => SaleItem(product, 0)).toList();
    _saleService.updateSale(saleItems: saleItems);
    return _saleService.loadSale();
  }

  Sale updateSale({PaymentMethod? paymentMethod, SaleItem? saleItem}) {
    if (saleItem != null) {
      final Sale sale = _saleService.loadSale();
      final int saleItemIndex = sale.items!.indexWhere((SaleItem item) => saleItem.product.id == item.product.id);
      final List<SaleItem> saleItems = [
        ...sale.items!.sublist(0, saleItemIndex),
        saleItem,
        ...sale.items!.sublist(saleItemIndex + 1)
      ];
      final sum = _calculateSum(sale);
      print(sum);
      _saleService.updateSale(saleItems: saleItems, sum: sum);
    } else {
      _saleService.updateSale(paymentMethod: paymentMethod);
    }
    return _saleService.loadSale();
  }

  double _calculateSum(Sale sale) {
    double sum = 0;
    for (SaleItem saleItem in sale.items!) {
      sum += saleItem.amount * saleItem.product.prices[sale.currency!.code]!;
    }
    return sum;
  }
}
