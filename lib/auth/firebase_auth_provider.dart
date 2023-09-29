import 'package:first/auth/authException.dart';
import 'package:first/auth/auth_provider.dart';
import 'package:first/auth/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;
import 'package:first/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:developer' as devtools show log;

class firebaseAuthProvider implements Authprovider {
  @override
  Future<void> initialize() async {
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Future<AuthUser> createuser(
      {required String email, required String password}) async {
    final c_user = user;
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (c_user == null)
        throw UsernotloggedIn();
      else
        return c_user;
    } on FirebaseAuthException catch (e) {
      flag = 1;
      devtools.log('($e.code)');
      if (e.code == 'invalid-email') {
        throw InvalidEmail();
      } else if (e.code == 'email-in-use') {
        throw EmailinUse();
      } else{
        throw GenericException();
      }
    } catch (_) {
      flag = 1;
      throw GenericException();
    }
  }

  @override
  Future<void> logout() async {
    final c_user = user;
    if (user == null) {
      throw UserNotRegistered();
    } else
      await FirebaseAuth.instance.signOut();
  }

  @override
  Future<AuthUser> signin(
      {required String email, required String password}) async {
    final c_user = user;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (c_user == null)
        throw UserNotRegistered();
      else
        return c_user;
    } on FirebaseAuthException catch (e) {
      devtools.log('($e.code)');
      flag = 1;
      if (e.code == 'wrong-password') {
        throw WrongPassword();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmail();
      } else {
        throw GenericException();
      }
    } catch (_) {
      flag = 1;
      throw GenericException();
    }
  }

  @override
  Future<void> verifyEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw UsernotloggedIn();
    } else
      await user.sendEmailVerification();
  }

  @override
  AuthUser? get user {
    final currentuser = FirebaseAuth.instance.currentUser;
    if (currentuser == null)
      return null;
    else
      return AuthUser.isverified(currentuser);
  }
}
