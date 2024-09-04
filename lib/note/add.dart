import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:myapp/comoponents/customtextformfieldadd.dart';
import 'package:myapp/comoponents/loginboutton.dart';
import 'package:myapp/comoponents/note_input_field.dart';
import 'package:myapp/note/view.dart';
//import 'package:path/path.dart';

class AddNote extends StatefulWidget {
  final String docid;
  const AddNote({super.key, required this.docid});
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  File? file;
  String? url;
  TextEditingController notecontroller = TextEditingController();

  bool isloading = false;

  addNote(context) async {
    CollectionReference collectionnote = FirebaseFirestore.instance
        .collection("categories")
        .doc(widget.docid)
        .collection("note");
    if (formState.currentState!.validate()) {
      try {
        isloading = true;
        setState(() {});
        DocumentReference response = await collectionnote
            .add({"note": notecontroller.text, "url": url ?? "none"});
        //mounted
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NoteView(categoryid: widget.docid)));
      } catch (e) {
        isloading = false;
        setState(() {});
        print("Error $e");
      }
    }
  }

  /*getImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      file = File(photo!.path);
      var imaname = basename(photo!.path);
      var refStorage = FirebaseStorage.instance.ref("images/$imaname");
      await refStorage.putFile(file!);
      url = await refStorage.getDownloadURL();
    }
    setState(() {});
  }*/

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
        title: Text("Add Note"),
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
            /*CustomButtonUpload(
              title: "Upload Image",
              isselected: url == null ? false : true,
              onPressed: () async {
                await getImage();
              },
            ),*/
            CustomButton(
              title: "Add",
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("homepage", (oute) => false);
                addNote(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
