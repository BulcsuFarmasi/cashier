import 'package:cashier/features/auth/sign_in/controller/sign_in_page_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInForm extends ConsumerStatefulWidget {
  const SignInForm({this.email, this.password, super.key});

  final String? email;
  final String? password;

  @override
  ConsumerState<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends ConsumerState<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _email;
  String? _password;

  @override
  void initState() {
    super.initState();
    _email = widget.email;
    _password = widget.password;
  }

  void _saveEmail(String? email) {
    setState(() {
      if (email != null) {
        _email = email;
      }
    });
  }

  void _savePassword(String? password) {
    setState(() {
      if (password != null) {
        _password = password;
      }
    });
  }

  void _submitForm() {
    _formKey.currentState!.save();

    if (_email != null && _password != null) {
      ref.read(signInPageStateNotifierProvider.notifier).signIn(_email!, _password!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Cashier',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Email'),
            ),
            initialValue: _email,
            onSaved: _saveEmail,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Jelszó'),
            ),
            initialValue: _password,
            onSaved: _savePassword,
            obscureText: true,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: _submitForm,
            child: const Text('Bejelentkezés'),
          )
        ],
      ),
    );
  }
}
