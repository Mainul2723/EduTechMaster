// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edutechmaster/screens/dashboard.dart';
import 'package:edutechmaster/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controller/main_controller.dart';
import 'main_view.dart';

class Login extends StatefulWidget {
  const Login({super.key});


  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool passwordVisible = false;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _isLoading = false;
  bool _isObscure = true;

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      setState(() {
        _isLoading = true;
      });
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passController.text);
      // email: _emailController.text, password: _passController.text);
      String uid = userCredential.user!.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

      // Access the user's name
      String name = userDoc['username'];
      String imageUrl = userDoc['profileImageUrl'].toString();

      Get.off(() => DashBoard(name: name,email: _emailController.text,imageUrl: imageUrl,));

      print("Sign in successful!");
    } catch (error) {
      print("Error during sign-in: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 15),
              child: Image.asset(
                'assets/vector-1.png',
                width: 313,
                height: 357,
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Column(
                children: [
                  Text(
                    'Login',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF755DC1),
                      fontSize: 27,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextField(
                    focusNode: _emailFocusNode,
                    controller: _emailController,
                    //textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF393939),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: GoogleFonts.poppins(
                        color: const Color(0xFF755DC1),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Color(0xFF837E93),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Color(0xFF9F7BFF),
                        ),
                      ),
                    ),
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(_emailFocusNode);
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    focusNode: _passwordFocusNode,
                    controller: _passController,
                    obscureText: _isObscure, // Use the variable to dynamically set obscureText
                    style: const TextStyle(
                      color: Color(0xFF393939),
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(
                        color: Color(0xFF755DC1),
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Color(0xFF837E93),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Color(0xFF9F7BFF),
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          // Toggle the visibility of the password
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                    ),
                    onEditingComplete: () {
                      // Handle the completion of editing, e.g., login
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: SizedBox(
                      width: 329,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _signInWithEmailAndPassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _isLoading ? Colors.grey : const Color.fromARGB(255, 101, 68, 192),
                        ),
                        child: _isLoading ? LoadingAnimationWidget.fourRotatingDots(color: Colors.white,
                          size: 50,) : const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          // Handle the button tap, e.g., navigate to the sign-up screen
                          Get.to(() => SignUpScreen());
                        },
                        child: Text(
                          'Don\'t have an account?',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF837E93),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 2.5,
                      ),

                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () async {
                      String email = _emailController.text.trim();

                      try {
                        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                        // Password reset email sent successfully
                        print('Reset password link sent to: $email');
                        // You might want to display a success message to the user
                      } catch (e) {
                        // An error occurred. Handle the error, e.g., display an error message

                        showDialog(
                          context: context,
                          builder: ( context) {
                            return AlertDialog(
                              title: const Text('Sorry'),
                              content: const Text('Failed to send reset password link. Please Input your email and try again.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text(
                      'Forget Password?',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF755DC1),
                        fontSize: 13,

                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
