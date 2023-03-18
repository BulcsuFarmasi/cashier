import 'package:cashier/features/sale/data/currency.dart';
import 'package:cashier/features/sale/data/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<ProductService> productServiceProvider = Provider((_) => ProductService());

class ProductService {
  final List<Product> _products = const [
    Product(
      'EuntBxNBQb',
      'Poló',
      {
        Currency.huf: 11000,
        Currency.eur: 28,
      },
    ),
    Product(
      'ihUkvznbWu',
      'Pulóver',
      {
        Currency.huf: 20000,
        Currency.eur: 50,
      },
    ),
    Product(
      'FtfZoEtpry',
      'Sapka',
      {
        Currency.huf: 1800,
        Currency.eur: 12,
      },
    ),
  ];

  List<Product> get products => _products;
}
