import 'dart:typed_data';

import 'package:cashier/features/sale/data/currency.dart';
import 'package:cashier/features/sale/data/currency_payment_method_tuple.dart';
import 'package:cashier/features/sale/data/product.dart';
import 'package:cashier/features/sale/data/sale.dart';
import 'package:cashier/features/sale/data/sales_report.dart';
import 'package:enough_convert/enough_convert.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';

class ExportSales extends StatelessWidget {
  const ExportSales({super.key, required this.salesReport});

  final SalesReport salesReport;

  void _exportSales() {
    String header = _createHeader();
    String rows = _createRows();

    _saveFile('$header\n$rows');
  }

  String _createHeader() {
    List<String> headerCells = [
      'Vásárlás dátuma',
      for (Product product in salesReport.products) ...[
        '${product.name} (db)',
        for (Currency currency in Currency.values) '${product.name} (${currency.name})'
      ],
      ...salesReport.currencyPaymentMethods
          .map((CurrencyPaymentMethodTuple currencyPaymentMethod) =>
              'Végösszeg (${currencyPaymentMethod.currency.name}, ${currencyPaymentMethod.paymentMethod.name})')
          .toList(),
      ...salesReport.currencyPaymentMethods
          .map((CurrencyPaymentMethodTuple currencyPaymentMethod) =>
              'Kedvezmémy (${currencyPaymentMethod.currency.name}, ${currencyPaymentMethod.paymentMethod.name})')
          .toList(),
      ...salesReport.currencyPaymentMethods
          .map((CurrencyPaymentMethodTuple currencyPaymentMethod) =>
              'Vásárlás (${currencyPaymentMethod.currency.name}, ${currencyPaymentMethod.paymentMethod.name})')
          .toList()
    ];
    return headerCells.join(';');
  }

  String _createRows() {
    List<String> rows = [];

    for (Sale sale in salesReport.sales) {
      List<String> row = [
        '${sale.date}',
        for (Product product in salesReport.products) ...[
          '${sale.itemsByProductId![product.id]!.amount}',
          for (Currency currency in Currency.values)
            currency == sale.currency ? '${sale.itemsByProductId![product.id]!.prices[currency]}' : '',
        ],
        ...salesReport.currencyPaymentMethods
            .map(
              (CurrencyPaymentMethodTuple currencyPaymentMethodTuple) =>
                  currencyPaymentMethodTuple.currency == sale.currency &&
                          currencyPaymentMethodTuple.paymentMethod == sale.paymentMethod
                      ? '${sale.sums![sale.currency]}'
                      : '',
            )
            .toList(),
        ...salesReport.currencyPaymentMethods.map((CurrencyPaymentMethodTuple currencyPaymentMethodTuple) =>
            currencyPaymentMethodTuple.currency == sale.currency &&
                    currencyPaymentMethodTuple.paymentMethod == sale.paymentMethod &&
                    sale.discounts?[sale.currency] != null
                ? '${sale.discounts![sale.currency]}'
                : ''),
        ...salesReport.currencyPaymentMethods
            .map((CurrencyPaymentMethodTuple currencyPaymentMethod) =>
                sale.currency == currencyPaymentMethod.currency &&
                        sale.paymentMethod == currencyPaymentMethod.paymentMethod
                    ? '1'
                    : '')
            .toList()
      ];

      rows.add(row.join(';'));
    }

    return rows.join('\n');
  }

  void _saveFile(String content) async {
    const Windows1250Codec windows1250codec = Windows1250Codec();
    final encodedContent = windows1250codec.encode(content);
    Uint8List bytes = Uint8List.fromList(encodedContent);

    await FileSaver.instance.saveFile(name: 'sales.csv', bytes: bytes);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: _exportSales, child: const Text('Exportálás'));
  }
}
