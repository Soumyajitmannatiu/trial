import 'package:first/auth/auth_service.dart';
import 'package:first/views/login_view.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

enum MenuAction { logout }

class _home_screenState extends State<home_screen> {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("welcome!"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final data = await showLogoutDialog(context);
                  devtools.log(data.toString());
                  if (data) {
                    await AuthService.firebase().logout();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const login_view()),
                        (_) => false);
                  }
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                    value: MenuAction.logout, child: const Text('log out'))
              ];
            },
          )
          // IconButton(onPressed: () {}, icon: const Icon(Icons.logout))
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return Container(
              height: 50,
              color: Colors.amber[colorCodes[index]],
              child: Text('Note ${entries[index]}'));
        },
      ),
    );
  }
}

Future<bool> showLogoutDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sign out'),
          content: const Text('sure you want to log out'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('log out')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('cancel'))
          ],
        );
      }).then((value) => value ?? false);
}
