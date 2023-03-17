import 'package:cash/features/sale/data/currency.dart';
import 'package:cash/features/sale/data/sale_item.dart';
import 'package:cash/features/sale/sale/controller/sale_page_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SaleItemTable extends ConsumerStatefulWidget {
  const SaleItemTable({
    super.key,
    required this.saleItems,
  });

  final List<SaleItem> saleItems;

  @override
  ConsumerState<SaleItemTable> createState() => _SaleItemTableState();
}

class _SaleItemTableState extends ConsumerState<SaleItemTable> {
  void changeAmount(SaleItem saleItem, int? amount) {
    if (amount != null) {
      ref.read(salePageStateNotifierProvider.notifier).updateSale(saleItem: saleItem.copyWith(amount: amount));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: widget.saleItems
          .map((SaleItem saleItem) => TableRow(
                children: [
                  Text(
                    saleItem.product.name,
                    textAlign: TextAlign.center,
                  ),
                  ...saleItem.product.prices.entries
                      .map((MapEntry<Currency, double> price) => Text(
                            '${price.value} ${price.key.name}',
                            textAlign: TextAlign.center,
                          ))
                      .toList(),
                  TextFormField(
                    decoration: const InputDecoration(suffix: Text('db')),
                    initialValue: saleItem.amount.toString(),
                    keyboardType: TextInputType.number,
                    onChanged: (String? amount) {
                      if (amount != null) {
                        changeAmount(saleItem, int.tryParse(amount));
                      }
                    },
                  ),
                  ...saleItem.prices.entries
                      .map((MapEntry<Currency, double> price) => Text(
                            '${price.value} ${price.key.name}',
                            textAlign: TextAlign.center,
                          ))
                      .toList(),
                ],
              ))
          .toList(),
    );
  }
}
