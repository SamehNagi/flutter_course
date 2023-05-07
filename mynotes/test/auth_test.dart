import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentication', () {
    final provider = MockAuthProvider();

    // Testing provider.isInitialized: Provider shouldn't be initialized to begin with
    test('Should not be initialized to begin with', () {
      expect(provider.isInitialized, false);
    });

    // Test logging out before initialization: The provider should throw a NotInitializedException
    test('Cannot log out if not initialized', () {
      expect(
        provider.logOut(),
        // throwsA is a matcher and it matches the result of the logout function against whatever you provide as a parameter
        throwsA(const TypeMatcher<NotInitializedException>()),
      );
    });

    // Testing provider initialization: provider.isInitialized
    test('Should be able to be initialized', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });

    // Testing null user to begin with: The user should be null upon initializaion
    test('User should be null after initialization', () {
      expect(provider.currentUser, null);
    });

    // Testing time required to initialize: We can use timeout in this case
    test(
      'Should be able to initialize in less than 2 seconds',
      () async {
        await provider.initialize();
        expect(provider.isInitialized, true);
      },
      timeout: const Timeout(Duration(seconds: 2)),
    );

    // Test creating a user: And test all edge cases that might occur
    test('Create user should delegate to logIn function', () async {
      final badEmailUser = provider.createUser(
        email: 'foo@bar.com',
        password: 'anypassword',
      );
      expect(badEmailUser,
          throwsA(const TypeMatcher<UserNotFoundAuthException>()));

      final badPasswordUser = provider.createUser(
        email: 'someone@bar.com',
        password: 'foobar',
      );
      expect(badPasswordUser,
          throwsA(const TypeMatcher<WrongPasswordAuthException>()));

      final user = await provider.createUser(
        email: 'foo',
        password: 'bar',
      );
      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });

    // Test email verification: A logged in user should be able to send email verification
    test('Logged in user should be able to get verified', () {
      provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });

    // Test logging out and in again: This is a normal scenario that should just work
    test('Should be able to log out and log in again', () async {
      await provider.logOut();
      await provider.logIn(
        email: 'email',
        password: 'password',
      );
      final user = provider.currentUser;
      expect(user, isNotNull);
    });
  });
}

class NotInitializedException implements Exception {}

// We need a mock auth provider
// Mokcking is when you create a new function or a class and then you can then inject that
// into another place and then test that another palce.
class MockAuthProvider implements AuthProvider {
  // If you remember, our AuthProvider has a function called initialize.
  // Now when we were using AuthProvider in the context of firebase, firebase
  // internally has the concept of whether it is intialized or not. But when
  // we are creating a MockAuthProvider where is that functionality. We don't
  // keep track yet of whether our MockAuthPRovider is actually initialized
  // or not. And we just have an initialize function but what if someone calls
  // createUser on our MockAuthProvider without having initialized the provider
  // yet. So, let's keep track of that and create _isInitialized.
  var _isInitialized = false;

  AuthUser? _user;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NotInitializedException();
    await Future.delayed(const Duration(seconds: 1));
    // Added delay to simulate the actual behavior (i.e. faking an API call).

    // Now we need to make sure that this CreateUser actually returns an
    // AuthUser. By creating a user what we're going to do in our
    // MockAuthProvider is actually logging that user in as well.
    return logIn(
      email: email,
      password: password,
    );
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) {
    if (!isInitialized) throw NotInitializedException();
    if (email == 'foo@bar.com') throw UserNotFoundAuthException();
    if (password == 'foobar') throw WrongPasswordAuthException();
    const user = AuthUser(isEmailVerified: false);
    _user = user;

    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotFoundAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitializedException();
    // Remember an AuthUser has isEmailVerified as final which means you cannot change it.
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();
    const newUser = AuthUser(isEmailVerified: true);
    _user = newUser;
  }

  // The reason we are saying _ is because this is making this property
  // pretty much private to our MockAuthProvider, so we are indicating
  // to the outside word that hey you shouldn't be reading or writing to
  // this property.
  bool get isInitialized => _isInitialized;
}
