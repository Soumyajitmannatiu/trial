import 'package:firebase_auth/firebase_auth.dart' show User;

class AuthUser
{ 
  bool isEmailVerified;
  
  AuthUser(this.isEmailVerified);

  factory AuthUser.isverified(User user)=>AuthUser(user.emailVerified);
  
}