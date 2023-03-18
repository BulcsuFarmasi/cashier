import 'package:cashier/features/sale/data/currency.dart';
import 'package:cashier/features/sale/sale/controller/sale_page_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrencySelector extends ConsumerStatefulWidget {
  const CurrencySelector({super.key, this.currency});

  final Currency? currency;

  @override
  ConsumerState<CurrencySelector> createState() => _CurrencySelectorState();
}

class _CurrencySelectorState extends ConsumerState<CurrencySelector> {
  Currency? _currency;

  @override
  void initState() {
    super.initState();
    _currency = widget.currency;
  }

  void _changeCurrency(Currency? currency) {
    setState(() {
      _currency = currency;
      ref.read(salePageStateNotifierProvider.notifier).updateSale(currency: currency);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 175,
      child: Column(
        children: [
          Text(
            'Valuta',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          for (Currency currency in Currency.values)
            ListTile(
              title: Text(currency.name),
              leading: Radio<Currency>(value: currency, groupValue: _currency, onChanged: _changeCurrency),
            ),
        ],
      ),
    );
  }
}
