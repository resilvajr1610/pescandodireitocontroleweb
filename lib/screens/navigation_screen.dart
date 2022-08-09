
import 'package:flutter/material.dart';
import 'package:pescandodireitocontroleweb/screens/calendary_screen.dart';
import 'package:pescandodireitocontroleweb/screens/cologne_screen.dart';
import 'package:pescandodireitocontroleweb/screens/governament_screen.dart';
import 'package:pescandodireitocontroleweb/screens/questions_screen.dart';

import '../utils/colors.dart';
import '../widgets/menu.dart';

class NavigationScreen extends StatefulWidget {
  final index;

  NavigationScreen({required this.index});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {

  final listRoutes = [QuestionsScreen(),CalendaryScreen(),GovernamentScreen(),CologneScreen()];
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    currentIndex = widget.index;
    final width = MediaQuery.of(context).size.width;

    return width> 600?Scaffold(
      backgroundColor: PaletteColor.primaryColor,
      body: Flex(
        direction: Axis.horizontal,
        children: [
          Menu(index: currentIndex),
          Flexible(
              flex: 6,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),topLeft: Radius.circular(20)),
                    border: Border.all(color: PaletteColor.white ),
                  color: PaletteColor.white
                ),
                child: listRoutes[currentIndex]
              )
          )
        ],
      ),
    ):Image.asset("assets/image/favicon.jpeg",width: 50,fit: BoxFit.fitWidth,);
  }
}
