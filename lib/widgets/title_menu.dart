
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pescandodireitocontroleweb/widgets/text_custom.dart';

import '../screens/navigation_screen.dart';
import '../utils/colors.dart';

class TitleMenu extends StatelessWidget {

  final text;
  final icon;
  final select;
  final index;
  final image;

  TitleMenu({
    required this.text,
    this.image = '',
    this.icon = Icons.help_outline,
    required this.index,
    this.select = false,
});

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: ()=> Navigator.pushReplacement(context, PageTransition(
        child: NavigationScreen(index: index),
        type: PageTransitionType.fade,
        duration: Duration.zero
      )),
      child: Container(
        margin: EdgeInsets.only(left: 20,bottom: 15),
        width: width,
        height: height*0.07,
        decoration: BoxDecoration(
          color: select ? PaletteColor.greyLight: PaletteColor.primaryColor,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),topLeft: Radius.circular(20)),
          border: Border.all(color: select ? PaletteColor.greyLight : PaletteColor.primaryColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 15),
            index==0?Icon(icon, color: select ? PaletteColor.primaryColor : PaletteColor.white,size: 35,)
                :Image.asset("images/$image.png",
                  width: 30,
                  height: 50,
                  color: select ? PaletteColor.primaryColor : PaletteColor.white,),
            SizedBox(width: 10),
            Container(
              width: width*0.08,
              child: TextCustom(
                size: 14.0,
                text: text,
                color: select ? PaletteColor.primaryColor : PaletteColor.white,
                textAlign: TextAlign.start,
                fontWeight: select ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
