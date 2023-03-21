import 'package:cashier/features/sale/data/currency.dart';
import 'package:cashier/features/sale/data/product.dart';
import 'package:cashier/features/sale/service/product_remote.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<ProductService> productServiceProvider = Provider((Ref ref) => ProductService(ref.read(productRemoteProvider)));

class ProductService {
  ProductService(this._productRemote);

  final ProductRemote _productRemote;


  Future<List<Product>> loadProducts() async {
    return _productRemote.loadSales();
  }
}

