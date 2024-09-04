import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myapp/categories/update.dart';
import 'package:myapp/note/view.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

// ignore: camel_case_types
class _homepageState extends State<homepage> {
  List<QueryDocumentSnapshot> data = [];
  bool isloading = true;

  getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("categories")
        // .where("id", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get();
    await Future.delayed(Duration(seconds: 1));
    data.addAll(querySnapshot.docs);
    setState(() {});
    isloading = false;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAAB396),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFF5EDED),
        onPressed: () {
          Navigator.of(context).pushNamed("addcatgory");
        },
        child: Image.asset(
          "images/icons8-add-folder-50.png",
          width: 40,
        ),
      ),
      appBar: AppBar(
        title: const Text('HomePage'),
        actions: [
          IconButton(
              onPressed: () async {
                GoogleSignIn googleSignIn = GoogleSignIn();
                googleSignIn.disconnect();
                await FirebaseAuth.instance.signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("Login", (route) => false);
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: isloading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisExtent: 160),
              itemCount: data.length,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            NoteView(categoryid: data[i].id)));
                  },
                  onLongPress: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.rightSlide,
                      title: 'Warnning...',
                      desc: 'What Do You Want? ',
                      btnCancelText: "Delete",
                      btnOkText: "Rename",
                      btnCancelOnPress: () async {
                        await FirebaseFirestore.instance
                            .collection("categories")
                            .doc(data[i].id)
                            .delete();
                        Navigator.of(context).pushReplacementNamed("homepage");
                      },
                      btnOkOnPress: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Editcategory(
                                docid: data[i].id, oldname: data[i]['name'])));
                      },
                    ).show();
                  },
                  child: Card(
                      color: Color(0xFFFFF8E8),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Image.asset(
                              "images/icons8-folder-50.png",
                              height: 100,
                            ),
                            Text("${data[i]['name']}")
                          ],
                        ),
                      )),
                );
              },
            ),
    );
  }
}
