import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // BuildContext is a package of information that you can use to pass data from one widget to another
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          // Async snapshot of an object is the state of that object right now.
          // that object is actually the result of your future which is the Firebase app.
          // A future has a start point, a line where it prrocesses its info, and an end point.
          // The snapshot is your your way of getting the results of your future,
          //-whether it is started, is it processing, is it done, or did it failed.
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              // final user = FirebaseAuth.instance.currentUser;
              // print(user?.emailVerified);
              // if (user?.emailVerified ?? false) {
              //   return const Text('Done');
              // } else {
              //   // Here we are pushing a scaffold (i.e. VerifyEmailView) which is a future builder on top of another scaffold (HomeView) and they have the same structure. This causes a problem
              //   // because we are pushing a future builder, and we are not allowed to do that.
              //   // To fix this issue, you can change the scaffold of VerifyEmailView to a column.
              //   // Navigator.of(context).push(MaterialPageRoute(
              //   //     builder: (context) => const VerifyEmailView()));
              //   // Now we can change the Navigator to only return the VerifyEmailView because it is now a column.
              //   return const VerifyEmailView();
              // }
              return const LoginView();
            default:
              return const Text('Loading...');
          }
        },
      ),
    );
  }
}

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
    return Column(
      children: [
        const Text('Please verify your email address:'),
        TextButton(
          onPressed: () async {
            final user = FirebaseAuth.instance.currentUser;
            await user?.sendEmailVerification();
          },
          child: const Text('Send email verification'),
        ),
      ],
    );
  }
}
