import 'package:first/firebase_options.dart';
import 'dart:developer' as devtools show log;
import 'package:first/views/homepage.dart';
import 'package:first/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

late TextEditingController email;
late TextEditingController password;

class login_view extends StatefulWidget {
  const login_view({super.key});

  @override
  State<login_view> createState() => _login_viewState();
}

class _login_viewState extends State<login_view> {
  int flag = 0;
  get child => null;

  get devtools => null;
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
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("login"),
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
                        child: const Text("login"),
                        onPressed: () async {
                          final _e = email.text;
                          final _pa = password.text;
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: _e, password: _pa);
                          } on FirebaseAuthException catch (e) {
                            flag = 1;
                            await verifying(context, '$e.code');
                          }
                          final user = FirebaseAuth.instance.currentUser;
                          switch (snapshot.connectionState) {
                            case ConnectionState.done:
                              if (flag == 0) {
                                if (user?.emailVerified ?? false) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => home_screen()),
                                      (route) => false);
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => verifyEmail()));
                                }
                              }
                              break;
                            default:
                          }
                        }),
                    margin: EdgeInsets.all(10),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => register_view()));
                      },
                      child:
                          const Text("Don't have an Account, get registered"))
                ],
              );
            }));
  }
}

class verifyEmail extends StatefulWidget {
  const verifyEmail({super.key});

  @override
  State<verifyEmail> createState() => _verifyEmailState();
}

class _verifyEmailState extends State<verifyEmail> {
  @override
  Widget build(BuildContext context) {
    final em = email.text;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: Text(
                  'Email($em) not veirfied yet plz check your email and click on the link for verification when done log in again to enter the account',
                  style: const TextStyle(fontSize: 20),
                ),
                margin: EdgeInsets.all(30)),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Log in after email verification')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => register_view()));
                },
                child: Text('Wrong email, Register again'))
          ],
        ),
      ),
    );
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
