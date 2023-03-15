import 'package:exhibition_register/features/sale/currency_selector/views/widgets/currency_tile.dart';
import 'package:exhibition_register/features/sale/data/currency.dart';
import 'package:flutter/material.dart';

class CurrencySelectorSuccessful extends StatelessWidget {
  const CurrencySelectorSuccessful({super.key, required this.currencies});

  final List<Currency> currencies;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Válasz ki a vásárlás valutájtát',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: currencies.map((Currency currency) => CurrencyTile(currency: currency)).toList(),
        )
      ],
    );
  }
}
