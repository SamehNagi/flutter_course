import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Verify email'),
    //   ),
    //   body: Column(
    //     children: [
    //       const Text('Please verify your email address:'),
    //       TextButton(
    //         onPressed: () async {
    //           final user = FirebaseAuth.instance.currentUser;
    //           await user?.sendEmailVerification();
    //         },
    //         child: const Text('Send email verification'),
    //       ),
    //     ],
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify email'),
      ),
      body: Column(
        children: [
          const Text(
              "We've sent you an email verification, please open it to verify your account."),
          const Text(
              "If you haven't received a verification email yet, press the button below"),
          TextButton(
            onPressed: () async {
              // final user = FirebaseAuth.instance.currentUser;
              // await user?.sendEmailVerification();
              await AuthService.firebase().sendEmailVerification();
            },
            child: const Text('Send email verification'),
          ),
          // We need a restart button to end the verify email view and sign the user out so
          // that we don't get stuck with verifyEmailView.
          TextButton(
            onPressed: () async {
              // await FirebaseAuth.instance.signOut();
              await AuthService.firebase().logOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }
}
