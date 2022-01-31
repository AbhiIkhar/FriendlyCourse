// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';

import '../../main.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          new Padding(padding: const EdgeInsets.only(top: 20.0)),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text(
              "Home",
              style: TextStyle(fontSize: 22),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          new Divider(),
          ListTile(
            leading: IconButton(
                icon: Icon(MyApp.themeNotifier.value == ThemeMode.light
                    ? Icons.dark_mode
                    : Icons.light_mode),
                onPressed: () {
                  MyApp.themeNotifier.value =
                      MyApp.themeNotifier.value == ThemeMode.light
                          ? ThemeMode.dark
                          : ThemeMode.light;
                }),
            title: const Text(
              "Theme Setting",
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
