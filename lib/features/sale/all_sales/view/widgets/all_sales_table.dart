import 'package:cashier/features/sale/all_sales/controller/all_sales_page_state_notifier.dart';
import 'package:cashier/features/sale/data/currency.dart';
import 'package:cashier/features/sale/data/currency_payment_method_tuple.dart';
import 'package:cashier/features/sale/data/product.dart';
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
  List<String> _markedSaleIds = [];
  bool _allSalesMarked = false;

  TableRow _buildTableHeader() {
    return TableRow(
      children: [
        Column(
          children: [
            const Text('Mindet kijelöl'),
            Checkbox(value: _allSalesMarked, onChanged: _markAllSales),
          ],
        ),
        const Text('Vásárlás dátuma'),
        for (Product product in widget.salesReport.products) ...[
          Text('${product.name} (db)'),
          for (Currency currency in Currency.values) Text('${product.name} (${currency.name})')
        ],
        const Text('Előrendelés'),
        ...widget.salesReport.currencyPaymentMethods
            .map((CurrencyPaymentMethodTuple currencyPaymentMethod) =>
                Text('Végösszeg (${currencyPaymentMethod.currency.name}, ${currencyPaymentMethod.paymentMethod.name})'))
            .toList(),
        ...widget.salesReport.currencyPaymentMethods
            .map((CurrencyPaymentMethodTuple currencyPaymentMethod) => Text(
                'Kedvezmémy (${currencyPaymentMethod.currency.name}, ${currencyPaymentMethod.paymentMethod.name})'))
            .toList(),
        ...widget.salesReport.currencyPaymentMethods
            .map((CurrencyPaymentMethodTuple currencyPaymentMethod) =>
                Text('Vásárlás (${currencyPaymentMethod.currency.name}, ${currencyPaymentMethod.paymentMethod.name})'))
            .toList()
      ],
    );
  }

  TableRow _buildTableRow(Sale sale) {
    return TableRow(
      children: [
        Checkbox(
            onChanged: (bool? checked) {
              _markSale(checked, sale.id!);
            },
            value: _markedSaleIds.contains(sale.id)),
        Text('${sale.date}'),
        for (Product product in widget.salesReport.products) ...[
          Text('${sale.itemsByProductId![product.id]!.amount}'),
          for (Currency currency in Currency.values)
            Text(currency == sale.currency ? '${sale.itemsByProductId![product.id]!.prices[currency]}' : ''),
        ],
        Text(sale.preOrder != null && sale.preOrder! ? 'Igen' : 'Nem'),
        ...widget.salesReport.currencyPaymentMethods.map(
          (CurrencyPaymentMethodTuple currencyPaymentMethodTuple) => Text(
              currencyPaymentMethodTuple.currency == sale.currency &&
                      currencyPaymentMethodTuple.paymentMethod == sale.paymentMethod
                  ? '${sale.sums![sale.currency]}'
                  : ''),
        ),
        ...widget.salesReport.currencyPaymentMethods.map(
          (CurrencyPaymentMethodTuple currencyPaymentMethodTuple) => Text(
              currencyPaymentMethodTuple.currency == sale.currency &&
                      currencyPaymentMethodTuple.paymentMethod == sale.paymentMethod &&
                      sale.discounts?[sale.currency] != null
                  ? '${sale.discounts![sale.currency]}'
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
    );
  }

  TableRow _buildSummaryRow() {
    return TableRow(
      children: [
        Container(),
        Container(),
        for (Product product in widget.salesReport.products) ...[
          Text('${widget.salesReport.salesSummary.productSummaries[product.id]!.amount}'),
          for (Currency currency in Currency.values)
            Text('${widget.salesReport.salesSummary.productSummaries[product.id]!.prices[currency]}'),
        ],
        Container(),
        ...widget.salesReport.salesSummary.sums.values.map((double sum) => Text('$sum')).toList(),
        ...widget.salesReport.salesSummary.discounts.values.map((double discount) => Text('$discount')).toList(),
        ...widget.salesReport.salesSummary.amounts.values.map((int amount) => Text('$amount')).toList(),
      ],
    );
  }

  void _deleteSales() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final NavigatorState navigator = Navigator.of(context);
        return AlertDialog(
          title: const Text("Megerősítés"),
          content: const Text('Biztosan törlölni akarod ezeket az eldásokat?'),
          actions: [
            TextButton(
              onPressed: () {
                navigator.pop();
              },
              child: const Text('Mégse'),
            ),
            TextButton(
              onPressed: () {
                ref.read(allSalesPageNotifierProvider.notifier).deleteSales(_markedSaleIds);
                navigator.pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _markAllSales(bool? checked) {
    setState(() {
      _markedSaleIds = [];
      if (checked != null && checked) {
        for (Sale sale in widget.salesReport.sales) {
          _markedSaleIds.add(sale.id!);
        }
        _allSalesMarked = true;
      } else {
        _allSalesMarked = false;
      }
    });
  }

  void _markSale(bool? checked, String saleId) {
    setState(() {
      if (checked != null && checked) {
        _markedSaleIds.add(saleId);
      } else {
        _markedSaleIds.remove(saleId);
      }
      _allSalesMarked = _markedSaleIds.length == widget.salesReport.sales.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(onPressed: _deleteSales, child: const Text('Törlés')),
        Table(
          border: TableBorder.all(),
          children: [
            _buildTableHeader(),
            ...widget.salesReport.sales.map(_buildTableRow).toList(),
            _buildSummaryRow(),
          ],
        ),
      ],
    );
  }
}
