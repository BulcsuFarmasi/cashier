import 'package:cashier/features/sale/data/currency_payment_method_tuple.dart';
import 'package:cashier/features/sale/data/product.dart';
import 'package:cashier/features/sale/data/sale.dart';
import 'package:cashier/features/sale/data/sales_summary.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sales_report.freezed.dart';

@freezed
class SalesReport with _$SalesReport {
  const factory SalesReport(List<Sale> sales, List<Product> products, SalesSummary salesSummary, List<CurrencyPaymentMethodTuple> currencyPaymentMethods) = _SalesReport;
}