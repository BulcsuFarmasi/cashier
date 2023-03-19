import 'package:cashier/features/sale/data/sale.dart';
import 'package:cashier/shared/firebase_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<SaleRemote> saleRemote = Provider<SaleRemote>((Ref ref) => SaleRemote(ref.read(firebaseProvider)));

class SaleRemote {
  SaleRemote(this._firebaseFirestore) {
    _collection = _firebaseFirestore.collection(collectionName);
  }

  final FirebaseFirestore _firebaseFirestore;
  late CollectionReference<Map<String, dynamic>> _collection;
  static const collectionName = "sales";

  void saveSale(Sale sale) {
    print(sale.toJson());
    _collection.add(sale.toJson());
  }

  Stream<List<Sale>> loadSales() {
    return _collection.snapshots().map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      return snapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        final Sale sale = Sale.fromJson(doc.data());
        return sale.copyWith(id: doc.id);
      }).toList();
    });
  }
}
