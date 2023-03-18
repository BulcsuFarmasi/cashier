import 'package:cashier/features/sale/data/payment_method.dart';
import 'package:cashier/features/sale/sale/controller/sale_page_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentMethodSelector extends ConsumerStatefulWidget {
  const PaymentMethodSelector({super.key, this.paymentMethod});

  final PaymentMethod? paymentMethod;

  @override
  ConsumerState<PaymentMethodSelector> createState() => _PaymentMethodSelectorState();
}

class _PaymentMethodSelectorState extends ConsumerState<PaymentMethodSelector> {
  PaymentMethod? _paymentMethod;

  @override
  void initState() {
    super.initState();
    _paymentMethod = widget.paymentMethod;
  }

  void _changePaymentMethod(PaymentMethod? paymentMethod) {
    setState(() {
      _paymentMethod = paymentMethod;
      ref.read(salePageStateNotifierProvider.notifier).updateSale(paymentMethod: paymentMethod);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 175,
      child: Column(
        children: [
          Text(
            'Fizetés módja',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          for (PaymentMethod paymentMethod in PaymentMethod.values)
            ListTile(
              title: Text(paymentMethod.name),
              leading: Radio<PaymentMethod>(value: paymentMethod, groupValue: _paymentMethod, onChanged: _changePaymentMethod),
            ),
        ],
      ),
    );
  }
}
