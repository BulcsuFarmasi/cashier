import 'package:cashier/features/auth/sign_in/view/pages/sign_in_page.dart';
import 'package:cashier/features/sale/all_sales/view/pages/all_sales_page.dart';
import 'package:cashier/features/sale/sale/view/pages/sale_page.dart';
import 'package:cashier/shared/widgets/app/controller/app_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Cashier',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ref.read(appStateNotifierProvider).map(
            signedIn: (_) => routes[SalePage.routeName]!,
            signedOut: (_) => routes[SignInPage.routeName]!,
          ),
      onGenerateRoute: (RouteSettings settings) {
        ref.read(appStateNotifierProvider.notifier).checkUser();
        return ref.read(appStateNotifierProvider).map(
              signedIn: (_) => MaterialPageRoute(builder: (_) => routes[settings.name!]!),
              signedOut: (_) => MaterialPageRoute(builder: (_) => routes[SignInPage.routeName]!),
            );
      },
    );
  }
}

final Map<String, Widget> routes = {
  SignInPage.routeName: const SignInPage(),
  SalePage.routeName: const SalePage(),
  AllSalesPage.routeName: const AllSalesPage(),
};
