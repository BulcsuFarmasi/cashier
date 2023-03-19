import 'package:cashier/features/sale/data/sales_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllSalesTable extends ConsumerStatefulWidget {
  const AllSalesTable(this.salesReport, {super.key});

  final SalesReport salesReport;

  @override
  ConsumerState<AllSalesTable> createState() => _AllSalesTableState();
}

class _AllSalesTableState extends ConsumerState<AllSalesTable> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
