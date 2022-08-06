import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _email,
          enableSuggestions: false,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: 'Enter your email here',
          ),
        ),
        TextField(
          controller: _password,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: const InputDecoration(
            hintText: 'Enter your password here',
          ),
        ),
        TextButton(
          onPressed: () async {
            final email = _email.text;
            final password = _password.text;
            try {
              final userCredentials =
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: email,
                password: password,
              );
              print(userCredentials);
            } on FirebaseAuthException catch (e) {
              // print(e.code);
              if (e.code == 'weak-password') {
                print('Weak password');
              }
              // else {
              //   print(e);
              // }
              else if (e.code == 'email-already-in-use') {
                print('Email is already in use');
              }
              // else {
              //   print(e.code);
              // }
              else if (e.code == 'invalid-email') {
                print('Invalid email entered');
              }
            }
          },
          child: const Text('Register'),
        ),
      ],
    );
  }
}
