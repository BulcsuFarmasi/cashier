import 'package:cash/features/sale/data/currency.dart';
import 'package:cash/features/sale/data/sale_item.dart';
import 'package:cash/features/sale/sale/controller/sale_page_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductTile extends ConsumerStatefulWidget {
  const ProductTile({
    super.key,
    required this.saleItem,
  });

  final SaleItem saleItem;

  @override
  ConsumerState<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends ConsumerState<ProductTile> {
  TextEditingController? amountEditingController;

  @override
  void didUpdateWidget(covariant ProductTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    amountEditingController = TextEditingController(text: widget.saleItem.amount.toString());
    amountEditingController!.addListener(changeAmount);
  }

  void changeAmount() {
    final SaleItem saleItem = widget.saleItem.copyWith(amount: int.parse(amountEditingController?.text ?? ""));
    print(saleItem);
    ref.read(salePageStateNotifierProvider.notifier).updateSale(saleItem: saleItem);
  }

  @override
  void dispose() {
    amountEditingController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        children: [
          Text(
            widget.saleItem.product.name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 20,
          ),
          // Text('${widget.saleItem.product.prices[widget.currency.code]} ${widget.currency.name}'),
          TextField(
            controller: amountEditingController,
          ),
        ],
      ),
    );
  }
}
