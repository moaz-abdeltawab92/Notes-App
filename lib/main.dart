import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myapp/auth/login.dart';
import 'package:myapp/categories/add.dart';
import 'package:myapp/firebase_options.dart';
//import 'package:myapp/auth/signup.dart';
import 'package:myapp/homeoage.dart';
import 'auth/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('=======================User is currently signed out!');
      } else {
        print('========================User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          // scaffoldBackgroundColor: Colors.red,
          appBarTheme: AppBarTheme(
              backgroundColor: Color(0xFFAAB396),
              titleTextStyle: TextStyle(
                  color: const Color.fromARGB(255, 248, 245, 245),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              iconTheme: IconThemeData(
                color: const Color.fromARGB(255, 241, 235, 235),
              ))),
      debugShowCheckedModeBanner: false,
      home: Signup(),
      routes: {
        "signup": (context) => Signup(),
        "login": (context) => Login(),
        "homepage": (context) => homepage(),
        "addcatgory": (context) => Addcatgeory(),
      },
    );
  }
}
/*(FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified)
          ? homepage()
          : Login(),*/
//return Scaffold(
