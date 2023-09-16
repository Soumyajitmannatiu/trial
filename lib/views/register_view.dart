import 'package:firebase_auth/firebase_auth.dart';
import 'package:first/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
class register_view extends StatefulWidget {
  const register_view({super.key});

  @override
  State<register_view> createState() => _register_viewState();
}

class _register_viewState extends State<register_view> {
  late TextEditingController email;
  late TextEditingController password;
  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Register")),
        body: FutureBuilder(
            future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform,
            ),
            builder: (context, snapshot) {
              return Column(
                children: [
                  Container(
                      child: TextField(
                          controller: email,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            hintText: 'Enter email',
                          )),
                      margin: EdgeInsets.all(17),
                      width: 400,
                      height: 30),
                  Center(
                    child: Container(
                        child: TextField(
                            controller: password,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: const InputDecoration(
                              hintText: 'Enter password',
                            )),
                        margin: EdgeInsets.all(17),
                        width: 400,
                        height: 30),
                  ),
                  Container(
                    child: TextButton(
                        child: const Text("Register"),
                        onPressed: () async {
                          final _e = email.text;
                          final _pa = password.text;
                          try {
                            final UserCredential = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: _e, password: _pa);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'invalid-email')
                              print('The email address is badly formatted.');
                            else if (e.code == 'email-already-in-use')
                              print(
                                  'The email address is already in use by another account.');
                          }
                        }),
                    margin: EdgeInsets.all(10),
                  ),
                ],
              );
            }));
  }
}



