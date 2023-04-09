import 'package:cashier/features/auth/sign_in/controller/sign_in_page_state.dart';
import 'package:cashier/features/auth/sign_in/controller/sign_in_page_state_notifier.dart';
import 'package:cashier/features/auth/sign_in/view/widgets/sign_in_error.dart';
import 'package:cashier/features/auth/sign_in/view/widgets/sign_in_in_progress.dart';
import 'package:cashier/features/auth/sign_in/view/widgets/sign_in_initial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SignInPageState state = ref.watch(signInPageStateNotifierProvider);
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
