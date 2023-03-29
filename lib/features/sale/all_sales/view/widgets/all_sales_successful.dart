import 'package:cashier/features/sale/all_sales/view/widgets/all_sales_table.dart';
import 'package:cashier/features/sale/all_sales/view/widgets/export_sales.dart';
import 'package:cashier/features/sale/data/sales_report.dart';
import 'package:flutter/material.dart';

class AllSalesSuccessful extends StatelessWidget {
  const AllSalesSuccessful({super.key, required this.salesReport});

  final SalesReport salesReport;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AllSalesTable(salesReport: salesReport),
        ExportSales(
          salesReport: salesReport,
        ),
      ],
    );
  }
}
