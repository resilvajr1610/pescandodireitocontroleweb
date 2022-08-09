

import 'package:flutter/material.dart';
import 'package:pescandodireitocontroleweb/widgets/text_custom.dart';

import '../utils/colors.dart';

class ContainerQuestion extends StatelessWidget {

  final question;
  final answer;
  final onPressedShow;
  final onPressedDelete;
  final showQuestion;

  ContainerQuestion({
    required this.question,
    required this.answer,
    required this.onPressedShow,
    required this.onPressedDelete,
    required this.showQuestion,
});

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: width*0.6,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextCustom(
                text: question,
                color: PaletteColor.grey,
                fontWeight: FontWeight.bold,
                maxLines: 5,
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: onPressedShow,
              icon: Icon(showQuestion?Icons.arrow_drop_down:Icons.arrow_right,color: PaletteColor.greyInput,),
            ),
            IconButton(
              onPressed: onPressedDelete,
              icon: Icon(Icons.delete,color: PaletteColor.primaryColor,),
            ),
          ],
        ),
        showQuestion?Container(
          width: width*0.6,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextCustom(
            text: answer,
            color: PaletteColor.grey,
            maxLines: 10,
          ),
        ):Container(),
      ],
    );
  }
}
