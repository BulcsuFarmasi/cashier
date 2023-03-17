import 'package:cash/features/sale/data/currency.dart';
import 'package:cash/features/sale/data/payment_method.dart';
import 'package:cash/features/sale/data/sale.dart';
import 'package:cash/features/sale/data/sale_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<SaleService> saleServiceProvider = Provider((Ref ref) => SaleService());

class SaleService {
  late Sale _sale;


  void createSale() {
    _sale = Sale();
  }

  Sale loadSale() {
    return _sale;
  }

  void updateSale({List<SaleItem>? saleItems, PaymentMethod? paymentMethod, double? sum}) {
    _sale = _sale.copyWith(items: saleItems ?? _sale.items, paymentMethod: paymentMethod ?? _sale.paymentMethod);
    print(_sale);
  }
}