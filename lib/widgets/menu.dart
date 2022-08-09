

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pescandodireitocontroleweb/widgets/title_menu.dart';

class Menu extends StatelessWidget {
  final index;

  Menu({required this.index});

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Flexible(
      flex: 1,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: height*0.2,
              width: height*0.2,
              child:Image.asset("images/logohome.png"),
            ),
            TitleMenu(
              index: 0,
              text: 'Perguntas e Respostas',
              select: this.index==0?true:false,
            ),
            TitleMenu(
              index: 1,
              text: 'Calendário',
              image: 'icon_calendar',
              select:  this.index==1?true:false,
            ),
            TitleMenu(
              index: 2,
              text: 'Órgãos do Governo',
              image: 'icon_brazil',
              select:  this.index==2?true:false,
            ),
            TitleMenu(
              index: 3,
              text: 'Colônia de Pescadores',
              image: 'icon_contacts',
              select:  this.index==3?true:false,
            ),
            Spacer(),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(24.0),
              child: IconButton(
                onPressed: ()=>FirebaseAuth.instance.signOut().then((value) =>Navigator.pushReplacementNamed(context, '/login')),
                icon: Icon(Icons.logout,color: Colors.white,size: 40,)
              ),
            )
          ],
        ),
      )
    );
  }
}
