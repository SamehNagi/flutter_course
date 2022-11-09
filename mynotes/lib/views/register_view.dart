import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// Only import a specific part of the package developer and give the package an alias
// and then use it as devtools.log
import 'dart:developer' as devtools show log;

import '../constants/routes.dart';

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
    // LoginView is being embedded into HomePage which has a scaffold.
    // So, since we did now added a scaffold into the build method of LoginView,
    // we must remove the scaffold of the HomePage,
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Column(
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
                devtools.log(userCredentials.toString());
              } on FirebaseAuthException catch (e) {
                // print(e.code);
                if (e.code == 'weak-password') {
                  devtools.log('Weak password');
                }
                // else {
                //   print(e);
                // }
                else if (e.code == 'email-already-in-use') {
                  devtools.log('Email is already in use');
                }
                // else {
                //   print(e.code);
                // }
                else if (e.code == 'invalid-email') {
                  devtools.log('Invalid email entered');
                }
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              // Now we will remove everything before pushing the new route.
              // This will cause an issue because we cannot just push a column without scaffold,
              // because at this moment, the build method of the LoginView is returning a column.
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text('Already registered? Login here!'),
          ),
        ],
      ),
    );
  }
}
