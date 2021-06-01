import 'package:flutter/material.dart';
import 'package:todoapp/bloc/blocs/user_bloc_provider.dart';
import 'package:todoapp/models/classes/user.dart';
import 'package:todoapp/models/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback login;

  final bool newUser;

  const LoginPage({Key key, this.login, this.newUser}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController firstnameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGrey,
      body: Center(child: widget.newUser ? getSignupPage() : getSigninPage()),
    );
  }

  Widget getSigninPage() {
    TextEditingController usernameController = new TextEditingController();
    TextEditingController passwordController = new TextEditingController();
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Welcome! ",
            style: welcomeText,
          ),
          Container(
            height: 200,
            margin: EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Theme(
                  data: Theme.of(context)
                      .copyWith(splashColor: Colors.transparent),
                  child: TextField(
                    controller: usernameController,
                    autofocus: false,
                    style: TextStyle(fontSize: 20.0, color: darkGrey),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Username',
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.7)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.7)),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 50,
                // ),
                Theme(
                  data: Theme.of(context)
                      .copyWith(splashColor: Colors.transparent),
                  child: TextField(
                    controller: passwordController,
                    autofocus: false,
                    style: TextStyle(fontSize: 20.0, color: darkGrey),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Password',
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.7)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.7)),
                    ),
                  ),
                ),
                FlatButton(
                  child: Text("Sign In", style: blueTodoTitle),
                  onPressed: () {
                    if (usernameController.text != null ||
                        passwordController.text != null) {
                      bloc
                          .signinUser(
                              usernameController.text, passwordController.text)
                          .then(() {
                        widget.login();
                      });

                      //login(usernameController.text, passwordController.text);
                    }
                  },
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Text(
                  "Don't have an account?",
                  style: blueText,
                ),
                FlatButton(
                    onPressed: () {},
                    child: Text(
                      "Create an account",
                      style: blueBoldText,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getSignupPage() {
    return Container(
      margin: EdgeInsets.all(50),
      child: Column(
        children: [
          TextField(
              controller: emailController,
              decoration: InputDecoration(hintText: "Email")),
          TextField(
              controller: usernameController,
              decoration: InputDecoration(hintText: "Username")),
          TextField(
              controller: firstnameController,
              decoration: InputDecoration(hintText: "FirstName")),
          TextField(
              controller: passwordController,
              decoration: InputDecoration(hintText: "Password")),
          FlatButton(
            color: addButtonColor,
            onPressed: () {
              if (usernameController.text != null ||
                  passwordController.text != null ||
                  emailController.text != null) {
                bloc
                    .registerUser(
                        usernameController.text,
                        firstnameController.text ?? "",
                        "",
                        passwordController.text,
                        emailController.text)
                    .then((_) {
                  widget.login();
                });
              }
            },
            child: Text("Sign UP!"),
          )
        ],
      ),
    );
  }
}
