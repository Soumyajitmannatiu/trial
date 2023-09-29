import 'package:first/auth/auth_service.dart';
import 'package:first/auth/firebase_auth_provider.dart';
import 'package:first/auth/authException.dart';
import 'package:first/views/login_view.dart';
import 'package:flutter/material.dart';

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
        appBar: AppBar(
          title: const Text("Register"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: FutureBuilder(
            future: AuthService.firebase().initialize(),
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
                            await AuthService.firebase().createuser(
                              email: _e,
                              password: _pa,
                            );
                          } on InvalidEmail {
                            await verifying(context, 'Inavalid email');
                          } on UserNotRegistered {
                            await verifying(context, 'User not registered');
                          }on GenericException{
                            await verifying(context, 'Something is wrong'); 
                          }on UsernotloggedIn{
                            await verifying(context, 'Something went wrong_2'); 
                          }
                          if (flag == 0) {
                            await AuthService.firebase().verifyEmail();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const verifyEmail()),
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
          actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
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
