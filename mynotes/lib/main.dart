import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'package:mynotes/views/verify_email_view.dart';
import 'constants/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
    routes: {
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      notesRoute: (context) => const NotesView(),
      verifyEmailRoute: (context) => const VerifyEmailView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // BuildContext is a package of information that you can use to pass data from one widget to another
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        // Async snapshot of an object is the state of that object right now.
        // that object is actually the result of your future which is the Firebase app.
        // A future has a start point, a line where it prrocesses its info, and an end point.
        // The snapshot is your your way of getting the results of your future,
        // whether it is started, is it processing, is it done, or did it failed.
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                // print('Email is verified');
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
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
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

enum MenuAction { logout }

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main UI"),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              // print(value);
              // devtools.log(value.toString());
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  // devtools.log(ShouldLogout.toString());
                  if (shouldLogout) {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute,
                      (route) => false,
                    );
                  }
              }
            },
            itemBuilder: (context) {
              // Here the itemBuilder is returning a list of PopupMenuEntery and the PopupMenuItem is of
              // type PopupMenuEntery so, we do the following: return [ add here the PopupMenuItem ].
              return [
                const PopupMenuItem<MenuAction>(
                  // The value is what the programmer sees and the child is what the user sees
                  value: MenuAction.logout,
                  child: Text('Log out'),
                )
              ];
            },
          )
        ],
      ),
      body: const Text("Hello world"),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Log out')),
        ],
      );
    },
  ).then(
      (value) => value ?? false); // What we did here is because the showDialog
  // is returning a future of a possible value while our showLogOutDialog is returning a
  // future of a bool. The user might be able to dismiss the dialog without actually
  // selecting Cancel or Logout causing the showdialog to return null. So, we added
  // then function to return the value if it is present of return false otherwise.
}
