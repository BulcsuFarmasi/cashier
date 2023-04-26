import 'package:cashier/features/sale/data/currency.dart';
import 'package:flutter/material.dart';

class SumRow extends StatelessWidget {
  const SumRow({super.key, required this.sums});

  final Map<Currency, double> sums;

  @override
  Widget build(BuildContext context) {
    final sumStyle = Theme.of(context).textTheme.headlineMedium;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Végösszeg: ',
          style: sumStyle,
        ),
        for (MapEntry<Currency, double> sum in sums.entries)
          Text(
            '${sum.value} ${sum.key.name}, ',
            style: sumStyle,
          ),
      ],
    );
  }
}
