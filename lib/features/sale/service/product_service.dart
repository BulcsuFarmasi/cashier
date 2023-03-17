import 'package:cash/features/sale/data/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<ProductService> productServiceProvider = Provider((_) => ProductService());

class ProductService {
  final List<Product> _products = const [
    Product(
      'EuntBxNBQb',
      'Poló',
      {
        'HUF': 11000,
        'EUR': 28,
      },
    ),
    Product(
      'ihUkvznbWu',
      'Pulóver',
      {
        'HUF': 20000,
        'EUR': 50,
      },
    ),
    Product(
      'FtfZoEtpry',
      'Sapka',
      {
        'HUF': 1800,
        'EUR': 12,
      },
    ),
  ];

  List<Product> get products => _products;
}
