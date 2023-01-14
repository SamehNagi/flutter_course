// We need an auth provider such as Google, Apple, Facebook, ...etc
// What we need to do now is to create an auth provider class that
// encapsulates every provider that we may add in the future and creates
// a nice interface for them.

import 'package:mynotes/services/auth/auth_user.dart';

// Our auth provider is not going to have any logic. It is only an abstract class
// Though abstract classes in dart can contain logic but in this case out abstract
// class is just going to be a protocol / interface.
abstract class AuthProvider {
  Future<void> initialize();

  // What we need to do now is to give it the ability to return the current auth user.
  AuthUser? get currentUser;

  // What we also need to do is to allow it to be able to log a user in.
  Future<AuthUser> logIn({
    required String email,
    required String password,
  });

  // We also need a function to create a new user.
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });

  // And we should be able to log out as well.
  Future<void> logOut();

  // We also need to be able to send a verification email.
  Future<void> sendEmailVerification();
}
