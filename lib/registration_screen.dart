import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intern_web/components/buttonWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intern_web/login_page.dart';
import 'package:intern_web/main_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final _firestore = FirebaseFirestore.instance.collection('users');

const storage = FlutterSecureStorage();

class RegistrationScreen extends StatelessWidget {
  static String id = 'registration_screen';

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    String password = '';
    String email = '';
    String errorText = 'Error';
    String name = '';

    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 34, right: 34, top: 55),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: Icon(Icons.arrow_back),
                onTap: () => Navigator.pop(context),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                'Create\nAccount',
                style: TextStyle(fontSize: 40.0),
              ),
              SizedBox(
                height: 35.0,
              ),
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.account_box_rounded),
                  hintText: 'Name',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  name = value;
                },
              ),
              SizedBox(
                height: 15.0,
                width: double.infinity,
                child: Divider(
                  color: Colors.black,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.mail),
                  hintText: 'Email',
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
              ),
              SizedBox(
                height: 15.0,
                width: double.infinity,
                child: Divider(
                  color: Colors.black,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Password',
                  icon: Icon(Icons.lock),
                ),
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(
                height: 15.0,
                width: double.infinity,
                child: Divider(
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              ButtonWidget(
                widthLen: double.infinity,
                onpressed: () async {
                  try {
                    await storage.write(key: 'employee', value: 'true');

                    final user = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);

                    if (user != null) {
                      print('Success');

                      DocumentReference doc = _firestore.doc();

                      doc.set({
                        'email': email,
                        'name': name,
                        'uid': user.user?.uid,
                      });

                      Navigator.pushNamed(context, MainScreen.id);
                    }
                  } catch (e) {
                    print('Error');
                    print(e);

                    if (e.toString() ==
                        '[firebase_auth/weak-password] Password should be at least 6 characters') {
                      errorText = 'Password should be at least 6 characters';
                    } else if (e.toString() ==
                        '[firebase_auth/invalid-email] The email address is badly formatted.') {
                      errorText = 'Invalid Email Address';
                    } else if (e.toString() ==
                        '[firebase_auth/unknown] Given String is empty or null') {
                      errorText = 'Fields are blank';
                    } else if (e.toString() ==
                        '[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
                      errorText = 'Email Already in use';
                    } else {
                      errorText = 'Error';
                    }

                    Alert(
                        context: context,
                        title: 'Error',
                        desc: errorText,
                        buttons: [
                          DialogButton(
                            child: Text(
                              'Cool',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () => Navigator.pop(context),
                            color: Colors.deepOrangeAccent,
                          ),
                        ]).show();
                  }
                },
                name: Text('Sign Up'),
                colourName: Colors.teal,
              ),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 15.0,
                width: double.infinity,
                child: Divider(
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ButtonWidget(
                widthLen: double.infinity,
                onpressed: () {
                  Navigator.pushNamed(context, LoginPage.id);
                },
                name: Text('Log In'),
                colourName: Colors.red,
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
