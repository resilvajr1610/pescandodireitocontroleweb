

import 'package:flutter/material.dart';

class Input extends StatelessWidget {

  final controller;
  final hint;
  final fontSize;
  final keyboardType;
  final width;
  //List<TextInputFormatter>? inputFormatters=[];
  final sizeIcon;
  final icons;
  final colorBorder;
  final background;
  int? maxline = 1;

  Input({
    required this.controller,
    required this.hint,
    required this.fontSize,
    required this.keyboardType,
    required this.width,
    //this.inputFormatters,
    this.maxline,
    this.sizeIcon = 0.0,
    this.icons= Icons.save,
    required this.colorBorder,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      alignment: Alignment.topCenter,
      width: this.width,
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: colorBorder)
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: this.controller,
              textAlign: TextAlign.start,
              keyboardType: this.keyboardType,
              textAlignVertical: TextAlignVertical.center,
              maxLines: maxline,
              style: TextStyle(
                color: Colors.black54,
                fontSize: this.fontSize,
              ),
              //inputFormatters:this.inputFormatters,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: this.hint,
                  hintStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: this.fontSize,
                  ),
              ),
            ),
          ),
          sizeIcon!= 0.0?Icon(icons,size: sizeIcon):Container(),
        ],
      ),
    );
  }
}
