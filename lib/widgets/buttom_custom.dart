
import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double sizeText;
  final Color colorButton;
  final Color colorText;
  final Color colorBorder;
  final widthCustom;
  final heightCustom;

  ButtonCustom({
    required this.onPressed,
    required this.text,
    required this.sizeText,
    required this.colorButton,
    required this.colorText,
    required this.colorBorder,
    required this.widthCustom,
    required this.heightCustom
  });

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: this.colorButton,
            minimumSize: Size(width*widthCustom!, height*heightCustom!),
            side: BorderSide(width: 3,color: colorBorder),
          ),
        onPressed: onPressed,
        child: Text(text,
            style: TextStyle(fontFamily: 'Nunito',color: colorText,fontSize: sizeText,fontWeight: FontWeight.bold)
        )
    );
  }
}
