// ignore_for_file: unused_import

import 'package:jobby/screens/sign_in_screen.dart';

import '../model/product_model.dart';
import '../model/user_details_model.dart';
import '../providers/user_details_provider.dart';
import '../resources/authentication_methods.dart';
import '../resources/cloudfirestore_methods.dart';
import '../utils/color_themes.dart';
import '../utils/constants.dart';
import '../utils/utils.dart';
import '../widgets/custom_main_button.dart';
import '../widgets/loading_widget.dart';
import '../widgets/products_showcase_list_view.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/simple_product_widget.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthenticationMethods authenticationMethods = AuthenticationMethods();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                child: const Text(
                  'Signup',
                  style: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(260.0, 125.0, 0.0, 0.0),
                child: const Text(
                  '.',
                  style: TextStyle(
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              )
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
                        // hintText: 'EMAIL',
                        // hintStyle: ,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                  const SizedBox(height: 10.0),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                        labelText: 'PASSWORD ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                    obscureText: true,
                  ),
                  const SizedBox(height: 10.0),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        labelText: 'NICK NAME ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                  const SizedBox(height: 50.0),
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
                                await authenticationMethods.signUpUser(
                                    name: nameController.text,
                                    // address: addressController.text,
                                    email: emailController.text,
                                    password: passwordController.text);
                            setState(() {
                              isLoading = false;
                            });
                            if (output == "success") {
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const SignInScreen()));
                            } else {
                              //error
                              Utils().showSnackBar(
                                  context: context, content: output);
                            }
                          },
                          child: const Center(
                            child: Text(
                              'SIGNUP',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      )),
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
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return const SignInScreen();
                          }));
                        },
                        child: const Center(
                          child: Text('Go Back',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat')),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ]));
  }
}
