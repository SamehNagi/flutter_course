import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_user.dart';

// Here we need to implement an AuthService class which implements an AuthProvider
// It relays the messages of the given auth provider, but can have more logic.
class AuthService implements AuthProvider {
  // The auth service in itself isn't going to be hard coded to user Firebase auth provider.
  // What it is going to do is that it is going to take an auth provider from you and expose the
  // functionalities from that auth provider to the outside world with the ability to maybe even
  // change that data before it returns it to you.
  final AuthProvider provider;

  const AuthService(this.provider);

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) =>
      provider.createUser(
        email: email,
        password: password,
      );
  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) =>
      provider.logIn(
        email: email,
        password: password,
      );

  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();
}
