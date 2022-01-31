// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:friendlycourse/MainApp/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'FriendlyCourse',
            theme: ThemeData(
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData.dark(),
            themeMode: currentMode,
            home: Authenticate(),
          );
        });
  }
}
