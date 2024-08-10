import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newtoktech_project/services/signup_screen_provider.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cnfPasswordController = TextEditingController();

  // String _currentItemSelected = "User";
  // String loginAs = "User";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<SignupScreenProvider>(builder:
        (BuildContext context, SignupScreenProvider value, Widget? child) {
      return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          height: size.height,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formkey,
              child: Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.2,
                    left: size.width * 0.05,
                    right: size.width * 0.05),
                child: Column(
                  children: [
                    // Text Form Field for Email Address
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style: GoogleFonts.ubuntuMono(
                            color: Colors.white, fontSize: 14),
                        enabled: true,
                        controller: emailController,
                        decoration: InputDecoration(
                            enabled: true,
                            labelText: 'email address',
                            floatingLabelStyle: GoogleFonts.ubuntu(
                              color: const Color.fromARGB(255, 226, 228, 230),
                            ),
                            labelStyle: GoogleFonts.ubuntu(
                              color: const Color.fromARGB(255, 226, 228, 230),
                            ),
                            prefixIcon: const Icon(
                              Icons.person_outline_rounded,
                              color: Color.fromARGB(255, 226, 228, 230),
                              size: 25,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email cannot be empty";
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Please enter a valid email");
                          } else {
                            return null;
                          }
                        }),
                    // Text Form Field for PASSWORD
                    SizedBox(height: size.height * 0.05),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      style: GoogleFonts.ubuntuMono(
                          color: Colors.white, fontSize: 14),
                      enabled: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                          enabled: false,
                          labelText: 'Password',
                          floatingLabelStyle: GoogleFonts.ubuntu(
                            color: const Color.fromARGB(255, 226, 228, 230),
                          ),
                          labelStyle: GoogleFonts.ubuntu(
                            color: const Color.fromARGB(255, 226, 228, 230),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                            color: Color.fromARGB(255, 226, 228, 230),
                            size: 25,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                      validator: (value) {
                        RegExp regex = RegExp(r'^.{6,}$');
                        if (value!.isEmpty) {
                          return "Password cannot be empty";
                        }
                        if (!regex.hasMatch(value)) {
                          return ("please enter valid password min. 6 character");
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: size.height * 0.05),

                    // Text Form Field for Confirm PASSWORD
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      style: GoogleFonts.ubuntuMono(
                          color: Colors.white, fontSize: 14),
                      enabled: true,
                      controller: cnfPasswordController,
                      decoration: InputDecoration(
                          enabled: false,
                          labelText: 'confirm Password',
                          floatingLabelStyle: GoogleFonts.ubuntu(
                            color: const Color.fromARGB(255, 226, 228, 230),
                          ),
                          labelStyle: GoogleFonts.ubuntu(
                            color: const Color.fromARGB(255, 226, 228, 230),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                            color: Color.fromARGB(255, 226, 228, 230),
                            size: 25,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                      validator: (value) {
                        if (cnfPasswordController.text !=
                            passwordController.text) {
                          return "Password did not match";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: size.height * 0.05),

                    //Drop Down Menu Button For Selecting The Role
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "login as : ",
                          style: GoogleFonts.ubuntu(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        DropdownButton<String>(
                          dropdownColor: const Color.fromARGB(255, 46, 21, 102),
                          isDense: true,
                          isExpanded: false,
                          iconEnabledColor: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                          focusColor: Colors.white,
                          items: value.options.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(
                                dropDownStringItem,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValueSelected) {
                            value.dropdownchange(newValueSelected);
                          },
                          value: value.currentItemSelected,
                        )
                      ],
                    ),

                    SizedBox(height: size.height * 0.05),

                    //Elevated Button to SIGN UP
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            // CircularProgressIndicator();
                            log(emailController.text,
                                name: "emailController.text");
                            log(passwordController.text,
                                name: "passwordController.text");
                            log(value.loginAs, name: "loginAs");
                            signUp(_scaffoldKey, context, emailController.text,
                                passwordController.text, value.loginAs);

                            // if (passwordController.text ==
                            //     cnfPasswordController.text) {
                            //   log("ElevatedButt :${emailController.text}");
                            //   FirebaseAuth.instance
                            //       .createUserWithEmailAndPassword(
                            //           email: emailController.text,
                            //           password: passwordController.text)
                            //       .then(
                            //     (value) {
                            //       // log('Created new account');
                            //       // Navigator.push(
                            //       //     context,
                            //       //     MaterialPageRoute(
                            //       //       builder: (context) => const HomeScreen(),
                            //       //     ));
                            //     },
                            //   ).onError(
                            //     (error, stackTrace) {
                            //       log("error : ${error.toString()}");
                            //       showDialog(
                            //         context: context,
                            //         builder: (context) {
                            //           return AlertDialog(
                            //             content: Text(
                            //                 'Wrong input\nError:${error.toString()}'),
                            //           );
                            //         },
                            //       );
                            //     },
                            //   );

                            // }
                            //elevated
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 75, 77, 105),
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              fixedSize: const Size(double.infinity, 50)),
                          child: Text(
                            'Sign Up ',
                            style: GoogleFonts.ubuntu(
                                color: Colors.white, fontSize: 18),
                          )),
                    ),
                    SizedBox(height: size.height * 0.1),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    SizedBox(
                      width: size.width * 0.7,
                      child: const Divider(
                        color: Color.fromARGB(255, 163, 163, 163),
                      ),
                    ),
                    //     Text(
                    //       'Or Continue with',
                    //       style: GoogleFonts.ubuntu(
                    //         color: Colors.black,
                    //         fontSize: 18,
                    //       ),
                    //     ),
                    //     SizedBox(
                    //         width: size.width * 0.25,
                    //         child: const Divider(
                    //           color: Colors.black,
                    //         )),
                    //   ],
                    // ),
                    SizedBox(height: size.height * 0.025),
                    //Login Screen Navigation Section
                    SizedBox(height: size.height * 0.02),
                    RichText(
                        text: TextSpan(
                            style: GoogleFonts.ubuntu(
                                color: const Color.fromARGB(255, 163, 163, 163),
                                fontSize: 14),
                            children: [
                          const TextSpan(text: 'Already have an account ?'),
                          TextSpan(
                              text: ' Login ',
                              style: TextStyle(
                                  color: Colors.blue[700], fontSize: 15),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  const CircularProgressIndicator();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ));
                                  log('login', name: 'login');
                                }),
                        ]))
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  void signUp(var scaffoldKey, BuildContext context, String email,
      String password, String loginAs) async {
    const CircularProgressIndicator();
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) =>
              {postDetailsToFirestore(scaffoldKey, context, email, loginAs)})
          .catchError((e) {
        return scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(e),
          duration: const Duration(seconds: 3),
        ));
      });
    }
  }

  postDetailsToFirestore(var scaffoldKey, BuildContext context, String email,
      String loginAs) async {
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(user!.uid).set({'email': emailController.text, 'loginAs': loginAs});
    // scaffoldKey.currentState
    //   .showSnackBar(const SnackBar(
    //     content: Text("Account Created"),
    //     duration: Duration(seconds: 3),
    //   ))
    //   .then((value) => Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => LoginScreen())));
  }
}
