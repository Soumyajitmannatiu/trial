
import 'package:first/views/login_view.dart';
import 'package:first/views/register_view.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(MaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const Homepage(),
  ));
}

// class checkConnection extends StatefulWidget {
//   const checkConnection({super.key});

//   @override
//   State<checkConnection> createState() => _checkConnectionState();
// }

// class _checkConnectionState extends State<checkConnection> {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: Firebase.initializeApp(
//           options: DefaultFirebaseOptions.currentPlatform,
//         ),
//         builder: (context, snapshot) {
//           List<Widget> bruv;
//           final user = FirebaseAuth.instance.currentUser;
//           if (snapshot.connectionState case ConnectionState.done) {
//             if (user?.emailVerified ?? false) {
//               return home_screen();
//               // Navigator.pushAndRemoveUntil(
//               //     context,
//               //     MaterialPageRoute(
//               //         builder: (context) => home_screen()),(route)=>false);
//             }
//           } else {
//             return Homepage();
//           }
//         });
//   }
// }

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('BASIC REGISTRATION'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const register_view()),
                    );
                  },
                  child: const Text(
                    'New User? ,Get Registered',
                    style: TextStyle(fontSize: 25),
                  )),
                  margin: EdgeInsets.all(15),
            ),
            Container(
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const login_view()),
                    );
                  },
                  child: const Text(
                    'Already have an account ,Log in',
                    style: TextStyle(fontSize: 25),
                  )),
                  margin: EdgeInsets.all(15),
            )
          ],
        )));
  }
}
