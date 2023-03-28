import 'package:cashier/features/sale/data/currency.dart';
import 'package:cashier/features/sale/sale/controller/sale_page_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Discounts extends ConsumerStatefulWidget {
  const Discounts({super.key});

  @override
  ConsumerState<Discounts> createState() => _DiscountsState();
}

class _DiscountsState extends ConsumerState<Discounts> {
  final Map<Currency, double> _discounts = {for (Currency currency in Currency.values) currency: 0};

  void _changeDiscount(double amount, Currency currency) {
    setState(() {
      _discounts[currency] = amount;
      ref.read(salePageStateNotifierProvider.notifier).updateSale(discounts: _discounts);
    });
  }

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
                initialValue: '${_discounts[currency]}',
                onChanged: (String? amount) {
                  if (amount != null) {
                    _changeDiscount(double.tryParse(amount) ?? 0, currency);
                  }
                },
              ),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(
            width: 20,
          ),
          itemCount: Currency.values.length,
        ),
      ),
    );
  }
}
