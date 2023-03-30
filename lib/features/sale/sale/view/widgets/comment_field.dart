import 'package:cashier/features/sale/sale/controller/sale_page_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentField extends ConsumerWidget {
  const CommentField({String? comment, super.key}) : _comment = comment;

  final String? _comment;

  void _changeComment(String? comment, WidgetRef ref) {
    ref.read(salePageStateNotifierProvider.notifier).updateSale(comment: comment);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 300,
      child: TextFormField(
        initialValue: _comment,
        maxLines: 3,
        decoration: const InputDecoration(
          label: Text('Megjegyzés'),
        ),
        onChanged: (String? value) {
          _changeComment(value, ref);
        },
      ),
    );
  }
}
