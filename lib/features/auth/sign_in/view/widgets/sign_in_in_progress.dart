import 'package:cashier/features/auth/sign_in/view/widgets/sign_in_form.dart';
import 'package:flutter/material.dart';

class SignInInProgress extends StatelessWidget {
  const SignInInProgress({super.key, required this.email, required this.password});

  final String email;
  final String password;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SignInForm(
          email: email,
          password: password,
        ),
        const CircularProgressIndicator()
      ],
    );
  }
}
