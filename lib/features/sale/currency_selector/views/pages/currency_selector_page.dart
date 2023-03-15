import 'package:exhibition_register/features/sale/currency_selector/controller/currency_selector_page_state.dart';
import 'package:exhibition_register/features/sale/currency_selector/controller/currency_selector_page_state_notifier.dart';
import 'package:exhibition_register/features/sale/currency_selector/views/widgets/currency_selector_successful.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrencySelectorPage extends ConsumerStatefulWidget {
  const CurrencySelectorPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CurrencySelectorPage> createState() => _CurrencySelectorPageState();
}

class _CurrencySelectorPageState extends ConsumerState<CurrencySelectorPage> {
  @override
  void initState() {
    super.initState();
    Future(() {
      ref.read(currencySelectorPageStateNotifierProvider.notifier).loadCurrencies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final CurrencySelectorPageState state = ref.watch(currencySelectorPageStateNotifierProvider);
    return Scaffold(
      body: state.map(
        initial: (_) => Container(),
        successful: (successful) => CurrencySelectorSuccessful(currencies: successful.currencies),
      ),
    );
  }
}
