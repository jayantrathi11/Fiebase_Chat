import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flashchat/Components/buttons.dart';
import 'package:flashchat/constants.dart';
import 'package:flutter/cupertino.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email, password;
  final auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(
              child: CupertinoActivityIndicator(
                animating: true,
                radius: 40,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                  const SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kMessageMail,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration:
                        kMessageMail.copyWith(hintText: 'Enter Your Password'),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Buttons(
                      color: Colors.lightBlueAccent,
                      func: () async {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          final answer = await auth.signInWithEmailAndPassword(
                              email: email, password: password);
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.pushNamed(context, ChatScreen.id);
                        } catch (e) {
                          setState(() {
                            isLoading = false;
                          });
                          showCupertinoDialog<void>(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                              title: const Text('Alert'),
                              content: Text('${e}'),
                              actions: <CupertinoDialogAction>[
                                CupertinoDialogAction(
                                  child: const Text('Okay'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      str: 'Log In'),
                ],
              ),
            ),
    );
  }
}
