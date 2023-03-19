import 'package:cashier/features/sale/data/sale.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sales_report.freezed.dart';
part 'sales_report.g.dart';

@freezed
class SalesReport with _$SalesReport {
  const factory SalesReport(List<Sale> sales) = _SalesReport;

  factory SalesReport.fromJson(Map<String, Object?> json) => _$SalesReportFromJson(json);
}