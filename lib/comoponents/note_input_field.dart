import 'package:flutter/material.dart';

class NoteInputField extends StatelessWidget {
  final TextEditingController notecontroller;
  final String hintText;

  const NoteInputField({
    Key? key,
    required this.hintText,
    required this.notecontroller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: notecontroller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.withOpacity(0.8)),
        filled: true,
        fillColor: const Color.fromARGB(255, 231, 230, 230),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              15), // يمكنك ضبطها على 0 إذا كنت تفضل زوايا حادة
          borderSide: BorderSide.none,
        ),
        contentPadding:
            EdgeInsets.only(left: 16, top: 16), // لضبط النص فوق عالشمال
      ),
      maxLines: null, // يجعل الحقل قابلاً للتمدد حسب الحاجة
      minLines: 13, // يحدد الحد الأدنى لعدد الأسطر وبالتالي يكبر الحقل
    );
  }
}
