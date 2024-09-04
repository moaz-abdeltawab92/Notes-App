import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  const CustomButton({super.key, this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      color: Color.fromARGB(255, 64, 112, 179),
      textColor: Colors.white,
      onPressed: onPressed,
      child: Text(title),
    );
  }
}

class CustomButtonUpload extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final bool isselected;
  const CustomButtonUpload(
      {super.key,
      this.onPressed,
      required this.title,
      required this.isselected});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      color: isselected ? Colors.blue : Colors.red,
      textColor: Colors.white,
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
//heigth: 40
//minwidth 200