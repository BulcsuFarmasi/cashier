import 'package:cashier/features/sale/all_sales/controller/all_sales_page_state.dart';
import 'package:cashier/features/sale/all_sales/controller/all_sales_page_state_notifier.dart';
import 'package:cashier/features/sale/all_sales/view/widgets/all_sales_in_progress.dart';
import 'package:cashier/features/sale/all_sales/view/widgets/all_sales_successful.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllSalesPage extends ConsumerStatefulWidget {
  const AllSalesPage({super.key});

  static const routeName = '/all-sales';

  @override
  ConsumerState<AllSalesPage> createState() => _AllPageStateState();
}

class _AllPageStateState extends ConsumerState<AllSalesPage> {
  @override
  void initState() {
    super.initState();
    Future(() {
      ref.read(allSalesPageNotifierProvider.notifier).loadSales();
    });
  }

  @override
  Widget build(BuildContext context) {
    final AllSalesPageState state = ref.watch(allSalesPageNotifierProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: state.map(
          initial: (_) => Container(),
          inProgress: (_) => const AllSalesInProgress(),
          successful: (successful) => AllSalesSuccessful(salesReport: successful.salesReport),
        ),
      ),
    );
  }
}
