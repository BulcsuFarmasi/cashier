import 'package:cash/features/sale/data/sale.dart';
import 'package:cash/features/sale/data/sale_item.dart';
import 'package:cash/features/sale/sale/view/widgets/payment_method_selector.dart';
import 'package:cash/features/sale/sale/view/widgets/product_tile.dart';
import 'package:flutter/material.dart';

class ProductsSaleLoadSuccessful extends StatelessWidget {
  const ProductsSaleLoadSuccessful({super.key, required this.sale});

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
    final sumStyle = Theme.of(context).textTheme.headlineMedium;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: sale.items?.map((SaleItem saleItem) {
                return ProductTile(
                  saleItem: saleItem,
                );
              }).toList() ??
              [],
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Végösszeg: ',
              style: sumStyle,
            ),
            // Text(
            //   sale.sum != null ? '${sale.sum} ${sale.currency.name}' : '0 ${sale.currency.name}',
            //   style: sumStyle,
            // ),
          ],
        ),
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
          onPressed: (sale.paymentMethod != null && sale.sum != null && sale.sum != 0)
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
