import 'package:cashier/features/sale/data/sales_report.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'all_sales_page_state.freezed.dart';

@freezed
class AllSalesPageState with _$AllSalesPageState {
  const factory AllSalesPageState.initial() = _Initial;

  const factory AllSalesPageState.inProgress() = _InProgress;

  const factory AllSalesPageState.successful(SalesReport salesReport) = _Successful;
}
