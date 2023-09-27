import 'package:firebase_auth/firebase_auth.dart';
import 'package:first/firebase_options.dart';
import 'package:first/views/homepage.dart';
import 'package:first/views/login_view.dart';
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
  int flag = 0;
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
        appBar: AppBar(
          title: const Text("Register"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
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
                    // ignore: sort_child_properties_last
                    child: TextButton(
                        onPressed: () async {
                          final _e = email.text;
                          final _pa = password.text;
                          try {
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: _e, password: _pa)
                                .then((userCredential) {
                              userCredential.user?.sendEmailVerification();
                            });
                          } on FirebaseAuthException catch (e) {
                            flag = 1;
                            if (e.code == 'invalid-email') {
                              await verifying(context, 'Invalid Email');
                            }
                          }
                          if (flag == 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const login_view()),
                            );
                          }
                        },
                        child: const Text("verify email")),
                    margin: EdgeInsets.all(10),
                  ),
                ],
              );
            }));
  }
}

Future verifying(BuildContext context, String b) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('$b'),
          // content: Column(
          //   children: [
          //     const Text('Plz wait till we confirm the email'),
          //     const Text(
          //         'If you have not verified plz check your email to find verification link')
          //   ],
          // ),
        );
      });
}
