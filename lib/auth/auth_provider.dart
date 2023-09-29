import 'package:first/auth/auth_user.dart';

abstract class Authprovider {
  Future<void> initialize();
  AuthUser? get user;
  Future<AuthUser> signin({
    required String email,
    required String password,
  });
  Future<AuthUser> createuser({
    required String email,
    required String password,
  });
  Future<void> logout();
  Future<void> verifyEmail();
}
