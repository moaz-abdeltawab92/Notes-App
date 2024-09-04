import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/comoponents/customtextformfieldadd.dart';
import 'package:myapp/comoponents/loginboutton.dart';

class Editcategory extends StatefulWidget {
  final String docid;
  final String oldname;

  const Editcategory({super.key, required this.docid, required this.oldname});
  @override
  State<Editcategory> createState() => _Editcategory();
}

class _Editcategory extends State<Editcategory> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
  bool isloading = false;
  editcategory() async {
    if (formState.currentState!.validate()) {
      try {
        isloading = true;
        setState(() {});
        await categories
            .doc(widget.docid)
            .set({"name": name.text}, SetOptions(merge: true));
        Navigator.of(context)
            .pushNamedAndRemoveUntil("homepage", (Route) => false);
      } catch (e) {
        isloading = false;
        setState(() {});
        print("Eroor $e");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    name.text = widget.oldname;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAAB396),
      appBar: AppBar(
        title: Text("Edit Category"),
      ),
      body: Form(
        key: formState,
        child: isloading
            ? Center(child: CircularProgressIndicator())
            : Column(
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
                    title: "Save",
                    onPressed: () {
                      editcategory();
                    },
                  )
                ],
              ),
      ),
    );
  }
}
