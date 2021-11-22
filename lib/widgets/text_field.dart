import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldWidget extends StatelessWidget {
  final String fieldName;
  final TextEditingController controller;
  final int maxLength;
  final int maxLines;
  const TextFieldWidget({
    Key? key,
    required this.fieldName,
    required this.controller,
    required this.maxLength,
    required this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: TextField(
        controller: controller,
        maxLength: maxLength,
        maxLines: maxLines,
        cursorColor: Theme.of(context).primaryColor,
        style: GoogleFonts.crimsonText(
          color: Theme.of(context).primaryColor,
          fontSize: 25.0,
          fontWeight: FontWeight.w700,
        ),
        decoration: InputDecoration(
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            color: Theme.of(context).primaryColor,
          ),
          labelText: fieldName,
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 3,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}
