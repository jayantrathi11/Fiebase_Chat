import 'login_screen.dart';
import 'package:flashchat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flashchat/Components/buttons.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'WelcomeScreen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    animation = ColorTween(begin: Colors.lightBlue, end: Colors.white)
        .animate(controller);

    controller.forward(from: 0.3);
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 75,
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextLiquidFill(
                    loadDuration: Duration(seconds: 3),
                    text: 'Flash Chat',
                    waveColor: Colors.black,
                    boxBackgroundColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                    ),
                    boxHeight: 200,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Buttons(
              str: 'Log In',
              color: Colors.lightBlueAccent,
              func: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            Buttons(
                color: Colors.blueAccent,
                func: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                str: 'Register'),
          ],
        ),
      ),
    );
  }
}
