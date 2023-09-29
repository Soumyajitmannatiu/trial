import 'package:first/auth/auth_provider.dart';
import 'package:first/auth/auth_user.dart';
import 'package:first/auth/firebase_auth_provider.dart';

class AuthService implements Authprovider {
  final Authprovider provider;

  AuthService(this.provider);
  factory AuthService.firebase() => AuthService(firebaseAuthProvider());

  @override
  Future<AuthUser> createuser({
    required String email,
    required String password,
  }) =>
      provider.createuser(
        email: email,
        password: password,
      );

  @override
  Future<void> logout() => provider.logout();

  @override
  Future<AuthUser> signin({
    required String email,
    required String password,
  }) =>
      provider.signin(email: email, password: password);

  @override
  // TODO: implement user
  AuthUser? get user => provider.user;

  @override
  Future<void> verifyEmail() => provider.verifyEmail();

  @override
  Future<void> initialize() => provider.initialize();
}
