import 'package:cashier/features/auth/sign_in/controller/sign_in_page_state.dart';
import 'package:cashier/features/auth/sign_in/controller/sign_in_page_state_notifier.dart';
import 'package:cashier/features/auth/sign_in/view/widgets/sign_in_error.dart';
import 'package:cashier/features/auth/sign_in/view/widgets/sign_in_in_progress.dart';
import 'package:cashier/features/auth/sign_in/view/widgets/sign_in_initial.dart';
import 'package:cashier/features/sale/sale/view/pages/sale_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  static const routeName = '/sign-in';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SignInPageState state = ref.watch(signInPageStateNotifierProvider);
    ref.listen(signInPageStateNotifierProvider, (_, SignInPageState next) {
      next.maybeMap(successful: (_) async {
        await Navigator.of(context).pushNamed(SalePage.routeName);
      },orElse: () => null);
    });
    return Scaffold(
      body: Center(
        child: SizedBox(
            width: 500,
            child: state.maybeMap(
              initial: (_) => const SignInInitial(),
              inProgress: (inProgress) => SignInInProgress(email: inProgress.email, password: inProgress.password),
              error: (error) => SignInError(email: error.email, password: error.password),
              orElse: () => Container(),
            )),
      ),
    );
  }
}
