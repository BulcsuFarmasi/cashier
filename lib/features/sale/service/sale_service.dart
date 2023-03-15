import 'package:exhibition_register/features/sale/data/currency.dart';
import 'package:exhibition_register/features/sale/data/sale.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<SaleService> saleServiceProvider = Provider((Ref ref) => SaleService());

class SaleService {
  Sale? _sale;


  void createSale(Currency currency) {
    _sale = Sale(currency: currency);
  }
}