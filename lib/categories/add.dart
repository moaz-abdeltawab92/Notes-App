import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/comoponents/customtextformfieldadd.dart';
import 'package:myapp/comoponents/loginboutton.dart';

class Addcatgeory extends StatefulWidget {
  const Addcatgeory({super.key});
  @override
  State<Addcatgeory> createState() => _Addcatgeory();
}

class _Addcatgeory extends State<Addcatgeory> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  CollectionReference categories =
      FirebaseFirestore.instance.collection("categories");
  bool isloading = false;
  addcatgeory() async {
    if (formState.currentState!.validate()) {
      try {
        isloading = true;

        await categories.add({"name": name.text});
        if (mounted) {
          setState(() {
            // Your state change code goes here
          });
        }
        //mounted
        if (mounted) {
          Navigator.of(context).pushReplacementNamed("homepage");
        }
      } catch (e) {
        print("Error $e");
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    name.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAAB396),
      appBar: AppBar(
        title: Text("Add Category"),
      ),
      body: Form(
        key: formState,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: Customformfieldadd(
                  isPassword: false,
                  hinttext: "Enter Name",
                  mycontrolotr: name,
                  validator: (val) {
                    if (val == "") {
                      return "Can not be empty";
                    }
                  }),
            ),
            CustomButton(
              title: "Add",
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("homepage", (Route) => false);
                addcatgeory();
              },
            )
          ],
        ),
      ),
    );
  }
}
/*Future<void> addUser() {
    isloading = true;
    setState(() {});
    Navigator.of(context).pushNamedAndRemoveUntil("homepage", (Route) => false);
    // Call the user's CollectionReference to add a new user
    return categories
        .add({"name": name.text, "id": FirebaseAuth.instance.currentUser?.uid})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }*/