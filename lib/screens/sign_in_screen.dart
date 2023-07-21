import 'package:jobby/screens/sign_up_screen.dart';

import '../layout/screen_layout.dart';
import '../resources/authentication_methods.dart';
import '../utils/utils.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthenticationMethods authenticationMethods = AuthenticationMethods();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Size screenSize = Utils().getScreenSize();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: const Text('Hello',
                      style: TextStyle(
                          fontSize: 80.0, fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                  child: const Text('There',
                      style: TextStyle(
                          fontSize: 80.0, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            Container(
                padding:
                    const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                      obscureText: true,
                    ),
                    const SizedBox(height: 5.0),
                    Container(
                      alignment: const Alignment(1.0, 0.0),
                      padding: const EdgeInsets.only(top: 15.0, left: 20.0),
                      child: const InkWell(
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    SizedBox(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.grey.shade200,
                        color: Colors.black,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });

                            String output =
                                await authenticationMethods.signInUser(
                                    email: emailController.text,
                                    password: passwordController.text);
                            setState(() {
                              isLoading = false;
                            });
                            if (output == "success") {
                              //functions
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return const ScreenLayout();
                              }));
                            } else {
                              //error
                              Utils().showSnackBar(
                                  context: context, content: output);
                            }
                          },
                          child: const Center(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      height: 40.0,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1.0),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Center(
                                // child:
                                // ImageIcon(AssetImage('assets/facebook.png')),
                                ),
                            SizedBox(width: 10.0),
                            Center(
                              child: Text('Log in with facebook',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat')),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )),
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'New to Jobby ?',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                const SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return const SignUpScreen();
                    }));
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
