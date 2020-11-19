import 'dart:io';

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_chat_app/src/resources/services/auth_service.dart';
import 'package:the_chat_app/src/resources/services/firestore_service.dart';
import 'package:the_chat_app/src/ui/main_screen.dart';
import 'package:the_chat_app/src/ui/widgets/alertComponent.dart';
import 'package:the_chat_app/src/ui/widgets/customTextField.dart';
import 'package:the_chat_app/src/resources/utilities/constants.dart';

enum AuthMode { LOGIN, SIGNUP }

String removeSpaces(String email) => email.replaceAll(' ', '');

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // To adjust the layout according to the screen size
  // so that our layout remains responsive ,we need to
  // calculate the screen height
  double screenHeight;

  // Set initial mode to login
  AuthMode _authMode = AuthMode.LOGIN;

  // Data Attributes
  String email;
  String password;
  String displayName;
  String _uid;
  bool _showSpinner = false;

  Auth _auth = Auth();
  FirestoreService _firestoreService = FirestoreService();
  User _fbuser;

  @override
  initState() {
    super.initState();
    getDeviceToken();
    if (Platform.isIOS) {
      //check for ios if developing for both android & ios
      AppleSignIn.onCredentialRevoked.listen((_) {
        print("Credentials revoked");
      });
    }
  }

  void getDeviceToken() async {
    final token = await _firestoreService.getDeviceToken();
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;

    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              //lowerHalf(context),
              backgroundPage(context),
              _authMode == AuthMode.LOGIN
                  ? loginCard(context)
                  : signUpCard(context),
              pageTitle(),
            ],
          ),
        ),
      ),
    );
  }

  Widget pageTitle() {
    return Container(
      margin: EdgeInsets.only(top: 86),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.mark_chat_unread_outlined,
            size: 50,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              '\t\tThe Chat App',
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  Widget loginCard(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenHeight / 4),
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            elevation: 12,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: kOrangeColor,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    placeholder: 'Email',
                    onChanged: (value) {
                      this.email = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    placeholder: "Password",
                    isPassword: true,
                    onChanged: (value) {
                      this.password = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      /*MaterialButton(
                        onPressed: () {},
                        child: Text("Forgot Password ?"),
                      ),*/
                      Expanded(
                        child: Container(),
                      ),
                      FlatButton(
                        child: Text("Login"),
                        color: kRedColor,
                        textColor: Colors.white,
                        padding: EdgeInsets.only(
                            left: 38, right: 38, top: 15, bottom: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () async {
                          /*Navigator.pushReplacementNamed(
                              context, MainScreen.id);*/
                          setState(() {
                            _showSpinner = true;
                          });
                          try {
                            // store email in shared prefs
                            final SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            await pref.setString(
                                'email', removeSpaces(this.email));
                            // login
                            await _auth.loginUserWithEmailAndPassword(
                                email: removeSpaces(this.email),
                                password: this.password);
                            await _firestoreService.postToken();
                            //await _decideRoute();
                            Navigator.pushReplacementNamed(
                                context, MainScreen.id);
                          } catch (e) {
                            AlertComponent()
                                .generateAlert(
                                    context: context,
                                    title: "Invalid Credentials",
                                    description: e.toString())
                                .show();
                            print(e);
                          }
                          setState(() {
                            _showSpinner = false;
                          });
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              "Don't have an account ?",
              style: TextStyle(color: Colors.white),
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  _authMode = AuthMode.SIGNUP;
                });
              },
              textColor: Colors.white,
              child: Text("Create Account",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: SizedBox(
            height: 60,
            width: double.maxFinite,
            child: SignInButton(
              Buttons.Google,
              text: 'Sign in using Google',
              onPressed: () async {
                try {
                  await _auth.signInWithG();
                  _fbuser = await _auth.getCurrentUser();
                  _uid = _fbuser.uid;
                  final SharedPreferences pref =
                      await SharedPreferences.getInstance();

                  await pref.setString('uid', _uid);
                  await pref.setString('email', _fbuser.email);
                  await pref.setString('displayName', _fbuser.displayName);

                  await _firestoreService.postToken();

                  Navigator.pushReplacementNamed(context, MainScreen.id);
                } catch (e) {
                  AlertComponent()
                      .generateAlert(
                          context: context,
                          title: "Invalid Credentials",
                          description: e.toString())
                      .show();
                  print(e);
                }
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: SizedBox(
            height: 60,
            width: double.maxFinite,
            child: SignInButton(
              Buttons.Apple,
              text: 'Sign in using Apple',
              onPressed: () async {
                if (await AppleSignIn.isAvailable()) {
                  final AuthorizationResult result = await
                  AppleSignIn.performRequests([
                    AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
                  ]);
                  switch (result.status) {

                    case AuthorizationStatus.authorized:
                      print(result.credential.user);
                      await _firestoreService.postToken();
                      await _firestoreService.registerUser(
                          email: result.credential.email,
                          displayName: result.credential.fullName.toString());
                      Navigator.pushReplacementNamed(context, MainScreen.id);
                      break;

                    case AuthorizationStatus.error:
                      AlertComponent()
                          .generateAlert(
                          context: context,
                          title: "Error",
                          description: 'Apple Sign-In Error')
                          .show();
                      break;

                    case AuthorizationStatus.cancelled:
                      print('User cancelled');
                      break;

                  }
                } else {
                  AlertComponent()
                      .generateAlert(
                          context: context,
                          title: "Error",
                          description:
                              'Apple Sign-In not supported on this device!')
                      .show();
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget signUpCard(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenHeight / 5),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            elevation: 12,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Create Account",
                      style: TextStyle(
                        color: kOrangeColor,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    placeholder: 'Your Name',
                    onChanged: (value) {
                      this.displayName = value;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    placeholder: 'Your Email',
                    onChanged: (value) {
                      this.email = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    placeholder: 'Your Password',
                    isPassword: true,
                    onChanged: (value) {
                      this.password = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Password must be at least 8 characters and include a special character and number",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                        child: FlatButton(
                          child: Text("Sign Up"),
                          color: kOrangeColor,
                          textColor: Colors.white,
                          padding: EdgeInsets.only(
                              left: 38, right: 38, top: 15, bottom: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: () async {
                            setState(() {
                              _showSpinner = true;
                            });
                            try {
                              //final fixedEmail = removeSpaces(this.email);
                              await _auth.registerUser(
                                  email: removeSpaces(this.email),
                                  password: this.password);
                              /*await _auth.updateUserInfo(
                                  displayName: this.displayName);*/
                              await _firestoreService.registerUser(
                                  email: removeSpaces(this.email),
                                  displayName: this.displayName);
                              await _firestoreService.postToken();
                              Navigator.pushReplacementNamed(
                                  context, MainScreen.id);
                            } catch (e) {
                              AlertComponent()
                                  .generateAlert(
                                      context: context,
                                      title: "Error",
                                      description: e)
                                  .show();
                              print(e);
                            }
                            setState(() {
                              _showSpinner = false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              "Already have an account?",
              style: TextStyle(color: Colors.white),
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  _authMode = AuthMode.LOGIN;
                });
              },
              textColor: Colors.white,
              child: Text(
                "Login",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: FlatButton(
            child: Text(
              "Terms & Conditions",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget backgroundPage(BuildContext context) {
    return Container(
      height: screenHeight,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [kRedColor, kOrangeColor],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter)),
    );
  }

  /*Widget lowerHalf(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: screenHeight / 2,
        color: Color(0xFFECF0F3),
      ),
    );
  }*/
}
