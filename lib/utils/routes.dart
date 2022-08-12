

import 'package:flutter/material.dart';
import 'package:pescandodireitocontroleweb/screens/calendary_screen.dart';

import '../screens/governament_screen.dart';
import '../screens/login_screen.dart';
import '../screens/navigation_screen.dart';

class Routes{
    static Route<dynamic>? generateRoute(RouteSettings settings){
      final args = settings.arguments;

      switch(settings.name){
        case "/login" :
          return MaterialPageRoute(
              builder: (_) => LoginScreen()
          );
        case "/navigation" :
          return MaterialPageRoute(
              builder: (_) => NavigationScreen(index: 0)
          );
        case "/home" :
          return MaterialPageRoute(
              builder: (_) => GovernamentScreen()
          );
        case "/fees" :
          return MaterialPageRoute(
              builder: (_) => CalendaryScreen()
          );
        default :
          _erroRota();
      }
    }
    static  Route <dynamic> _erroRota(){
      return MaterialPageRoute(
          builder:(_){
            return Scaffold(
              appBar: AppBar(
                title: Text("Tela em desenvolvimento"),
              ),
              body: Center(
                child: Text("Tela em desenvolvimento"),
              ),
            );
          });
    }
  }