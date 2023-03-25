import 'package:cashier/features/sale/data/currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Discounts extends ConsumerStatefulWidget {
  const Discounts({super.key});

  @override
  ConsumerState<Discounts> createState() => _DiscountsState();
}

class _DiscountsState extends ConsumerState<Discounts> {
  final Map<Currency, double> discounts = {for (Currency currency in Currency.values) currency: 0};

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 50,
        width: 320,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, int index) {
            final Currency currency = Currency.values[index];
            return SizedBox(
              width: 150,
              child: TextFormField(
                decoration: InputDecoration(
                  label: Text('Kedvezmény (${currency.name})'),
                ),
                initialValue: '${discounts[currency]}',
              ),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(width: 20,),
          itemCount: Currency.values.length,
        ),
      ),
    );
  }
}
