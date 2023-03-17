import 'package:cash/features/sale/data/payment_method.dart';
import 'package:cash/features/sale/sale/controller/sale_page_state_notifier.dart';
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
      width: 250,
      child: Column(
        children: [
          ListTile(
            title: const Text('Készpénz'),
            leading: Radio<PaymentMethod>(
                value: PaymentMethod.cash, groupValue: _paymentMethod, onChanged: _changePaymentMethod),
          ),
          ListTile(
            title: const Text('Kártya'),
            leading: Radio<PaymentMethod>(
                value: PaymentMethod.card, groupValue: _paymentMethod, onChanged: _changePaymentMethod),
          ),
        ],
      ),
    );
  }
}
