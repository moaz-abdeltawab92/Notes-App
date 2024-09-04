import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/comoponents/customtextformfieldadd.dart';
import 'package:myapp/comoponents/loginboutton.dart';
import 'package:myapp/comoponents/note_input_field.dart';
import 'package:myapp/note/view.dart';

class EditNote extends StatefulWidget {
  final String notedocid;
  final String value;
  final String categorydocid;

  const EditNote(
      {super.key,
      required this.notedocid,
      required this.categorydocid,
      required this.value});
  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  TextEditingController notecontroller = TextEditingController();

  bool isloading = false;

  editNote() async {
    CollectionReference collectionnote = FirebaseFirestore.instance
        .collection("categories")
        .doc(widget.categorydocid)
        .collection("note");
    if (formState.currentState!.validate()) {
      try {
        isloading = true;
        setState(() {});

        await collectionnote
            .doc(widget.notedocid)
            .update({"note": notecontroller.text});
        //mounted
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NoteView(categoryid: widget.categorydocid)));
      } catch (e) {
        isloading = false;
        setState(() {});
        print("Error $e");
      }
    }
  }

  @override
  void initState() {
    notecontroller.text = widget.value;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    notecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAAB396),
      appBar: AppBar(
        title: Text("Edit"),
      ),
      body: Form(
        key: formState,
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: NoteInputField(
                  notecontroller: notecontroller,
                  hintText: "Enter note",
                )),
            CustomButton(
              title: "Save",
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("homepage", (Route) => false);
                editNote();
              },
            )
          ],
        ),
      ),
    );
  }
}
