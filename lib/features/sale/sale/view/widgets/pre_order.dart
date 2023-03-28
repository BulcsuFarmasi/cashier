import 'package:cashier/features/sale/sale/controller/sale_page_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PreOrder extends ConsumerStatefulWidget {
  const PreOrder(this.preOrder, {super.key});

  final bool? preOrder;

  @override
  ConsumerState<PreOrder> createState() => _PreOrderState();
}

class _PreOrderState extends ConsumerState<PreOrder> {

  bool _preOrder = false;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _preOrder = widget.preOrder ?? false;
  }

  void _changePreOrder(bool? changed) {
    setState(() {
      ref.read(salePageStateNotifierProvider.notifier).updateSale(preOrder: changed);
      _preOrder = changed != null && changed ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ListTile(
        leading: Checkbox(
          onChanged: _changePreOrder,
          value: _preOrder,
        ),
        title: const Text('Előrendelés'),
      ),
    );
  }
}
