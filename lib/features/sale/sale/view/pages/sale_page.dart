import 'package:cashier/features/sale/data/sale.dart';
import 'package:cashier/features/sale/sale/controller/sale_page_state.dart';
import 'package:cashier/features/sale/sale/controller/sale_page_state_notifier.dart';
import 'package:cashier/features/sale/sale/view/widgets/comment_field.dart';
import 'package:cashier/features/sale/sale/view/widgets/currency_selector.dart';
import 'package:cashier/features/sale/sale/view/widgets/discounts.dart';
import 'package:cashier/features/sale/sale/view/widgets/payment_method_selector.dart';
import 'package:cashier/features/sale/sale/view/widgets/sale_item_table.dart';
import 'package:cashier/features/sale/sale/view/widgets/sum_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SalePage extends ConsumerStatefulWidget {
  const SalePage({super.key});

  static const routeName = '/sale';

  @override
  ConsumerState<SalePage> createState() => _SalePageState();
}

class _SalePageState extends ConsumerState<SalePage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    super.initState();
    Future(() {
      ref.read(salePageStateNotifierProvider.notifier).createSale();
    });
  }

  void finalizeSale(BuildContext context, WidgetRef ref) {
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
                _formKey.currentState!.reset();
                ref.read(salePageStateNotifierProvider.notifier).saveSale();
                navigator.pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
  
  Widget _buildSuccessful(Sale sale) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (sale.items != null)
            SaleItemTable(
              saleItems: sale.items!,
            ),
          const SizedBox(
            height: 50,
          ),
          const Discounts(),
          const SizedBox(
            height: 30,
          ),
          SumRow(sums: sale.sums!),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PaymentMethodSelector(
                paymentMethod: sale.paymentMethod,
              ),
              const SizedBox(
                width: 30,
              ),
              CurrencySelector(
                currency: sale.currency,
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          const CommentField(),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: sale.paymentMethod != null && sale.currency != null
                ? () {
              finalizeSale(context, ref);
            }
                : null,
            child: const Text('Fizetve'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final SalePageState state = ref.watch(salePageStateNotifierProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: state.map(
          initial: (_) => Container(),
          saleLoadSuccessful: (saleLoadSuccessful) => _buildSuccessful(saleLoadSuccessful.sale),
        ),
      ),
    );
  }
}
