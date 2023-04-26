import 'package:cashier/features/sale/data/product.dart';
import 'package:cashier/shared/providers/firestore_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<ProductRemote> productRemoteProvider =
    Provider<ProductRemote>((Ref ref) => ProductRemote(ref.read(firestoreProvider)));

class ProductRemote {
  ProductRemote(this._firebaseFirestore) {
    _collection = _firebaseFirestore.collection(collectionName);
  }

  final FirebaseFirestore _firebaseFirestore;
  late CollectionReference<Map<String, dynamic>> _collection;
  static const collectionName = "products";

  Future<List<Product>> loadSales() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _collection.orderBy('order').get();
    return querySnapshot.docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) => Product.fromJson(doc.data()).copyWith(id: doc.id))
        .toList();
  }
}
