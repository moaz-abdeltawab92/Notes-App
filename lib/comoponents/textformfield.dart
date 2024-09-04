import 'package:flutter/material.dart';

class Customformfield extends StatelessWidget {
  final String hinttext;
  final TextEditingController mycontrolotr;
  final String? Function(String?)? validator;
  const Customformfield(
      {super.key,
      required this.hinttext,
      required this.mycontrolotr,
      required this.validator,
      required IconData icon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: mycontrolotr,
      decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide:
                  BorderSide(color: const Color.fromARGB(255, 221, 220, 220))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide:
                  BorderSide(color: const Color.fromARGB(255, 211, 208, 208)))),
    );
  }
}
