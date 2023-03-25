import 'package:cashier/features/sale/data/currency.dart';
import 'package:cashier/features/sale/data/payment_method.dart';
import 'package:cashier/features/sale/data/sale.dart';
import 'package:cashier/features/sale/data/sale_item.dart';
import 'package:cashier/features/sale/service/sale_remote.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<SaleService> saleServiceProvider = Provider((Ref ref) => SaleService(ref.read(saleRemote)));

class SaleService {
  SaleService(this._saleRemote);

  final SaleRemote _saleRemote;
  late Sale _sale;

  void createSale() {
    _sale = const Sale();
  }

  Sale loadSale() {
    return _sale;
  }

  Stream<List<Sale>> loadSales() {
    return _saleRemote.loadSales();
  }

  void updateSale(
      {List<SaleItem>? saleItems,
      PaymentMethod? paymentMethod,
      Map<Currency, double>? sums,
      Currency? currency,
      bool? preOrder}) {
    _sale = _sale.copyWith(
      items: saleItems ?? _sale.items,
      paymentMethod: paymentMethod ?? _sale.paymentMethod,
      sums: sums ?? _sale.sums,
      currency: currency ?? _sale.currency,
      preOrder: preOrder ?? _sale.preOrder,
    );
  }

  void saveSale() {
    DateTime currentDate = DateTime.now();
    _sale = _sale.copyWith(date: currentDate);
    _saleRemote.saveSale(_sale);
  }

  void deleteSales(List<String> saleIds) {
    _saleRemote.deleteSales(saleIds);
  }
}
