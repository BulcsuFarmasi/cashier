import 'package:exhibition_register/features/sale/data/currency.dart';
import 'package:flutter/material.dart';

class CurrencyTile extends StatelessWidget {
  const CurrencyTile({super.key, required this.currency});

  final Currency currency;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {},
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Center(
            child: Text(
              currency.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
      ),
    );
  }
}
