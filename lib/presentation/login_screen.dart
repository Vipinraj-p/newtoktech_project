import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newtoktech_project/presentation/admin/admin_home_screen.dart';
import 'package:newtoktech_project/presentation/user/user_home_screen.dart';

import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                  TextFormField(
                    style: GoogleFonts.ubuntuMono(
                        color: Colors.white, fontSize: 15),
                    enabled: true,
                    controller: emailController,
                    decoration: InputDecoration(
                        enabled: true,
                        labelText: 'User Name',
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
                    },
                    onSaved: (value) {
                      emailController.text = value!;
                    },
                  ),
                  SizedBox(height: size.height * 0.05),
                  TextFormField(
                    style: GoogleFonts.ubuntuMono(
                        color: Colors.white, fontSize: 15),
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
                    onSaved: (value) {
                      passwordController.text = value!;
                    },
                  ),
                  SizedBox(height: size.height * 0.05),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          signIn(context, emailController.text,
                              passwordController.text);

                          // FirebaseAuth.instance
                          //     .signInWithEmailAndPassword(
                          //         email: emailController.text,
                          //         password: passwordController.text)
                          //     .then(
                          //   (value) {
                          //     // Navigator.push(
                          //     //     context,
                          //     //     MaterialPageRoute(
                          //     //       builder: (context) => const HomeScreen(),
                          //     //     )
                          //     //     );
                          //   },
                          // ).onError(
                          //   (error, stackTrace) {
                          //     log('Error : ${error.toString()}');
                          //     showDialog(
                          //       context: context,
                          //       builder: (context) {
                          //         return AlertDialog(
                          //           content: Text(
                          //               'Wrong input\nError:${error.toString()}'),
                          //         );
                          //       },
                          //     );
                          //   },
                          // );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 75, 77, 105),
                            shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            fixedSize: const Size(double.infinity, 50)),
                        child: Text(
                          'Sign In ',
                          style: GoogleFonts.ubuntu(
                              color: Colors.white, fontSize: 18),
                        )),
                  ),
                  SizedBox(height: size.height * 0.08),
                  SizedBox(
                      width: size.width * 0.7,
                      child: const Divider(
                        color: Color.fromARGB(255, 163, 163, 163),
                      )),
                  SizedBox(height: size.height * 0.025),
                  RichText(
                      text: TextSpan(
                          style: GoogleFonts.ubuntu(
                              color: const Color.fromARGB(255, 185, 187, 189),
                              fontSize: 14),
                          children: [
                        const TextSpan(text: 'Don\'t have an account ?'),
                        TextSpan(
                            text: ' Register Now ',
                            style: TextStyle(
                                color: Colors.blue[700], fontSize: 15),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                const CircularProgressIndicator();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignupScreen(),
                                    ));
                                log('Sign Up', name: 'SignUp');
                              }),
                      ]))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void route(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapShot) {
      if (documentSnapShot.exists) {
        if (documentSnapShot.get('loginAs') == "Admin") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AdminHomeScreen(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UserHomeScreen(),
            ),
          );
        }
      } else {
        log("Document Doese not Exist..");
      }
    });
  }

  void signIn(BuildContext context, String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        route(context);
      } on FirebaseAuthException catch (e) {
        if (e.code == "user-not-found") {
          log('No User Found', name: "FireBase");
        } else if (e.code == "wrong-password") {
          log("Wrong Password", name: "Firebase");
        }
      }
    }
  }
}
