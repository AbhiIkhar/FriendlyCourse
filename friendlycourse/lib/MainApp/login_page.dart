// ignore_for_file: prefer_final_fields, prefer_const_constructors, sized_box_for_whitespace
import 'package:friendlycourse/MainApp/screens/home_page.dart';

import 'net/flutter_fire.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Colors.blueAccent),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: _emailField,
                  decoration: InputDecoration(
                      hintText: "email@gmail.com",
                      hintStyle: TextStyle(
                        color: Colors.white70,
                      ),
                      labelText: "Email",
                      labelStyle: TextStyle(
                        color: Colors.white,
                      )),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 35,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: _passwordField,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "password",
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      labelText: "password",
                      labelStyle: TextStyle(
                        color: Colors.white,
                      )),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 35,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.0),
                  color: Colors.white,
                ),
                child: MaterialButton(
                  onPressed: () async {
                    bool shouldNavigate =
                        await register(_emailField.text, _passwordField.text);
                    if (shouldNavigate) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage(url :"https://yotube-flutter-app.herokuapp.com/",
                                    title: 'FriendlyCourse',
                                  )));
                    } else {}
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 35,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.0),
                  color: Colors.white,
                ),
                child: MaterialButton(
                  onPressed: () async {
                    bool shouldNavigate =
                        await signIn(_emailField.text, _passwordField.text);
                    if (shouldNavigate) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage(url :"https://yotube-flutter-app.herokuapp.com/",
                                    title: 'FriendlyCourse',
                                  )));
                    } else {}
                  },
                  child: Text("Login", style: TextStyle(color: Colors.black)),
                ),
              ),
            ],
          )),
    );
  }
}
