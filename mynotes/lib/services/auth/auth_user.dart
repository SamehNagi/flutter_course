import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

// We need an auth provider abstract class and AuthService
// So we are going to take Firebase and think of it as an authentication provider
// So we are going to create a class which we are calling at the moment Firebase auth provider
// but we are going to say that this Firebase auth provider comes from another class
// called auth provider.
// So what we are going to do then is going to say any auth provider that our application
// can work with is expected to have certain functionality and certain properties such as:
// - The current auth provider should be able to return the current user.
// - The auth provider should be able to log a user in.
// - should be able to log a user out.
// - should be able register a user.
// - should be able to send and email for verification.
// This will be our abstract auth provider class. Then we will create another class which
// will be the concrete implementation of that abstract class.
// Then we will create another class called auth service which will take a provider
// such as Firebase auth provider, Google auth provider and expose the functionalities of
// this provider to the outside world.
// The goal of this is that our UI talking with that service and that service will talk
// to a provider (i.e. Firebase auth provider) and that provider will talk to Firebase.
// At the end of this chapter, we will have 4 layers:
// UI | AuthService | Firebase AuthProvider | Firebase

// We need an auth user because we shouln't expose Firebase's user to the UI.
@immutable // immutable is an innotation that this class and any subclasses are going to be immutable (i.e. their internals are not going to be changed upon initialization)
class AuthUser {
  final bool isEmailVerified;
  const AuthUser(this.isEmailVerified);

  // Now we need a factory constructor that creates our AuthUser from a Firebase user
  factory AuthUser.fromFirebase(User user) => AuthUser(user.emailVerified);
  // So all we did here is we copied the Firebase user into out own AuthUser.
}
