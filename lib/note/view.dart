import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myapp/categories/update.dart';
import 'package:myapp/note/add.dart';
import 'package:myapp/note/edit.dart';
import 'package:myapp/note/view.dart';

class NoteView extends StatefulWidget {
  final String categoryid;
  const NoteView({
    super.key,
    required this.categoryid,
  });

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  List<QueryDocumentSnapshot> data = [];
  bool isloading = true;

  getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("categories")
        .doc(widget.categoryid)
        .collection("note")
        .get();
    data.addAll(querySnapshot.docs);
    isloading = false;
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAAB396),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFF5EDED),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddNote(docid: widget.categoryid)));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Note'),
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
              itemCount: data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisExtent: 160),
              itemBuilder: (context, i) {
                return InkWell(
                  onLongPress: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.rightSlide,
                      title: 'Warnning...',
                      desc: 'Sure To Delete? ',
                      btnCancelOnPress: () async {},
                      btnOkOnPress: () async {
                        await FirebaseFirestore.instance
                            .collection("categories")
                            .doc(widget.categoryid)
                            .collection("note")
                            .doc(data[i].id)
                            .delete();

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                NoteView(categoryid: widget.categoryid)));
                      },
                    ).show();
                  },
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditNote(
                            notedocid: data[i].id,
                            categorydocid: widget.categoryid,
                            value: data[i]['note'])));
                  },
                  child: Card(
                      child: Container(
                    color: Color(0xFFFFF8E8),
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Text("${data[i]['note']}"),
                      ],
                    ),
                  )),
                );
              },
            ),
    );
  }
}
