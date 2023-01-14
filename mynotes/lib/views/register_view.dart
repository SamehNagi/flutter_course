import 'package:flutter/material.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';
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
                // final userCredentials =
                // await FirebaseAuth.instance.createUserWithEmailAndPassword(
                await AuthService.firebase().createUser(
                  email: email,
                  password: password,
                );
                // devtools.log(userCredentials.toString());
                // The desired effect here is that our register page is gonna stay right here,
                // and then we are gonna push the verifyEmailRoute on top of it, if the users
                // in the verifyEmailRoute realize that they have done something wrong with
                // the email address, they can just press the back button on the top bar and
                // go 0back to the register page.
                // final user = FirebaseAuth.instance.currentUser;
                // await user?.sendEmailVerification();
                AuthService.firebase().sendEmailVerification();
                Navigator.of(context).pushNamed(verifyEmailRoute);
              } on WeakPasswordAuthException {
                await showErrorDialog(
                  context,
                  'Weak password',
                );
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(
                  context,
                  'Email is already in use',
                );
              } on InvalidEmailAuthException {
                await showErrorDialog(
                  context,
                  'This is an invalid email address',
                );
              } on GenericAuthException {
                await showErrorDialog(
                  context,
                  'Failed to register',
                );
              }
              // on FirebaseAuthException catch (e) {
              //   // print(e.code);
              //   if (e.code == 'weak-password') {
              //     // devtools.log('Weak password');
              //     await showErrorDialog(
              //       context,
              //       'Weak password',
              //     );
              //   }
              //   // else {
              //   //   print(e);
              //   // }
              //   else if (e.code == 'email-already-in-use') {
              //     // devtools.log('Email is already in use');
              //     await showErrorDialog(
              //       context,
              //       'Email is already in use',
              //     );
              //   }
              //   // else {
              //   //   print(e.code);
              //   // }
              //   else if (e.code == 'invalid-email') {
              //     // devtools.log('Invalid email entered');
              //     await showErrorDialog(
              //       context,
              //       'This is an invalid email address',
              //     );
              //   } else {
              //     await showErrorDialog(
              //       context,
              //       'Error: ${e.code}',
              //     );
              //   }
              //   // Handling other errors that might arise
              //   // This is a generic catch block meaning that if the exception that occurs in the try
              //   // statement is not a Firebase athentication exception, then in this catch block.
              // } catch (e) {
              //   // Here any other exception is an object not known to me and it is up to you to
              //   // display that error.
              //   await showErrorDialog(
              //     context,
              //     e.toString(),
              //   );
              // }
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
