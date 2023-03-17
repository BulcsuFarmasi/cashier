import 'package:cash/features/sale/data/sale.dart';
import 'package:cash/features/sale/sale/view/widgets/payment_method_selector.dart';
import 'package:cash/features/sale/sale/view/widgets/sale_item_table.dart';
import 'package:cash/features/sale/sale/view/widgets/sum_row.dart';
import 'package:flutter/material.dart';

class SaleLoadSuccessful extends StatelessWidget {
  const SaleLoadSuccessful({super.key, required this.sale});

  final Sale sale;

  void finalizeSale(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          final NavigatorState navigator = Navigator.of(context);
          return AlertDialog(
            title: const Text("Megerősítés"),
            content: const Text('Biztosan le akarod zárni a vásárlást?'),
            actions: [
              TextButton(
                onPressed: () {
                  navigator.pop();
                },
                child: const Text('Mégse'),
              ),
              TextButton(
                onPressed: () {
                  navigator.pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {


    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (sale.items != null) SaleItemTable(saleItems: sale.items!),
        const SizedBox(
          height: 50,
        ),
        SumRow(sums: sale.sums!),
        const SizedBox(
          height: 30,
        ),
        PaymentMethodSelector(
          paymentMethod: sale.paymentMethod,
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
          onPressed: sale.paymentMethod != null
              ? () {
                  finalizeSale(context);
                }
              : null,
          child: const Text('Fizetve'),
        ),
      ],
    );
  }
}
