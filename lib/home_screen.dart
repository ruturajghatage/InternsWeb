import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intern_web/login_page.dart';
import 'package:intern_web/registration_screen.dart';
import 'components/buttonWidget.dart';

class HomeScreen extends StatelessWidget {
  static String id = 'home_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 34, right: 34, bottom: 34, top: 55),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Interns Web',
              style: TextStyle(fontSize: 30.0),
            ),
            SizedBox(
              height: 70.0,
            ),
            Image(image: AssetImage('images/logo1.jpg')),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Get Your Dream Internship and a lot more',
              style: TextStyle(fontSize: 30.0),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonWidget(
                      widthLen: 150.0,
                      onpressed: () {
                        Navigator.pushNamed(context, RegistrationScreen.id);
                      },
                      name: Text(
                        'Register',
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                      colourName: Colors.white,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    ButtonWidget(
                      widthLen: 150.0,
                      onpressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage(false)));
                      },
                      name: Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      colourName: Colors.black54,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
