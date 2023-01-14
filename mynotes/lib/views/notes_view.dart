import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/enums/menu_action.dart';
import 'package:mynotes/services/auth/auth_service.dart';

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
                    // await FirebaseAuth.instance.signOut();
                    await AuthService.firebase().logOut();
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
