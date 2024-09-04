// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myapp/auth/error.dart';
import 'package:myapp/comoponents/customtextformfieldadd.dart';
import 'package:myapp/comoponents/iconapp.dart';
import 'package:myapp/comoponents/loginboutton.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool isloading = false;

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return; //هتوقف كل ال بعد الفانكشن دي
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushNamedAndRemoveUntil("homepage", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE2DAD6),
      body: isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.all(20),
              child: ListView(
                children: [
                  Form(
                    key: formState,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 60,
                        ),
                        CustomIcon(),
                        Container(
                          height: 10,
                        ),
                        Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text("Login To Continue Using This App",
                            style: TextStyle(
                              color: Colors.grey,
                            )),
                        Container(
                          height: 10,
                        ),
                        Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 10,
                        ),
                        Customformfieldadd(
                          isPassword: false,
                          hinttext: "Enter your Email",
                          icon: Icons.email,
                          mycontrolotr: email,
                          validator: (val) {
                            if (val == "") {
                              return "can not be empyt";
                            }
                          },
                        ),
                        Container(
                          height: 15,
                        ),
                        Text(
                          "Password",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 10,
                        ),
                        Customformfieldadd(
                          isPassword: true, // ليس حقل كلمة مرور
                          hinttext: "Enter your Password",
                          icon: Icons.lock,
                          mycontrolotr: password,
                          validator: (val) {
                            if (val == "") {
                              return "can't be empty";
                            }
                          },
                        ),
                        Container(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () async {
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(email: email.text);
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 10, bottom: 20),
                            alignment: Alignment.topRight,
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                decoration: TextDecoration.underline,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomButton(
                    title: "Login",
                    onPressed: () async {
                      if (formState.currentState!.validate())
                        try {
                          isloading = true;
                          setState(() {});
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: email.text, password: password.text);
                          isloading = false;
                          setState(() {});
                          if (credential.user!.emailVerified) {
                            Navigator.of(context)
                                .pushReplacementNamed("homepage");
                          } else {
                            FirebaseAuth.instance.currentUser!
                                .sendEmailVerification();
                            print("go to tour account and verfiy your account");
                          }
                        } on FirebaseAuthException catch (e) {
                          isloading = false;
                          setState(() {});
                          print(ErrorConstants.registerErrorMessage(e.code));
                        }
                      else {
                        print("Not valid");
                      }
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
                  Text(
                    "or Login With",
                    textAlign: TextAlign.center,
                  ),
                  Padding(padding: EdgeInsets.only(top: 5, bottom: 5)),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    color: Color.fromARGB(255, 63, 149, 98),
                    textColor: Colors.white,
                    onPressed: () {
                      signInWithGoogle();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Login With Google   ",
                          //textAlign: TextAlign.left,
                        ),
                        Image.asset(
                          "images/icons8-google-40.png",
                          width: 30,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed("signup");
                    },
                    child: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(children: [
                          TextSpan(
                            text: "Don't Have Account ? ",
                          ),
                          TextSpan(
                              text: "Register ",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 64, 112, 179),
                                  fontWeight: FontWeight.bold)),
                        ])),
                  )
                ],
              ),
            ),
    );
  }
}
