// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/auth/error.dart';
import 'package:myapp/comoponents/customtextformfieldadd.dart';
import 'package:myapp/comoponents/iconapp.dart';
import 'package:myapp/comoponents/loginboutton.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  @override
  State<Signup> createState() => _LoginState();
}

class _LoginState extends State<Signup> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE2DAD6),
      body: Container(
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
                    "Sign up",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text("Sign up To Continue Using This App",
                      style: TextStyle(
                        color: Colors.grey,
                      )),
                  Container(
                    height: 10,
                  ),
                  Text(
                    "Username",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 5,
                  ),
                  Customformfieldadd(
                    isPassword: false,
                    hinttext: "Enter your Username",
                    icon: Icons.person,
                    mycontrolotr: username,
                    validator: (val) {
                      if (val == "") {
                        return "Can't be empty";
                      }
                    },
                  ),
                  Container(
                    height: 15,
                  ),
                  Text(
                    "Email",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 5,
                  ),
                  Customformfieldadd(
                    isPassword: false,
                    hinttext: "Enter your Email",
                    icon: Icons.email,
                    mycontrolotr: email,
                    validator: (val) {
                      if (val == "") {
                        return "Can't be empty";
                      }
                    },
                  ),
                  Container(
                    height: 15,
                  ),
                  Text(
                    "Password",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 5,
                  ),
                  Customformfieldadd(
                    isPassword: true,
                    hinttext: "Enter your Password",
                    icon: Icons.lock,
                    mycontrolotr: password,
                    validator: (val) {
                      if (val == "") {
                        return "Can't be empty";
                      }
                    },
                  ),
                  Container(
                    height: 15,
                  ),
                  Text(
                    "Confirm Password",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 5,
                  ),
                  Customformfieldadd(
                    isPassword: true,
                    hinttext: "Enter your Password",
                    icon: Icons.lock,
                    mycontrolotr: password,
                    validator: (val) {
                      if (val == "") {
                        return "Can't be empty";
                      }
                    },
                  ),
                  Container(
                    height: 20,
                  ),
                ],
              ),
            ),
            Container(
              height: 15,
            ),
            CustomButton(
              title: "Sign up",
              onPressed: () async {
                if (formState.currentState!.validate())
                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                    );
                    FirebaseAuth.instance.currentUser!.sendEmailVerification();
                    Navigator.of(context).pushReplacementNamed("login");
                  } on FirebaseAuthException catch (e) {
                    print(ErrorConstants.registerErrorMessage(e.code));
                  }
                else {
                  print("Not valid");
                }
              },
            ),
            Padding(padding: EdgeInsets.only(top: 10, bottom: 5)),
            Container(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed("login");
              },
              child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(children: [
                    TextSpan(
                      text: "Have an Account ? ",
                    ),
                    TextSpan(
                        text: "Login Here ",
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
