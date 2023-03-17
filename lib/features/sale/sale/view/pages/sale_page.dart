import 'package:cash/features/sale/sale/view/widgets/products_sale_load_successful.dart';
import 'package:cash/features/sale/sale/controller/sale_page_state.dart';
import 'package:cash/features/sale/sale/controller/sale_page_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SalePage extends ConsumerStatefulWidget {
  const SalePage({super.key});

  static const routeName = '/sale';

  @override
  ConsumerState<SalePage> createState() => _SalePageState();
}

class _SalePageState extends ConsumerState<SalePage> {
  @override
  void initState() {
    super.initState();
    Future(() {
      ref.read(salePageStateNotifierProvider.notifier).createSale();
    });
  }

  @override
  Widget build(BuildContext context) {
    final SalePageState state = ref.watch(salePageStateNotifierProvider);
    return Scaffold(
      body: state.map(
        initial: (_) => Container(),
        saleLoadSuccessful: (saleLoadSuccessful) => ProductsSaleLoadSuccessful(sale: saleLoadSuccessful.sale),
      ),
    );
  }
}
