import 'package:cashier/features/sale/data/currency_payment_method_tuple.dart';
import 'package:cashier/features/sale/data/sale.dart';
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
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(
          children: [
            const Text('Kijelölés'),
            const Text('Vásárlás dátuma'),
            ...widget.salesReport.currencyPaymentMethods
                .map((CurrencyPaymentMethodTuple currencyPaymentMethod) => Text(
                'Végösszeg (${currencyPaymentMethod.currency.name}, ${currencyPaymentMethod.paymentMethod.name})'))
                .toList(),
            ...widget.salesReport.currencyPaymentMethods
                .map((CurrencyPaymentMethodTuple currencyPaymentMethod) => Text(
                'Vásárlás (${currencyPaymentMethod.currency.name}, ${currencyPaymentMethod.paymentMethod.name})'))
                .toList()
          ],
        ),
        ...widget.salesReport.sales
            .map(
              (Sale sale) => TableRow(
            children: [
              Checkbox(onChanged: (bool? checked) {}, value: false),
              Text('${sale.date}'),
              ...widget.salesReport.currencyPaymentMethods.map(
                    (CurrencyPaymentMethodTuple currencyPaymentMethodTuple) => Text(
                    currencyPaymentMethodTuple.currency == sale.currency &&
                        currencyPaymentMethodTuple.paymentMethod == sale.paymentMethod
                        ? '${sale.sums![sale.currency]}'
                        : ''),
              ),
              ...widget.salesReport.currencyPaymentMethods
                  .map((CurrencyPaymentMethodTuple currencyPaymentMethod) => Text(
                  sale.currency == currencyPaymentMethod.currency &&
                      sale.paymentMethod == currencyPaymentMethod.paymentMethod
                      ? '1'
                      : ''))
                  .toList()
            ],
          ),
        )
            .toList(),
        TableRow(
          children: [
            Container(),
            Container(),
            ...widget.salesReport.salesSummary.sums.values.map((double sum) => Text('$sum')).toList(),
            ...widget.salesReport.salesSummary.amounts.values.map((int amount) => Text('$amount')).toList(),
          ],
        ),
      ],
    );
  }
}