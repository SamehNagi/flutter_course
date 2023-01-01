import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';
// Only import a specific part of the package developer and give the package an alias
// and then use it as devtools.log
// import 'dart:developer' as devtools show log;
import '../constants/routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
                // final userCredentials =
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                // devtools.log(userCredentials.toString());
                final user = FirebaseAuth.instance.currentUser;
                // We can login with a user who hasn't confirmed their email. So we need to handle this.
                if (user?.emailVerified ?? false) {
                  // user's email is verified
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    notesRoute,
                    (route) => false,
                  );
                } else {
                  // user's email is NOT verified
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    verifyEmailRoute,
                    (route) => false,
                  );
                }
              } on FirebaseAuthException catch (e) {
                // This is to only catch the errors with runtime type of FirebaseAuthException
                // print(e.runtimeType);
                // print('something bad happened');
                // print(e);
                if (e.code == 'user-not-found') {
                  // devtools.log('User not found');
                  await showErrorDialog(
                    context,
                    'User not found',
                  );
                }
                // else {
                //   print('something else happened');
                //   print(e.code);
                // }
                else if (e.code == 'wrong-password') {
                  // devtools.log('Wrong password');
                  await showErrorDialog(
                    context,
                    'Wrong password',
                  );
                  // Handling other Firebase authentication exceptions
                } else {
                  await showErrorDialog(
                    context,
                    'Error: ${e.code}',
                  );
                }
                // Handling other errors that might arise
                // This is a generic catch block meaning that if the exception that occurs in the try
                // statement is not a Firebase athentication exception, then in this catch block.
              } catch (e) {
                // Here any other exception is an object not known to me and it is up to you to
                // display that error.
                await showErrorDialog(
                  context,
                  e.toString(),
                );
              }
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              // Now we will remove everything before pushing the new route.
              // This will cause an issue because we cannot just push a column without scaffold,
              // because at this moment, the build method of the RegisterView is returning a column.
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text('Not registered yet? Register here!'),
          )
        ],
      ),
    );
  }
}
