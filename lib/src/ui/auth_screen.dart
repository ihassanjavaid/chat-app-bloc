import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:the_chat_app/src/blocs/auth_bloc/auth_bloc.dart';
import 'package:the_chat_app/src/resources/auth_repository.dart';
import 'package:the_chat_app/src/ui/main_screen.dart';
import 'package:the_chat_app/src/ui/widgets/alertComponent.dart';
import 'package:the_chat_app/src/ui/widgets/customTextField.dart';
import 'package:the_chat_app/src/resources/utilities/constants.dart';

class AuthScreen extends StatelessWidget {
  static const String id = 'auth_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<AuthBloc, AuthState>(
          builder: (_, state) {
            if (state is AuthInitial) {
              context.read<AuthBloc>().add(InitializeAuth());
            } else if (state is AuthSuccess) {
              Navigator.pushReplacementNamed(context, MainScreen.id);
            } else if (state is AuthLoading) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is AuthRegister) {
              return Stack(
                children: [
                  backgroundPage(context),
                  signUpCard(context),
                  pageTitle(),
                ],
              );
            } else if (state is AuthFailed) {
              AlertComponent()
                  .generateAlert(
                    context: context,
                    title: "Failed to authenticate",
                    description: state.failMessage,
                  )
                  .show();
            }
            return Stack(
              children: [
                backgroundPage(context),
                loginCard(context),
                pageTitle(),
              ],
            );
          },
          listener: (_, authState) {},
        ),
      ),
    );
  }

  Widget backgroundPage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [kRedColor, kOrangeColor],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter),
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
    // ignore: close_sinks
    AuthBloc authBloc = context.read<AuthBloc>();

    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
          padding: EdgeInsets.only(
            left: 5,
            right: 5,
          ),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              elevation: 12,
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
                      authBloc.add(CredentialsEntryEvent(
                          value, CredentialType.Username));
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    placeholder: "Password",
                    isPassword: true,
                    onChanged: (value) {
                      authBloc.add(CredentialsEntryEvent(
                          value, CredentialType.Password));
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {},
                        child: Text("Forgot Password ?"),
                      ),
                      Spacer(),
                      FlatButton(
                        child: Text("Login"),
                        color: kRedColor,
                        textColor: Colors.white,
                        padding: EdgeInsets.only(
                            left: 38, right: 38, top: 15, bottom: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () {
                          authBloc.add(AuthenticateEvent(AuthType.LOGIN));
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
                authBloc.add(ShowRegisterationEvent());
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
              onPressed: () {
                authBloc.add(AuthenticateEvent(AuthType.GLogin));
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
              onPressed: () {
                authBloc.add(AuthenticateEvent(AuthType.AppleLogin));
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget signUpCard(BuildContext context) {
    // ignore: close_sinks
    AuthBloc authBloc = context.read<AuthBloc>();

    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
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
                    placeholder: 'First Name',
                    onChanged: (value) {
                      authBloc.add(RegistrationDataEntry(value, 'first_name'));
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    placeholder: 'Last Name',
                    onChanged: (value) {
                      authBloc.add(RegistrationDataEntry(value, 'last_name'));
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    placeholder: 'Your Email',
                    onChanged: (value) {
                      authBloc.add(RegistrationDataEntry(value, 'email'));
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    placeholder: 'Your Password',
                    isPassword: true,
                    onChanged: (value) {
                      authBloc.add(CredentialsEntryEvent(
                          value, CredentialType.Password));
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
                            authBloc.add(AuthenticateEvent(AuthType.SIGNUP));
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
                authBloc.add(ShowLoginEvent());
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
            onPressed: () {
              // TODO: Add functionality
            },
          ),
        ),
      ],
    );
  }
}
